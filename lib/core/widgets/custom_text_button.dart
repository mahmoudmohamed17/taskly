import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/extensions.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.borderRadius = 16,
    this.fontSize,
    this.fontWeight,
    this.fontColor,
    this.width,
    this.height,
  });

  final String text;
  final VoidCallback onPressed;
  final Widget? icon;
  final double borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton.icon(
        onPressed: onPressed,
        style: context.theme.textButtonTheme.style?.copyWith(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius.r),
            ),
          ),
        ),
        icon: icon,
        label: Text(
          context.tr(text),
          style: context.textTheme.titleSmall?.copyWith(
            color: fontColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
