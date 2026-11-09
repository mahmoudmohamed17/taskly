import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../config/error_handler/error_handler.dart';
import '../../../core/models/task_model.dart';
import '../../../core/repositories/task_repository.dart';
import '../../../core/utils/enums.dart';

part 'memories_list_state.dart';

@injectable
class MemoriesListCubit extends Cubit<MemoriesListState> {
  final TaskRepository _repo;
  StreamSubscription<Result<List<TaskModel>>>? _sub;

  MemoriesListCubit(this._repo) : super(const MemoriesListLoading());

  /// Starts watching memories, optionally filtered by [category].
  /// Safe to call multiple times — cancels any previous subscription first.
  void watch({TaskCategory? category}) {
    _sub?.cancel();
    emit(const MemoriesListLoading());

    _sub = _repo.watchTasks(category: category).listen((result) {
      result.fold(
        (error) => emit(MemoriesListError(error.messageKey)),
        (list) => emit(MemoriesListLoaded(memories: list, activeCategory: category)),
      );
    });
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
