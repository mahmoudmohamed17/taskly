part of 'memory_details_cubit.dart';

sealed class MemoryDetailsState {
  const MemoryDetailsState();
}

final class MemoryDetailsLoading extends MemoryDetailsState {
  const MemoryDetailsLoading();
}

final class MemoryDetailsLoaded extends MemoryDetailsState {
  final TaskModel memory;

  const MemoryDetailsLoaded({required this.memory});
}

/// Emitted when [TaskRepository.deleteTask] succeeds, or when the watched
/// memory disappears from the DB (e.g. deleted from another screen).
/// The UI should respond by navigating back.
final class MemoryDetailsDeleted extends MemoryDetailsState {
  const MemoryDetailsDeleted();
}

final class MemoryDetailsError extends MemoryDetailsState {
  final String message;

  const MemoryDetailsError(this.message);
}
