import 'package:drift/drift.dart';

import '../../utils/enums.dart';
import '../app_database.dart';
import '../tables/attachments.dart';
import '../tables/tasks.dart';

part 'tasks_dao.g.dart';

/// A memory row together with its children.
class TaskWithDetails {
  final Task task;
  final List<Attachment> attachments;

  new({required this.task, required this.attachments});
}

class _Acc {
  _Acc(this.task);

  final Task task;
  final Map<int, Attachment> attachments = {};
}

@DriftAccessor(tables: [Tasks, Attachments])
class TasksDao extends DatabaseAccessor<AppDatabase> with _$TasksDaoMixin {
  new(super.db);

  // ───────────────────────── Reads ─────────────────────────
  Stream<List<TaskWithDetails>> watchAll({
    TaskCategory? category,
    String normalizedQuery = '',
  }) {
    final filters = <Expression<bool>>[
      if (category != null) tasks.category.equalsValue(category),
      if (normalizedQuery.isNotEmpty) tasks.normalizedText.contains(normalizedQuery),
    ];
    return _watchJoined(filters);
  }

  Stream<TaskWithDetails?> watchOne(int id) {
    return _watchJoined([tasks.id.equals(id)]).map((list) => list.isEmpty ? null : list.first);
  }

  Stream<List<TaskWithDetails>> _watchJoined(List<Expression<bool>> filters) {
    final query = select(tasks).join([
      leftOuterJoin(attachments, attachments.taskId.equalsExp(tasks.id)),
    ]);
    if (filters.isNotEmpty) {
      query.where(filters.reduce((a, b) => a & b));
    }
    query.orderBy([OrderingTerm.desc(tasks.updatedAt)]);
    return query.watch().map(_group);
  }

  List<TaskWithDetails> _group(List<TypedResult> rows) {
    final map = <int, _Acc>{}; // insertion order = query order

    for (final row in rows) {
      final task = row.readTable(tasks);
      final acc = map.putIfAbsent(task.id, () => _Acc(task));
      final attachment = row.readTableOrNull(attachments);
      if (attachment != null) acc.attachments[attachment.id] = attachment;
    }
    return [
      for (final a in map.values) TaskWithDetails(task: a.task, attachments: a.attachments.values.toList()),
    ];
  }

  // ───────────────────────── Memories ─────────────────────────
  Future<int> insertTask(TasksCompanion entry) => into(tasks).insert(entry);

  Future<void> updateTask(int id, TasksCompanion change) =>
      (update(tasks)..where((t) => t.id.equals(id))).write(change);

  /// Applies a memory edit and its attachment changes in one database transaction.
  /// Returns paths for removed attachments so the repository can delete the files
  /// after the transaction commits.
  Future<List<String>> updateTaskWithAttachments({
    required int taskId,
    required TasksCompanion task,
    required List<AttachmentsCompanion> additions,
    required List<int> removals,
  }) => transaction(() async {
    final removedPaths = <String>[];
    for (final attachmentId in removals) {
      final row = await (select(attachments)..where((a) => a.id.equals(attachmentId))).getSingleOrNull();
      if (row == null || row.taskId != taskId) continue;
      removedPaths.add(row.relativePath);
      await (delete(attachments)..where((a) => a.id.equals(attachmentId))).go();
    }

    await updateTask(taskId, task);
    for (final entry in additions) {
      await into(attachments).insert(entry);
    }
    return removedPaths;
  });

  Future<List<String>> deleteTask(int id) {
    return transaction(() async {
      final paths =
          (select(attachments)..where(
                (a) => a.taskId.equals(id),
              ))
              .map((a) => a.relativePath)
              .get();
      await (delete(tasks)..where((t) => t.id.equals(id))).go();
      return paths;
    });
  }

  // ───────────────────────── Attachments ─────────────────────────
  Future<int> insertAttachment(AttachmentsCompanion entry) {
    return transaction(() async {
      final id = into(attachments).insert(entry);
      await _touch(entry.taskId.value);
      return id;
    });
  }

  Future<List<int>> insertManyAttachments(List<AttachmentsCompanion> entries) {
    return transaction(() async {
      if (entries.isEmpty) return <int>[];

      final taskIds = <int>{};
      final ids = <int>[];
      for (final entry in entries) {
        ids.add(await into(attachments).insert(entry));
        taskIds.add(entry.taskId.value);
      }
      for (final taskId in taskIds) {
        await _touch(taskId);
      }
      return ids;
    });
  }

  /// Returns the removed file's relative path (or null if not found).
  Future<String?> deleteAttachment(int id) {
    return transaction(() async {
      final row = await (select(attachments)..where((a) => a.id.equals(id))).getSingleOrNull();
      if (row == null) return null;

      await (delete(attachments)..where((a) => a.id.equals(id))).go();
      await _touch(row.taskId);
      return row.relativePath;
    });
  }

  // ───────────────────────── Helpers ─────────────────────────

  Future<void> _touch(int taskId) => updateTask(
    taskId,
    TasksCompanion(updatedAt: Value(DateTime.now())),
  );
}
