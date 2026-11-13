import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubits/theme_cubit.dart';
import '../theme/app_theme.dart';
import '../utils/extensions.dart';

class ChangeThemeButton extends StatefulWidget {
  const new({super.key});

  @override
  State<ChangeThemeButton> createState() => _ChangeThemeButtonState();
}

class _ChangeThemeButtonState extends State<ChangeThemeButton> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: AppMotion.slow,
    );

    _scale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.2).chain(CurveTween(curve: Curves.bounceOut)),
        weight: 35,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.2, end: 0.9).chain(CurveTween(curve: Curves.bounceIn)),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.9, end: 1.0).chain(CurveTween(curve: Curves.bounceInOut)),
        weight: 40,
      ),
    ]).animate(_controller);
  }

  void onTap() {
    context.read<ThemeCubit>().toggle();
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedBuilder(
        animation: _scale,
        builder: (context, child) {
          return Transform.scale(
            scale: _scale.value,
            child: child,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: context.colorScheme.outline.withValues(alpha: 0.25),
            ),
          ),
          padding: EdgeInsets.all(10.sp),
          child: Icon(
            context.isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
            size: 20.sp,
          ),
        ),
      ),
    );
  }
}
