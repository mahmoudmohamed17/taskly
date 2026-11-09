import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../config/error_handler/error_handler.dart';
import '../database/app_database.dart';
import '../database/daos/tasks_dao.dart';
import '../models/attachment_model.dart';
import '../models/task_attachment_input.dart';
import '../models/task_model.dart';
import '../services/attachment_file_service.dart';
import '../utils/arabic_normalizer.dart';
import '../utils/enums.dart';
import 'task_repository.dart';

@LazySingleton(as: TaskRepository)
class TaskRepositoryImpl implements TaskRepository {
  final TasksDao _dao;
  final AttachmentFileService _fileService;

  new(this._dao, this._fileService);

  @override
  Future<Result<int>> addAttachment({
    required int memoryId,
    required TaskAttachmentInput attachment,
  }) => _attempt(
    () => _dao.insertAttachment(
      AttachmentsCompanion.insert(
        taskId: memoryId,
        type: attachment.type,
        fileName: attachment.name,
        relativePath: attachment.file.path,
        sizeBytes: Value(attachment.sizeBytes),
      ),
    ),
    (error) => AppError.memoryAttachmentFailed(cause: error),
  );

  @override
  Future<Result<List<int>>> addAttachments({
    required int memoryId,
    required List<TaskAttachmentInput> attachments,
  }) => _attempt(() async {
    if (attachments.isEmpty) return <int>[];

    final savedPaths = <String>[];
    try {
      final entries = <AttachmentsCompanion>[];
      for (final attachment in attachments) {
        final relativePath = await _fileService.save(attachment.file);
        savedPaths.add(relativePath);
        entries.add(
          AttachmentsCompanion.insert(
            taskId: memoryId,
            type: attachment.type,
            relativePath: relativePath,
            fileName: attachment.name,
            sizeBytes: Value(attachment.sizeBytes),
          ),
        );
      }
      return await _dao.insertManyAttachments(entries);
    } catch (_) {
      await _fileService.deleteAll(savedPaths);
      rethrow;
    }
  }, (error) => AppError.memoryAttachmentFailed(cause: error));

  @override
  Future<Result<int>> addTask({
    required String title,
    String description = '',
    required TaskCategory category,
  }) => _attempt(
    () => _dao.insertTask(
      TasksCompanion.insert(
        title: title.trim(),
        description: Value(description.trim()),
        normalizedText: Value(_searchText(title, description)),
        category: category,
      ),
    ),
    (error) => AppError.memorySaveFailed(cause: error),
  );

  @override
  Future<Result<Unit>> deleteTask(int id) => _attempt(() async {
    final paths = await _dao.deleteTask(id);
    await _fileService.deleteAll(paths);
    return unit;
  }, (error) => AppError.memoryDeleteFailed(cause: error));

  @override
  Future<Result<Unit>> removeAttachment(int attachmentId) => _attempt(() async {
    final path = await _dao.deleteAttachment(attachmentId);
    if (path != null) await _fileService.delete(path);
    return unit;
  }, (error) => AppError.memoryAttachmentFailed(cause: error));

  @override
  Future<Result<Unit>> updateTask({
    required int id,
    required String title,
    required String description,
    required TaskCategory category,
  }) => _attempt(
    () async {
      await _dao.updateTask(
        id,
        TasksCompanion(
          title: Value(title.trim()),
          description: Value(description.trim()),
          normalizedText: Value(_searchText(title, description)),
          category: Value(category),
          updatedAt: Value(DateTime.now()),
        ),
      );
      return unit;
    },
    (error) => AppError.memoryUpdateFailed(cause: error),
  );

  @override
  Future<Result<Unit>> updateTaskWithAttachments({
    required int id,
    required String title,
    required String description,
    required TaskCategory category,
    required List<TaskAttachmentInput> additions,
    required List<int> removals,
  }) => _attempt(() async {
    final savedPaths = <String>[];
    late final List<String> removedPaths;
    try {
      final entries = <AttachmentsCompanion>[];
      for (final attachment in additions) {
        final relativePath = await _fileService.save(attachment.file);
        savedPaths.add(relativePath);
        entries.add(
          AttachmentsCompanion.insert(
            taskId: id,
            type: attachment.type,
            relativePath: relativePath,
            fileName: attachment.name,
            sizeBytes: Value(attachment.sizeBytes),
          ),
        );
      }

      removedPaths = await _dao.updateTaskWithAttachments(
        taskId: id,
        task: TasksCompanion(
          title: Value(title.trim()),
          description: Value(description.trim()),
          normalizedText: Value(_searchText(title, description)),
          category: Value(category),
          updatedAt: Value(DateTime.now()),
        ),
        additions: entries,
        removals: removals,
      );
    } catch (_) {
      await _fileService.deleteAll(savedPaths);
      rethrow;
    }
    await _fileService.deleteAll(removedPaths);
    return unit;
  }, (error) => AppError.memoryUpdateFailed(cause: error));

  @override
  Stream<Result<List<TaskModel>>> watchTasks({TaskCategory? category, String query = ''}) {
    return _watch(
      _dao
          .watchAll(
            category: category,
            normalizedQuery: ArabicNormalizer.normalize(query),
          )
          .map((list) => list.map(_toModel).toList()),
      (error) => AppError.storageReadFailed(cause: error),
    );
  }

  @override
  Stream<Result<TaskModel?>> watchTask(int id) => _watch(
    _dao.watchOne(id).map((d) => d == null ? null : _toModel(d)),
    (error) => AppError.storageReadFailed(cause: error),
  );

  Future<Result<T>> _attempt<T>(Future<T> Function() action, AppError Function(Object) fallback) async {
    try {
      return Right(await action());
    } catch (error) {
      return Left(ErrorHandler.normalize(error, fallback: fallback));
    }
  }

  Stream<Result<T>> _watch<T>(Stream<T> stream, AppError Function(Object) fallback) => stream.transform(
    StreamTransformer<T, Result<T>>.fromHandlers(
      handleData: (value, sink) => sink.add(Right(value)),
      handleError: (error, _, sink) {
        final normalized = ErrorHandler.normalize(error, fallback: fallback);
        sink.add(Left(normalized));
      },
    ),
  );

  // Helpers
  String _searchText(String title, String body) => ArabicNormalizer.normalize('$title $body');

  TaskModel _toModel(TaskWithDetails d) {
    final model = d.task;
    final attachments = d.attachments.map((item) => _toAttachment(item)).toList();

    return TaskModel(
      id: model.id,
      title: model.title,
      description: model.description,
      attachments: attachments,
      category: model.category,
      creationDate: model.createdAt,
      lastUpdateDate: model.updatedAt,
    );
  }

  AttachmentModel _toAttachment(Attachment a) {
    return AttachmentModel(
      attachmentId: a.id,
      memoryId: a.taskId,
      fileName: a.fileName,
      type: a.type,
      sizeBytes: a.sizeBytes,
    );
  }
}
