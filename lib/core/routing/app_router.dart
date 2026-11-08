import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/cubits/memories_list_cubit.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/memory_details/presentation/cubits/edit_memory_cubit.dart';
import '../../features/memory_details/presentation/cubits/memory_details_cubit.dart';
import '../../features/memory_details/presentation/screens/edit_memory_screen.dart';
import '../../features/memory_details/presentation/screens/memory_details_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/search/presentation/screens/search_screen.dart';
import '../../features/search/presentation/screens/voice_search_results_screen.dart';
import '../cubits/app_flow_cubit.dart';
import '../cubits/app_flow_state.dart';
import '../di/di.dart';
import '../models/memory_model.dart';
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
      redirect: (context, state) {
        final flowState = appFlowCubit.state;
        final currentPath = state.matchedLocation;

        // Guard: onboarding not done → always land on onboarding.
        if (flowState == AppFlowState.onboarding && currentPath != AppRoutes.onboarding) {
          return AppRoutes.onboarding;
        }

        // Guard: onboarding done → never show onboarding again.
        if (flowState == AppFlowState.home && currentPath == AppRoutes.onboarding) {
          return AppRoutes.home;
        }

        return null; // no redirect needed
      },
      routes: [
        _route(
          AppRoutes.onboarding,
          builder: (context, state) => const OnboardingScreen(),
        ),
        _route(
          AppRoutes.home,
          builder: (context, state) => BlocProvider(
            create: (_) => getIt<MemoriesListCubit>()..watch(),
            child: const HomeScreen(),
          ),
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
          AppRoutes.memoryDetails,
          transition: PageTransitionType.fadeSlide,
          builder: (context, state) {
            final model = state.extra as MemoryModel;
            return BlocProvider(
              create: (_) => getIt<MemoryDetailsCubit>()..watch(model.id),
              child: MemoryDetailsScreen(model: model),
            );
          },
        ),
        _route(
          AppRoutes.memoryEdit,
          transition: PageTransitionType.fadeSlide,
          builder: (context, state) {
            final model = state.extra as MemoryModel;
            return BlocProvider(
              create: (_) => getIt<EditMemoryCubit>(),
              child: EditMemoryScreen(model: model),
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
