import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/utils/app_assets.dart';
import '../screens/push_drawer_scaffold.dart';

class HomeHeader extends StatelessWidget {
  final GlobalKey<PushDrawerScaffoldState> drawerKey;

  const HomeHeader({super.key, required this.drawerKey});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: drawerKey.currentState?.toggle,
          child: const FaIcon(FontAwesomeIcons.bars),
        ),
        GestureDetector(
          onTap: () => context.push(AppRoutes.voiceSearchResults),
          child: Image.asset(AppImages.logo, height: 38.h, width: 38.w),
        ),
      ],
    );
  }
}
