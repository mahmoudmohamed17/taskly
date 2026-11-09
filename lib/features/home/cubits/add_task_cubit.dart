import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/models/task_attachment_input.dart';
import '../../../core/repositories/task_repository.dart';
import '../../../core/utils/enums.dart';

part 'add_task_state.dart';

@injectable
class AddTaskCubit extends Cubit<AddTaskState> {
  final TaskRepository _repo;
  final List<TaskAttachmentInput> _selectedAttachments = [];

  AddTaskCubit(this._repo) : super(const AddTaskInitial());

  Future<void> pickAttachments() async {
    final List<PlatformFile> files = await FilePicker.pickFiles();

    if (files.isEmpty) return;

    emit(const AddTaskAttachmentsLoading());

    for (final file in files) {
      final path = file.path;
      if (path == null) continue;
      final type = AttachmentType.fromExtension(file.extension);
      if (_selectedAttachments.any((item) => item.file.path == path)) continue;
      final size = await file.length();
      _selectedAttachments.add(
        TaskAttachmentInput(
          file: File(path),
          name: file.name,
          type: type,
          sizeBytes: size ?? 0,
        ),
      );
    }
    emit(AddTaskAttachmentsUpdated(_selectedAttachments));
  }

  Future<void> removeAttachment(TaskAttachmentInput input) async {
    _selectedAttachments.removeWhere((item) => item == input);
    emit(AddTaskAttachmentsUpdated(_selectedAttachments));
  }

  /// Inserts a new memory and emits [AddTaskSuccess] with the generated id.
  Future<void> addMemory({
    required String title,
    required String description,
    required TaskCategory category,
    List<TaskAttachmentInput>? attachments,
  }) async {
    emit(const AddTaskLoading());
    final result = await _repo.addTask(
      title: title,
      description: description,
      category: category,
    );
    await result.fold(
      (error) async => emit(AddTaskError(error.messageKey)),
      (id) async {
        addAttachments(id);
        _selectedAttachments.clear();
        emit(AddTaskSuccess(newMemoryId: id));
      },
    );
  }

  Future<void> addAttachments(int memoryId) async {
    if (_selectedAttachments.isEmpty) return;

    final attachmentsResult = await _repo.addAttachments(
      memoryId: memoryId,
      attachments: List.unmodifiable(_selectedAttachments),
    );

    final hasError = attachmentsResult.fold((_) => true, (_) => false);
    if (hasError) {
      attachmentsResult.fold(
        (error) => emit(AddTaskError(error.messageKey)),
        (_) {},
      );
      return;
    }
  }

  /// Attaches a file to an already-created memory.
  Future<void> addAttachment({
    required int memoryId,
    required TaskAttachmentInput attachment,
    int sizeBytes = 0,
  }) async {
    final result = await _repo.addAttachment(
      memoryId: memoryId,
      attachment: attachment,
    );
    result.fold(
      (error) => emit(AddTaskError(error.messageKey)),
      (_) {},
    );
  }

  /// Resets to [AddTaskInitial] so the form can be reused in the same session.
  void reset() {
    _selectedAttachments.clear();
    emit(const AddTaskInitial());
  }
}
