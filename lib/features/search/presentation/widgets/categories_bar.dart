import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/extensions.dart';

class CategoriesBar extends StatefulWidget {
  final Function(TaskCategory? category) onCategoryChanged;

  const CategoriesBar({super.key, required this.onCategoryChanged});

  @override
  State<CategoriesBar> createState() => _CategoriesBarState();
}

class _CategoriesBarState extends State<CategoriesBar> {
  final ValueNotifier<int?> _current = ValueNotifier(null);

  List<TaskCategory> get _categories => [
    TaskCategory.medical,
    TaskCategory.financial,
    TaskCategory.friends,
    TaskCategory.family,
    TaskCategory.personal,
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 8.w,
        children: List.generate(_categories.length, (index) {
          return ValueListenableBuilder(
            valueListenable: _current,
            builder: (context, currentIndex, child) {
              final bool isSelected = currentIndex == index;
              return GestureDetector(
                onTap: () {
                  _current.value = index;
                  widget.onCategoryChanged.call(_categories[index]);
                },
                child: _bagde(context, category: _categories[index], isActive: isSelected),
              );
            },
          );
        }),
      ),
    );
  }

  Widget _bagde(BuildContext context, {required TaskCategory category, bool isActive = false}) {
    return AnimatedContainer(
      duration: AppMotion.fast,
      decoration: BoxDecoration(
        color: isActive ? context.colorScheme.primary : context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: isActive ? Colors.transparent : context.colorScheme.primary),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
      child: Text(
        context.tr(category.label),
        style: context.textTheme.labelMedium?.copyWith(
          color: isActive ? context.colorScheme.onPrimary : context.colorScheme.onSurface,
        ),
      ),
    );
  }
}
