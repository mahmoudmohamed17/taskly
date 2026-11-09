import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/models/task_model.dart';

class DetailsHeader extends StatelessWidget {
  const new({
    super.key,
    required this.model,
  });

  final TaskModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: model.category.categoryColors.tint,
            borderRadius: BorderRadius.circular(18.r),
          ),
          padding: const EdgeInsets.all(18),
          child: Icon(
            model.category.icon,
            color: model.category.categoryColors.base,
            size: 52.sp,
          ),
        ),
        8.verticalSpace,
        Text(
          context.tr(model.category.label),
          style: context.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        12.verticalSpace,
        Text(
          model.title,
          style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        4.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 4,
          children: [
            Text(
              context.tr(AppStrings.taskUpdatedAt),
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colorScheme.outline,
              ),
            ),
            Text(
              (model.lastUpdateDate ?? model.creationDate).timeWithDate(locale: context.locale.languageCode),
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colorScheme.outline,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
