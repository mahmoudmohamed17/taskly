import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../config/error_handler/error_handler.dart';
import '../../../core/models/task_model.dart';
import '../../../core/repositories/task_repository.dart';
import '../../../core/utils/enums.dart';

part 'search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  final TaskRepository _repo;

  StreamSubscription<Result<List<TaskModel>>>? _sub;
  Timer? _debounce;

  String _query = '';
  TaskCategory? _category;

  SearchCubit(this._repo) : super(const SearchInitial());

  // ── Public API ─────────────────────────────────────────────────────────────

  /// Called on every text-field change. Debounces 350 ms before hitting the DB.
  void onQueryChanged(String query) {
    _query = query.trim();
    _scheduleSearch();
  }

  /// Called when the user picks a category tag. Searches immediately.
  void onCategoryChanged(TaskCategory? category) {
    _category = category;
    _debounce?.cancel();
    _search();
  }

  /// Clears both query and category and resets to [SearchInitial].
  void clear() {
    _debounce?.cancel();
    _sub?.cancel();
    _query = '';
    _category = null;
    emit(const SearchInitial());
  }

  // ── Internal ───────────────────────────────────────────────────────────────

  void _scheduleSearch() {
    _debounce?.cancel();

    // If both query and category are empty → go straight back to initial state.
    if (_query.isEmpty && _category == null) {
      _sub?.cancel();
      emit(const SearchInitial());
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 350), _search);
  }

  void _search() {
    _sub?.cancel();
    emit(const SearchLoading());

    _sub = _repo.watchTasks(query: _query, category: _category).listen(
      (result) {
        if (isClosed) return;
        result.fold(
          (error) => emit(SearchError(error.messageKey)),
          (list) {
            if (list.isEmpty) {
              emit(SearchEmpty(query: _query, activeCategory: _category));
            } else {
              emit(
                SearchLoaded(
                  results: list,
                  query: _query,
                  activeCategory: _category,
                ),
              );
            }
          },
        );
      },
    );
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    _debounce?.cancel();
    return super.close();
  }
}
