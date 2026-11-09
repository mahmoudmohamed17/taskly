import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/error_handler/error_handler.dart';
import '../../../../core/models/task_model.dart';
import '../../../../core/repositories/task_repository.dart';

part 'memory_details_state.dart';

@injectable
class MemoryDetailsCubit extends Cubit<MemoryDetailsState> {
  final TaskRepository _repo;
  StreamSubscription<Result<TaskModel?>>? _sub;

  MemoryDetailsCubit(this._repo) : super(const MemoryDetailsLoading());

  /// Starts watching a single memory by [id].
  /// Emits [MemoryDetailsDeleted] if the memory is removed from elsewhere.
  void watch(int id) {
    _sub?.cancel();
    emit(const MemoryDetailsLoading());

    _sub = _repo.watchTask(id).listen(
      (result) {
        if (isClosed) return;
        result.fold(
          (error) => emit(MemoryDetailsError(error.messageKey)),
          (model) {
            if (model == null) {
              emit(const MemoryDetailsDeleted());
            } else {
              emit(MemoryDetailsLoaded(memory: model));
            }
          },
        );
      },
    );
  }

  /// Permanently deletes the memory and all its attachments.
  Future<void> deleteMemory(int id) async {
    final result = await _repo.deleteTask(id);
    result.fold(
      (error) => emit(MemoryDetailsError(error.messageKey)),
      (_) => emit(const MemoryDetailsDeleted()),
    );
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
