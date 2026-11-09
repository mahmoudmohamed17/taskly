import 'package:drift/drift.dart';

import '../../utils/enums.dart';
import 'tasks.dart';

class Attachments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get taskId => integer().references(Tasks, #id, onDelete: KeyAction.cascade)();
  TextColumn get type => textEnum<AttachmentType>()();
  TextColumn get fileName => text()();
  IntColumn get sizeBytes => integer().withDefault(const Constant(0))();
  TextColumn get relativePath => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
