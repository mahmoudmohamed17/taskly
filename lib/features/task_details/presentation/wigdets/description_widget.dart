import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/extensions.dart';

class DescriptionWidget extends StatelessWidget {
  const new({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr(AppStrings.taskDetails),
          style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.outline),
        ),
        Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: context.colorScheme.outlineVariant),
          ),
          width: double.infinity,
          padding: EdgeInsets.all(16.r),
          child: Text(
            description,
            style: context.textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}
