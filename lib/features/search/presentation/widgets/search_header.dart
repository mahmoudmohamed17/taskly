import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class SearchHeader extends StatelessWidget {
  const new({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12.w,
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: context.colorScheme.outlineVariant),
            ),
            padding: EdgeInsets.all(12.sp),
            child: Icon(
              Icons.arrow_back_ios_outlined,
              size: 20.sp,
            ),
          ),
        ),
        Expanded(
          child: CustomTextFormField(
            controller: controller,
            focusNode: focusNode,
            hint: AppStrings.homeSearchPlaceholder,
            prefixIcon: const Icon(Icons.search),
          ),
        ),
      ],
    );
  }
}
