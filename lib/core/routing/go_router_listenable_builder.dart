import 'dart:async';

import 'package:material_ui/material_ui.dart';

import '../cubits/app_flow_state.dart';

/// Bridges [AppFlowCubit] stream changes to GoRouter's [refreshListenable].
///
/// Every time [AppFlowCubit] emits a new [AppFlowState], this notifies
/// GoRouter to re-run its redirect logic.
class GoRouterListenableBuilder extends ChangeNotifier {
  late final StreamSubscription<AppFlowState> _subscription;

  GoRouterListenableBuilder(Stream<AppFlowState> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
