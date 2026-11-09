import 'package:drift/drift.dart';

import '../../utils/enums.dart';

@TableIndex(name: 'tasks_category_idx', columns: {#category})
@TableIndex(name: 'tasks_updated_idx', columns: {#updatedAt})
class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().withDefault(const Constant(''))();
  TextColumn get category => textEnum<TaskCategory>()();

  /// Title + Description after ArabicNormalizer. Used only for search.
  TextColumn get normalizedText => text().withDefault(const Constant(''))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
