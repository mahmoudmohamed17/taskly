import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/task_item.dart';
import '../../../../core/models/task_model.dart';
import '../../../../core/widgets/skeletonizer_widget.dart';
import '../../cubits/search_cubit.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return switch (state) {
          SearchInitial() => _initialHint(context),
          SearchLoading() => _loadingState(),
          SearchLoaded(:final results) => _loadedState(context, results),
          SearchEmpty() => _emptySearch(context),
          SearchError(:final message) => _errorState(context, message),
        };
      },
    );
  }

  Widget _loadedState(BuildContext context, List<TaskModel> results) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 12.h,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.tr(AppStrings.searchResultsTitle),
              style: context.textTheme.labelLarge,
            ),
            Text(
              context.tr(AppStrings.searchResultsCount, namedArgs: {'count': results.length.toString()}),
              style: context.textTheme.labelMedium?.copyWith(
                color: context.colorScheme.outline,
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.separated(
            itemBuilder: (_, index) {
              return TaskItem(item: results[index]);
            },
            separatorBuilder: (_, _) => 16.verticalSpace,
            itemCount: results.length,
          ),
        ),
      ],
    );
  }

  Widget _initialHint(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          Text(
            context.tr(AppStrings.searchPromptTitle),
            style: context.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          Text(
            context.tr(AppStrings.searchPromptDescription),
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.outline,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _loadingState() {
    return SkeletonizerWidget(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: List.generate(3, (_) => TaskItem(item: TaskModel.mock())),
      ),
    );
  }

  Widget _emptySearch(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 6,
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(16.r),
            ),
            padding: EdgeInsets.all(12.sp),
            child: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              size: 32.sp,
            ),
          ),
          Text(
            context.tr(AppStrings.searchEmptyTitle),
            style: context.textTheme.labelLarge,
          ),
          Text(
            context.tr(AppStrings.searchEmptyDescription),
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _errorState(BuildContext context, String message) {
    return Center(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: context.colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text(
          context.tr(message),
          style: context.textTheme.labelMedium?.copyWith(
            color: context.colorScheme.onErrorContainer,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
