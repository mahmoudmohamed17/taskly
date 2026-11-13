import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/utils/app_strings.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/custom_elevated_button.dart';

class OnboardingFooter extends StatelessWidget {
  const OnboardingFooter({
    super.key,
    required this.controller,
    required this.total,
    required this.isLastPage,
    required this.onNext,
    required this.onStart,
  });

  final PageController controller;
  final int total;
  final bool isLastPage;
  final VoidCallback onNext;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 24.h,
      children: [
        SmoothPageIndicator(
          controller: controller,
          count: total,
          effect: SlideEffect(
            activeDotColor: context.colorScheme.primary,
            dotColor: context.colorScheme.outline.withValues(alpha: 0.50),
            spacing: 12.w,
            dotWidth: 14.w,
            dotHeight: 14.h,
          ),
        ),
        CustomElevatedButton(
          width: double.infinity,
          text: isLastPage ? AppStrings.start : AppStrings.next,
          icon: Icon(Icons.arrow_forward_ios_rounded, size: 20.sp),
          iconAlignment: IconAlignment.end,
          onPressed: isLastPage ? onStart : onNext,
        ),
      ],
    );
  }
}
