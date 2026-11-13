import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/extensions.dart';

class RecentSearchs extends StatelessWidget {
  final Function(String value) onSearchSelected;

  const RecentSearchs({super.key, required this.onSearchSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 8.h,
      children: [
        _header(context),

        ClipRRect(
          borderRadius: BorderRadius.circular(24.r),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(color: context.colorScheme.outlineVariant),
            ),
            child: Material(
              color: Colors.transparent,
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) => _searchItem(
                  context,
                  index: index,
                  totalCount: 3,
                ),
                itemCount: 3,
                separatorBuilder: (_, _) => const Divider(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  ShapeBorder _getItemShape(int index, int totalCount) {
    final radius = Radius.circular(24.r);
    if (totalCount <= 1) {
      return RoundedRectangleBorder(borderRadius: BorderRadius.all(radius));
    }
    if (index == 0) {
      return RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: radius),
      );
    }
    if (index == totalCount - 1) {
      return RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: radius),
      );
    }
    return const RoundedRectangleBorder();
  }

  Widget _searchItem(
    BuildContext context, {
    required int index,
    required int totalCount,
  }) {
    return ListTile(
      onTap: () {
        // TODO: Hand it to the controller or cubit
        onSearchSelected('دواء الوالد');
      },
      shape: _getItemShape(index, totalCount),
      leading: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.outlineVariant,
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.all(8.sp),
        child: Icon(
          Icons.search,
          size: 20.sp,
        ),
      ),
      title: const Text(
        'دواء الوالد',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_outlined,
        size: 14.sp,
        color: context.colorScheme.outline,
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.tr(AppStrings.searchRecentTitle),
          style: context.textTheme.labelLarge,
        ),
        GestureDetector(
          onTap: () {
            // TODO: Delete the recent search
          },
          child: Text(
            context.tr(AppStrings.searchClearRecent),
            style: context.textTheme.labelMedium?.copyWith(
              color: context.colorScheme.outline,
            ),
          ),
        ),
      ],
    );
  }
}
