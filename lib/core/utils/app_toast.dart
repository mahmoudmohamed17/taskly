import 'package:material_ui/material_ui.dart';
import 'package:toastification/toastification.dart';

abstract final class AppToast {
  static void success(String message) => _show(message, ToastificationType.success);
  static void error(String message) => _show(message, ToastificationType.error);
  static void info(String message) => _show(message, ToastificationType.info);
  static void warning(String message) => _show(message, ToastificationType.warning);

  static void _show(
    String message,
    ToastificationType type, {
    Duration autoCloseDuration = const Duration(seconds: 3),
  }) {
    toastification.show(
      title: Text(message),
      type: type,
      style: ToastificationStyle.flat,
      dragToClose: true,
      showProgressBar: true,
      closeButton: const ToastCloseButton(showType: CloseButtonShowType.none),
      autoCloseDuration: autoCloseDuration,
    );
  }
}
