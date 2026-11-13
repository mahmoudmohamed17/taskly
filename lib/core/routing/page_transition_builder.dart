import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

enum PageTransitionType {
  /// Native iOS swipe-to-back or Android Material zoom
  platformAdaptive,
  fadeScale,
  fadeSlide,
  slideUp,
  fade,
  none,
}

class PageTransitionBuilder {
  PageTransitionBuilder._();

  static Page<dynamic> build({
    required Widget child,
    required LocalKey key,
    PageTransitionType transition = PageTransitionType.platformAdaptive,
  }) {
    switch (transition) {
      case PageTransitionType.platformAdaptive:
        return _platformAdaptive(key, child);
      case PageTransitionType.fadeScale:
        return _fadeScale(key, child);
      case PageTransitionType.fadeSlide:
        return _fadeSlide(key, child);
      case PageTransitionType.slideUp:
        return _slideUp(key, child);
      case PageTransitionType.fade:
        return _fade(key, child);
      case PageTransitionType.none:
        return _none(key, child);
    }
  }

  static Page<dynamic> _platformAdaptive(
    LocalKey key,
    Widget child,
  ) {
    return defaultTargetPlatform == TargetPlatform.iOS
        ? CupertinoPage<void>(key: key, child: child)
        : MaterialPage<void>(key: key, child: child);
  }

  static Page<dynamic> _fadeScale(LocalKey key, Widget child) {
    return CustomTransitionPage<void>(
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.92, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            ),
            child: child,
          ),
        );
      },
    );
  }

  static Page<dynamic> _slideUp(LocalKey key, Widget child) {
    return CustomTransitionPage<void>(
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
          child: child,
        );
      },
    );
  }

  static Page<dynamic> _fade(LocalKey key, Widget child) {
    return CustomTransitionPage<void>(
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: child,
        );
      },
    );
  }

  static Page<dynamic> _fadeSlide(LocalKey key, Widget child) {
    return CustomTransitionPage<void>(
      key: key,
      child: child,
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
            child: child,
          ),
        );
      },
    );
  }

  static Page<dynamic> _none(LocalKey key, Widget child) {
    return NoTransitionPage<void>(key: key, child: child);
  }
}
