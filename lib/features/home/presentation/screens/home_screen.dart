import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/di.dart';
import '../../cubits/add_memory_cubit.dart';
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
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            builder: (_) => BlocProvider(
              create: (_) => getIt<AddMemoryCubit>(),
              child: const TaskCreationBottomSheet(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
