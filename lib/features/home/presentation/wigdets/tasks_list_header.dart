import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/extensions.dart';

class TasksListHeader extends StatelessWidget {
  final int count;

  const TasksListHeader({super.key, this.count = 0});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.tr(AppStrings.homeTasksTitle),
          style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
        ),
        if (count > 7)
          GestureDetector(
            onTap: () {},
            child: Row(
              spacing: 4.w,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.tr(AppStrings.homeViewAll),
                  style: context.textTheme.titleSmall,
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 14.sp,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
