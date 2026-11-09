import 'package:dartz/dartz.dart';

import '../../config/error_handler/error_handler.dart';
import '../models/task_attachment_input.dart';
import '../models/task_model.dart';
import '../utils/enums.dart';

abstract class TaskRepository {
  Stream<Result<List<TaskModel>>> watchTasks({
    TaskCategory? category,
    String query = '',
  });

  Stream<Result<TaskModel?>> watchTask(int id);

  Future<Result<int>> addTask({
    required String title,
    String description = '',
    required TaskCategory category,
  });

  Future<Result<Unit>> updateTask({
    required int id,
    required String title,
    required String description,
    required TaskCategory category,
  });

  Future<Result<Unit>> updateTaskWithAttachments({
    required int id,
    required String title,
    required String description,
    required TaskCategory category,
    required List<TaskAttachmentInput> additions,
    required List<int> removals,
  });

  Future<Result<Unit>> deleteTask(int id);

  Future<Result<int>> addAttachment({
    required int memoryId,
    required TaskAttachmentInput attachment,
  });

  Future<Result<List<int>>> addAttachments({
    required int memoryId,
    required List<TaskAttachmentInput> attachments,
  });

  Future<Result<Unit>> removeAttachment(int attachmentId);
}
