import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';

import '../utils/extensions.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Widget? icon;
  final double borderRadius;
  final double? width;
  final double? height;
  final IconAlignment? iconAlignment;
  final WidgetStateProperty<Color?>? backgroundColor;

  const CustomElevatedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.borderRadius = 16,
    this.icon,
    this.width,
    this.height,
    this.iconAlignment = IconAlignment.start,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: context.theme.elevatedButtonTheme.style?.copyWith(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius.r),
            ),
          ),
          backgroundColor: backgroundColor,
        ),
        icon: icon,
        label: Text(context.tr(text)),
        iconAlignment: iconAlignment,
      ),
    );
  }
}
