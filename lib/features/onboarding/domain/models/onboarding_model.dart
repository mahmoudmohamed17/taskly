import 'package:material_ui/material_ui.dart';

import '../../../../core/utils/app_strings.dart';

class OnboardingModel {
  final IconData centerIcon;
  final IconData upperIcon;
  final IconData lowerIcon;
  final String title;
  final String subTitle;
  final String description;

  const OnboardingModel({
    required this.centerIcon,
    required this.upperIcon,
    required this.lowerIcon,
    required this.title,
    required this.subTitle,
    required this.description,
  });

  static List<OnboardingModel> onboardingList() {
    return const [
      OnboardingModel(
        centerIcon: Icons.description_outlined,
        upperIcon: Icons.favorite_border_rounded,
        lowerIcon: Icons.calendar_today_outlined,
        title: AppStrings.onboardingStep1Title,
        subTitle: AppStrings.onboardingStep1SubTitle,
        description: AppStrings.onboardingStep1Description,
      ),
      OnboardingModel(
        centerIcon: Icons.mic,
        upperIcon: Icons.search,
        lowerIcon: Icons.description_outlined,
        title: AppStrings.onboardingStep2Title,
        subTitle: AppStrings.onboardingStep2SubTitle,
        description: AppStrings.onboardingStep2Description,
      ),
      OnboardingModel(
        centerIcon: Icons.shield_outlined,
        upperIcon: Icons.lock,
        lowerIcon: Icons.visibility_off_outlined,
        title: AppStrings.onboardingStep3Title,
        subTitle: AppStrings.onboardingStep3SubTitle,
        description: AppStrings.onboardingStep3Description,
      ),
    ];
  }
}
