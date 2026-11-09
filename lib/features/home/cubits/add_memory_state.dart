part of 'add_memory_cubit.dart';

sealed class AddMemoryState {
  const AddMemoryState();
}

final class AddMemoryInitial extends AddMemoryState {
  const AddMemoryInitial();
}

final class AddMemoryLoading extends AddMemoryState {
  const AddMemoryLoading();
}

final class AddMemoryAttachmentsEmpty extends AddMemoryState {
  const AddMemoryAttachmentsEmpty();
}

final class AddMemoryAttachmentsUpdated extends AddMemoryState {
  final List<TaskAttachmentInput> attachments;

  const AddMemoryAttachmentsUpdated(this.attachments);
}

final class AddMemorySuccess extends AddMemoryState {
  /// The database-generated row id of the newly created memory.
  final int newMemoryId;

  const AddMemorySuccess({required this.newMemoryId});
}

final class AddMemoryError extends AddMemoryState {
  final String message;

  const AddMemoryError(this.message);
}
