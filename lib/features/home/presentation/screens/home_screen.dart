import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/di/di.dart';
import '../../../../core/utils/app_strings.dart';
import '../../cubits/add_task_cubit.dart';
import 'home_drawer.dart';
import '../wigdets/home_header.dart';
import '../wigdets/home_search_field.dart';
import '../wigdets/tasks_list.dart';
import '../wigdets/task_creation_bottom_sheet.dart';
import 'push_drawer_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<PushDrawerScaffoldState> _drawerKey = GlobalKey<PushDrawerScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return PushDrawerScaffold(
      key: _drawerKey,
      drawer: const HomeDrawer(),
      widthFactor: 0.80,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(12.sp),
            child: Column(
              spacing: 10.h,
              children: [
                HomeHeader(drawerKey: _drawerKey),
                Expanded(
                  child: ListView(
                    children: [
                      16.verticalSpace,
                      const HomeSearchField(),
                      16.verticalSpace,
                      const TasksList(),
                      64.verticalSpace,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showBottomSheet(context),
          tooltip: context.tr(AppStrings.memoryCreatedAt),
          child: const FaIcon(FontAwesomeIcons.penToSquare),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      sheetAnimationStyle: const AnimationStyle(
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
        duration: Duration(milliseconds: 600),
        reverseDuration: Duration(milliseconds: 600),
      ),
      builder: (_) => BlocProvider(
        create: (_) => getIt<AddTaskCubit>(),
        child: const TaskCreationBottomSheet(),
      ),
    );
  }
}
