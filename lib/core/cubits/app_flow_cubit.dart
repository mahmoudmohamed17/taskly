import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

import '../routing/app_routes.dart';
import 'app_flow_state.dart';

@Singleton()
class AppFlowCubit extends HydratedCubit<AppFlowState> {
  AppFlowCubit() : super(AppFlowState.onboarding);

  static const String _stateKey = 'flow_state';

  /// Resolves the target route for splash or initial entry point based on [state].
  String get targetRoute {
    switch (state) {
      case AppFlowState.onboarding:
        return AppRoutes.onboarding;
      case AppFlowState.home:
        return AppRoutes.home;
    }
  }

  /// Resolves redirection logic based on current [AppFlowState] and [currentPath].
  ///
  /// Covers all flow scenarios:
  /// - Splash screen: returns `null` so splash animations/initialization can finish.
  /// - [AppFlowState.login]: guards all other routes and redirects to login (or allows signup).
  /// - [AppFlowState.home]: guards auth routes and redirects to home.
  String? resolveRedirect(String currentPath) {
    // Keep user on the splash screen while it performs animation/initialization.
    // if (currentPath == AppRoutes.splash) {
    //   return null;
    // }

    switch (state) {
      // Guard: onboarding not done → always land on onboarding.
      case AppFlowState.onboarding when currentPath != AppRoutes.onboarding:
        return AppRoutes.onboarding;

      // Guard: onboarding done → never show onboarding again.
      case AppFlowState.home when currentPath == AppRoutes.onboarding:
        return AppRoutes.home;

      // no redirect needed
      default:
        return null;
    }
  }

  /// Marks onboarding as complete, persists the state, and moves to [AppFlowState.home].
  /// GoRouter's refreshListenable will re-evaluate the redirect automatically.
  void completeOnboarding() {
    emit(AppFlowState.home);
  }

  // TODO: Delete this soon
  void returnToOnboarding() {
    emit(AppFlowState.onboarding);
  }

  @override
  AppFlowState? fromJson(Map<String, dynamic> json) {
    try {
      final stateName = json[_stateKey] as String?;
      if (stateName != null) {
        return AppFlowState.values.byName(stateName);
      }
    } catch (_) {}
    return null;
  }

  @override
  Map<String, dynamic>? toJson(AppFlowState state) {
    return {_stateKey: state.name};
  }
}
