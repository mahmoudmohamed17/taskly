import 'package:drift/drift.dart';

import '../utils/enums.dart';
import 'daos/tasks_dao.dart';
import 'tables/attachments.dart';
import 'tables/tasks.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Tasks, Attachments], daos: [TasksDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    beforeOpen: (details) async {
      // Required for ON DELETE CASCADE to work in SQLite.
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
