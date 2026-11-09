part of 'search_cubit.dart';

sealed class SearchState {
  const SearchState();
}

/// Before the user has typed anything — show recent searches (if any).
final class SearchInitial extends SearchState {
  const SearchInitial();
}

/// Waiting for the debounce timer or the first DB emission.
final class SearchLoading extends SearchState {
  const SearchLoading();
}

/// At least one result was found for the current [query] / [activeCategory].
final class SearchLoaded extends SearchState {
  final List<TaskModel> results;
  final String query;
  final TaskCategory? activeCategory;

  const SearchLoaded({
    required this.results,
    required this.query,
    this.activeCategory,
  });
}

/// A query was executed but returned zero results.
final class SearchEmpty extends SearchState {
  final String query;
  final TaskCategory? activeCategory;

  const SearchEmpty({required this.query, this.activeCategory});
}

final class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);
}
