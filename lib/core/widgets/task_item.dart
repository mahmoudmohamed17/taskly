import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../routing/app_routes.dart';
import '../utils/extensions.dart';
import '../models/task_model.dart';

class TaskItem extends StatelessWidget {
  final TaskModel item;

  const TaskItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.taskDetails, extra: item),
      child: Card(
        child: ListTile(
          // contentPadding: const EdgeInsets.all(8),
          leading: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: item.category.categoryColors.tint,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(item.category.icon, color: item.category.categoryColors.base),
          ),
          title: Text(
            item.title,
            style: context.textTheme.labelMedium?.copyWith(color: item.category.categoryColors.base),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            item.description,
            style: context.textTheme.titleSmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_outlined,
            size: 18.sp,
            color: context.colorScheme.outline.withValues(alpha: 0.50),
          ),
        ),
      ),
    );
  }
}
