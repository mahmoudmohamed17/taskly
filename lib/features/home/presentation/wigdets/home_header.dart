import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/widgets/change_langauge_button.dart';
import '../../../../core/widgets/change_theme_button.dart';

class HomeHeader extends StatelessWidget {
  const new({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // TODO: This would be deleted as soon as we finished this screen
        GestureDetector(
          onTap: () => context.push(AppRoutes.voiceSearchResults),
          child: Image.asset(AppImages.logo, height: 38.h, width: 38.w),
        ),
        Row(
          spacing: 12.w,
          children: const [ChangeThemeButton(), ChangeLangaugeButton()],
        ),
      ],
    );
  }
}
