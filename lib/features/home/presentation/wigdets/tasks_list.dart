import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart' as context;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/models/task_model.dart';
import '../../../../core/widgets/task_item.dart';
import '../../cubits/memories_list_cubit.dart';
import 'tasks_list_header.dart';
import '../../../../core/widgets/skeletonizer_widget.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemoriesListCubit, MemoriesListState>(
      builder: (context, state) {
        return switch (state) {
          MemoriesListLoading() => _buildLoading(context),
          MemoriesListLoaded(:final memories) => _buildLoaded(context, memories),
          MemoriesListError(:final message) => _buildError(context, message),
        };
      },
    );
  }

  Widget _buildLoaded(BuildContext context, List<TaskModel> memories) {
    if (memories.isEmpty) return _empty(context);

    return Column(
      spacing: 12.h,
      mainAxisSize: MainAxisSize.min,
      children: [
        TasksListHeader(count: memories.length),
        Column(
          spacing: 8.h,
          children: memories
              .take(7)
              .map(
                (item) => TaskItem(item: item),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildLoading(BuildContext context) {
    return SkeletonizerWidget(
      child: Column(
        spacing: 12.h,
        mainAxisSize: MainAxisSize.min,
        children: [
          const TasksListHeader(),
          ...List.generate(3, (_) => TaskItem(item: TaskModel.mock())),
        ],
      ),
    );
  }

  Widget _empty(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          const FaIcon(FontAwesomeIcons.lightbulb),
          Text(
            context.tr(AppStrings.homeNoTasks),
            style: context.textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.colorScheme.error.withValues(alpha: 0.3)),
      ),
      child: Text(
        context.tr(message),
        style: context.textTheme.labelMedium?.copyWith(
          color: context.colorScheme.onErrorContainer,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
