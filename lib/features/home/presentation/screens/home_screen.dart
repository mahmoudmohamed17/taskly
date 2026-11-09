import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/di/di.dart';
import '../../../../core/utils/app_strings.dart';
import '../../cubits/add_task_cubit.dart';
import '../wigdets/home_header.dart';
import '../wigdets/home_search_field.dart';
import '../wigdets/tasks_list.dart';
import '../wigdets/task_creation_bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.sp),
          child: Column(
            spacing: 10.h,
            children: [
              const HomeHeader(),
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
