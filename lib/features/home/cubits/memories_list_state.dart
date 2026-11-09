part of 'memories_list_cubit.dart';

sealed class MemoriesListState {
  const MemoriesListState();
}

final class MemoriesListLoading extends MemoriesListState {
  const MemoriesListLoading();
}

final class MemoriesListLoaded extends MemoriesListState {
  final List<TaskModel> memories;
  final TaskCategory? activeCategory;

  const MemoriesListLoaded({
    required this.memories,
    this.activeCategory,
  });
}

final class MemoriesListError extends MemoriesListState {
  final String message;

  const MemoriesListError(this.message);
}
