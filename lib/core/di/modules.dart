import 'package:drift_flutter/drift_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/app_database.dart';
import '../database/daos/tasks_dao.dart';

@module
abstract class Modules {
  @preResolve
  @singleton
  Future<SharedPreferences> get sharedPreferences => SharedPreferences.getInstance();

  @singleton
  AppDatabase get database => AppDatabase(driftDatabase(name: 'app_db'));

  @lazySingleton
  TasksDao memoriesDao(AppDatabase db) => db.tasksDao;
}
