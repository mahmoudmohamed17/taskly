import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/extensions.dart';

class DetailsFooter extends StatelessWidget {
  final DateTime creationDate;

  const new({super.key, required this.creationDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        spacing: 6,
        children: [
          Expanded(
            child: _tile(
              context,
              icon: Icons.calendar_month_rounded,
              title: Text(
                context.tr(AppStrings.taskCreatedAt),
                style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.outline),
              ),
              subTitle: Text(
                creationDate.timeWithDate(locale: context.locale.languageCode),
                style: context.textTheme.labelMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            child: _tile(
              context,
              icon: Icons.shield_outlined,
              title: Text(
                context.tr(AppStrings.taskLocalData),
                style: context.textTheme.labelMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile(
    BuildContext context, {
    required IconData icon,
    Widget? title,
    Widget? subTitle,
  }) {
    return ListTile(
      horizontalTitleGap: 6,
      leading: Icon(icon),
      title: title,
      subtitle: subTitle,
      contentPadding: EdgeInsets.zero,
    );
  }
}
