import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_theme.dart';
import '../utils/app_strings.dart';
import '../utils/enums.dart';
import '../utils/extensions.dart';

class TaskCategorySelectionWidget extends StatefulWidget {
  final TaskCategory? initialCategory;

  final Function(TaskCategory category) onSelected;
  final Color? gridItemColor;

  const new({
    super.key,
    required this.onSelected,
    this.initialCategory,
    this.gridItemColor,
  });

  @override
  State<TaskCategorySelectionWidget> createState() => _TaskCategorySelectionWidgetState();
}

class _TaskCategorySelectionWidgetState extends State<TaskCategorySelectionWidget> {
  late final ValueNotifier<int?> _selectedIndex;

  @override
  void initState() {
    super.initState();

    if (widget.initialCategory != null) {
      _selectedIndex = ValueNotifier<int?>(TaskCategory.values.indexOf(widget.initialCategory!));
    } else {
      _selectedIndex = ValueNotifier<int?>(null);
    }
  }

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        _header(context),
        _gridItems(),
      ],
    );
  }

  Widget _gridItems() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8.h,
        crossAxisSpacing: 8.w,
        childAspectRatio: 1.2.sp,
      ),
      itemCount: TaskCategory.values.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) => ValueListenableBuilder(
        valueListenable: _selectedIndex,
        builder: (context, value, child) {
          return GestureDetector(
            onTap: () {
              _selectedIndex.value = index;
              widget.onSelected.call(TaskCategory.values[index]);
            },
            child: _category(context, category: TaskCategory.values[index], isActive: value == index),
          );
        },
      ),
    );
  }

  Widget _category(
    BuildContext context, {
    required TaskCategory category,
    bool isActive = false,
  }) {
    return AnimatedContainer(
      duration: AppMotion.fast,
      curve: Curves.ease,
      decoration: BoxDecoration(
        color: widget.gridItemColor ?? context.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isActive ? context.colorScheme.primary : Colors.transparent,
          width: 2.w,
        ),
      ),
      padding: EdgeInsets.all(16.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 4.h,
        children: [
          Icon(
            category.icon,
            color: category.categoryColors.base,
          ),
          Flexible(
            child: Text(
              context.tr(category.label),
              style: context.textTheme.labelMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2.h,
      children: [
        Text(
          context.tr(AppStrings.addTaskCategoryLabel),
          style: context.textTheme.labelLarge,
        ),
        Text(
          context.tr(AppStrings.addTaskCategoryHint),
          style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.outline),
        ),
      ],
    );
  }
}
