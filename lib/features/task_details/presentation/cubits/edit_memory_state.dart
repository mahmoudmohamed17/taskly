part of 'edit_memory_cubit.dart';

sealed class EditMemoryState {
  const EditMemoryState();
}

final class EditMemoryInitial extends EditMemoryState {
  const EditMemoryInitial();
}

final class EditMemoryLoading extends EditMemoryState {
  const EditMemoryLoading();
}

final class EditMemorySuccess extends EditMemoryState {
  const EditMemorySuccess();
}

final class EditAttachmentsUpdated extends EditMemoryState {
  final List<AttachmentModel> keptAttachments;
  final List<TaskAttachmentInput> selectedAttachments;

  const EditAttachmentsUpdated({
    required this.keptAttachments,
    required this.selectedAttachments,
  });
}

final class EditMemoryError extends EditMemoryState {
  final String message;

  const EditMemoryError(this.message);
}
