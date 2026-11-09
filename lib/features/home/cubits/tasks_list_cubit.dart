import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../config/error_handler/error_handler.dart';
import '../../../core/models/task_model.dart';
import '../../../core/repositories/task_repository.dart';
import '../../../core/utils/enums.dart';

part 'tasks_list_state.dart';

@injectable
class TasksListCubit extends Cubit<TasksListState> {
  final TaskRepository _repo;
  StreamSubscription<Result<List<TaskModel>>>? _sub;

  TasksListCubit(this._repo) : super(const TasksListLoading());

  /// Starts watching memories, optionally filtered by [category].
  /// Safe to call multiple times — cancels any previous subscription first.
  void watch({TaskCategory? category}) {
    _sub?.cancel();
    emit(const TasksListLoading());

    _sub = _repo.watchTasks(category: category).listen((result) {
      result.fold(
        (error) => emit(TasksListError(error.messageKey)),
        (list) => emit(TasksListLoaded(tasks: list, activeCategory: category)),
      );
    });
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
