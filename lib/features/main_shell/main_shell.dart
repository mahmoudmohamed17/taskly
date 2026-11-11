import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../../core/di/di.dart';
import '../../core/utils/app_assets.dart';
import '../../core/utils/app_strings.dart';
import '../../core/utils/extensions.dart';
import '../home/cubits/add_task_cubit.dart';
import '../home/cubits/tasks_list_cubit.dart';
import '../home/presentation/screens/home_screen.dart';
import '../home/presentation/wigdets/task_creation_bottom_sheet.dart';

class MainShell extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      gestureNavigationEnabled: true,
      tabs: [
        _tab(
          context,
          screen: (context) => BlocProvider(
            create: (context) => getIt<TasksListCubit>()..watch(),
            child: const HomeScreen(),
          ),
          icon: const FaIcon(FontAwesomeIcons.house),
          title: context.tr(AppStrings.navBarHome),
        ),
        _tab(
          context,
          screen: (context) => const Center(child: Text('Calendar here')),
          icon: const FaIcon(FontAwesomeIcons.calendarDays),
          title: context.tr(AppStrings.navBarCalendar),
        ),
        _tab(
          context,
          screen: (context) => const Center(child: Text('Projects here')),
          icon: const FaIcon(FontAwesomeIcons.trello),
          title: context.tr(AppStrings.navBarProjects),
        ),
        _tab(
          context,
          screen: (context) => const Center(child: Text('Account here')),
          icon: CircleAvatar(
            backgroundImage: const AssetImage(AppImages.me),
            radius: 16.r,
          ),
          title: context.tr(AppStrings.navBarProfile),
        ),
      ],
      navBarBuilder: (navBarConfig) => Style1BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: NavBarDecoration(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          borderRadius: BorderRadius.circular(24.r),
          color: context.colorScheme.surfaceContainer,
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.outline.withValues(alpha: 0.70),
              offset: const Offset(0.5, 0.5),
              blurRadius: 6,
              spreadRadius: 0.5,
            ),
          ],
        ),
      ),
    );
  }

  PersistentTabConfig _tab(
    BuildContext context, {
    required Widget Function(BuildContext context) screen,
    required Widget icon,
    String? title,
    NavigatorConfig? navigatorConfig,
  }) {
    return PersistentTabConfig(
      screen: screen(context),
      item: ItemConfig(
        icon: icon,
        title: title,
        textStyle: context.textTheme.labelSmall!,
        inactiveForegroundColor: context.colorScheme.outline,
        activeForegroundColor: context.colorScheme.primary,
      ),
      navigatorConfig: navigatorConfig,
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => BlocProvider(
        create: (_) => getIt<AddTaskCubit>(),
        child: const TaskCreationBottomSheet(),
      ),
    );
  }
}
