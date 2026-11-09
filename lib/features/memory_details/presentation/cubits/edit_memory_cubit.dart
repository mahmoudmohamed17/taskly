import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/attachment_model.dart';
import '../../../../core/models/task_attachment_input.dart';
import '../../../../core/repositories/task_repository.dart';
import '../../../../core/utils/enums.dart';

part 'edit_memory_state.dart';

@injectable
class EditMemoryCubit extends Cubit<EditMemoryState> {
  final TaskRepository _repo;
  List<AttachmentModel> _keptAttachments = [];
  final List<TaskAttachmentInput> _selectedAttachments = [];
  Set<int> _initialAttachmentIds = {};

  EditMemoryCubit(this._repo) : super(const EditMemoryInitial());

  List<AttachmentModel> get keptAttachments => List.unmodifiable(_keptAttachments);
  List<TaskAttachmentInput> get selectedAttachments => List.unmodifiable(_selectedAttachments);

  bool get hasAttachmentChanges =>
      !_keptAttachments.map((item) => item.attachmentId).toSet().containsAll(_initialAttachmentIds) ||
      !_initialAttachmentIds.containsAll(_keptAttachments.map((item) => item.attachmentId)) ||
      _selectedAttachments.isNotEmpty;

  void initializeAttachments(List<AttachmentModel> attachments) {
    _keptAttachments = List.of(attachments);
    _initialAttachmentIds = attachments.map((item) => item.attachmentId).toSet();
    _selectedAttachments.clear();
    _emitAttachmentsUpdated();
  }

  Future<void> updateMemory({
    required int id,
    required String title,
    required String description,
    required TaskCategory category,
  }) async {
    emit(const EditMemoryLoading());
    final result = await _repo.updateTaskWithAttachments(
      id: id,
      title: title,
      description: description,
      category: category,
      additions: List.unmodifiable(_selectedAttachments),
      removals: _initialAttachmentIds.difference(
        _keptAttachments.map((item) => item.attachmentId).toSet(),
      ).toList(),
    );
    result.fold(
      (error) => emit(EditMemoryError(error.messageKey)),
      (_) {
        _selectedAttachments.clear();
        emit(const EditMemorySuccess());
      },
    );
  }

  Future<void> pickAttachments() async {
    if (state is EditMemoryLoading) return;

    final files = await FilePicker.pickFiles();
    if (files.isEmpty || state is EditMemoryLoading) return;

    for (final file in files) {
      final path = file.path;
      if (path == null || _selectedAttachments.any((item) => item.file.path == path)) continue;
      final size = await file.length();
      _selectedAttachments.add(
        TaskAttachmentInput(
          file: File(path),
          name: file.name,
          type: AttachmentType.fromExtension(file.extension),
          sizeBytes: size ?? 0,
        ),
      );
    }
    _emitAttachmentsUpdated();
  }

  void removeExistingAttachment(int attachmentId) {
    if (state is EditMemoryLoading) return;
    _keptAttachments.removeWhere((item) => item.attachmentId == attachmentId);
    _emitAttachmentsUpdated();
  }

  void removeSelectedAttachment(TaskAttachmentInput input) {
    if (state is EditMemoryLoading) return;
    _selectedAttachments.remove(input);
    _emitAttachmentsUpdated();
  }

  void _emitAttachmentsUpdated() => emit(
    EditAttachmentsUpdated(
      keptAttachments: List.unmodifiable(_keptAttachments),
      selectedAttachments: List.unmodifiable(_selectedAttachments),
    ),
  );

  void reset() {
    _keptAttachments = [];
    _selectedAttachments.clear();
    _initialAttachmentIds = {};
    emit(const EditMemoryInitial());
  }
}
