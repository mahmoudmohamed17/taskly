import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/extensions.dart';
import '../domain/models/onboarding_model.dart';
import 'orbit_illustration.dart';

class OnboardingItem extends StatelessWidget {
  final OnboardingModel model;

  const OnboardingItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24.h,
      children: [
        OrbitIllustration(
          model: model,
          size: 350.sp,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 12.h,
            children: [
              Text(
                context.tr(model.title),
                textAlign: TextAlign.center,
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.colorScheme.secondary,
                ),
              ),
              Text(
                context.tr(model.subTitle),
                textAlign: TextAlign.center,
                style: context.textTheme.headlineMedium,
              ),
              Text(
                context.tr(model.description),
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
