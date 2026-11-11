import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/main_shell/main_shell.dart';
import '../../features/task_details/presentation/cubits/edit_memory_cubit.dart';
import '../../features/task_details/presentation/cubits/memory_details_cubit.dart';
import '../../features/task_details/presentation/screens/edit_task_screen.dart';
import '../../features/task_details/presentation/screens/task_details_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/search/presentation/screens/search_screen.dart';
import '../../features/search/presentation/screens/voice_search_results_screen.dart';
import '../cubits/app_flow_cubit.dart';
import '../di/di.dart';
import '../models/task_model.dart';
import 'app_routes.dart';
import 'go_router_listenable_builder.dart';
import 'page_transition_builder.dart';

class AppRouter {
  /// Single GoRouter instance, created once after [getIt.allReady()].
  static final GoRouter router = _createRouter();

  static GoRouter _createRouter() {
    final appFlowCubit = getIt<AppFlowCubit>();

    return GoRouter(
      // Re-evaluates redirect every time AppFlowCubit emits a new state.
      refreshListenable: GoRouterListenableBuilder(appFlowCubit.stream),
      redirect: (context, state) => appFlowCubit.resolveRedirect(state.matchedLocation),
      routes: [
        _route(
          AppRoutes.onboarding,
          builder: (context, state) => const OnboardingScreen(),
        ),
        _route(
          AppRoutes.mainShell,
          builder: (context, state) => const MainShell(),
        ),
        _route(
          AppRoutes.search,
          builder: (context, state) => const SearchScreen(),
        ),
        _route(
          AppRoutes.voiceSearchResults,
          transition: PageTransitionType.fadeSlide,
          builder: (context, state) => const VoiceSearchResultsScreen(),
        ),
        _route(
          AppRoutes.taskDetails,
          transition: PageTransitionType.fadeSlide,
          builder: (context, state) {
            final model = state.extra as TaskModel;
            return BlocProvider(
              create: (_) => getIt<MemoryDetailsCubit>()..watch(model.id),
              child: TaskDetailsScreen(model: model),
            );
          },
        ),
        _route(
          AppRoutes.taskEdit,
          transition: PageTransitionType.fadeSlide,
          builder: (context, state) {
            final model = state.extra as TaskModel;
            return BlocProvider(
              create: (_) => getIt<EditMemoryCubit>(),
              child: EditTaskScreen(model: model),
            );
          },
        ),
      ],
    );
  }

  static GoRoute _route(
    String path, {
    required Widget Function(BuildContext context, GoRouterState state) builder,
    String? Function(BuildContext context, GoRouterState state)? redirect,
    List<RouteBase> routes = const [],
    PageTransitionType transition = PageTransitionType.platformAdaptive,
  }) {
    return GoRoute(
      path: path,
      redirect: redirect,
      routes: routes,
      pageBuilder: (context, state) {
        final child = builder(context, state);
        return PageTransitionBuilder.build(
          child: child,
          key: state.pageKey,
          transition: transition,
        );
      },
    );
  }
}
