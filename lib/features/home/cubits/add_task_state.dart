part of 'add_task_cubit.dart';

sealed class AddTaskState {
  const AddTaskState();
}

final class AddTaskInitial extends AddTaskState {
  const AddTaskInitial();
}

final class AddTaskLoading extends AddTaskState {
  const AddTaskLoading();
}

final class AddTaskAttachmentsEmpty extends AddTaskState {
  const AddTaskAttachmentsEmpty();
}

final class AddTaskAttachmentsLoading extends AddTaskState {
  const AddTaskAttachmentsLoading();
}

final class AddTaskAttachmentsUpdated extends AddTaskState {
  final List<TaskAttachmentInput> attachments;

  const AddTaskAttachmentsUpdated(this.attachments);
}

final class AddTaskSuccess extends AddTaskState {
  /// The database-generated row id of the newly created memory.
  final int newMemoryId;

  const AddTaskSuccess({required this.newMemoryId});
}

final class AddTaskError extends AddTaskState {
  final String message;

  const AddTaskError(this.message);
}
