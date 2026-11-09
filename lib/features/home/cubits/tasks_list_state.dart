part of 'tasks_list_cubit.dart';

sealed class TasksListState {
  const TasksListState();
}

final class TasksListLoading extends TasksListState {
  const TasksListLoading();
}

final class TasksListLoaded extends TasksListState {
  final List<TaskModel> tasks;
  final TaskCategory? activeCategory;

  const TasksListLoaded({
    required this.tasks,
    this.activeCategory,
  });
}

final class TasksListError extends TasksListState {
  final String message;

  const TasksListError(this.message);
}
