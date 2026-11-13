import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/extensions.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.borderRadius = 16,
    this.borderColor,
    this.width,
    this.height,
  });

  final String text;
  final VoidCallback onPressed;
  final Color? borderColor;
  final Widget? icon;
  final double borderRadius;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: context.theme.outlinedButtonTheme.style?.copyWith(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius.r),
            ),
          ),
          side: borderColor != null ? WidgetStatePropertyAll(BorderSide(color: borderColor!)) : null,
        ),
        icon: icon,
        label: Text(context.tr(text)),
      ),
    );
  }
}
