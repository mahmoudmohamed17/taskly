import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_toast.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/models/task_model.dart';
import '../cubits/memory_details_cubit.dart';
import '../wigdets/attachments_widget.dart';
import '../wigdets/description_widget.dart';
import '../wigdets/details_footer.dart';
import '../wigdets/details_header.dart';

class TaskDetailsScreen extends StatelessWidget {
  final TaskModel model;

  const TaskDetailsScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MemoryDetailsCubit, MemoryDetailsState>(
      listener: (context, state) {
        if (state is MemoryDetailsDeleted) {
          context.pop();
          AppToast.info(context.tr(AppStrings.taskDeleted));
        } else if (state is MemoryDetailsError) {
          AppToast.error(context.tr(state.message));
        }
      },
      child: BlocBuilder<MemoryDetailsCubit, MemoryDetailsState>(
        builder: (context, state) {
          final current = state is MemoryDetailsLoaded ? state.memory : model;

          return Scaffold(
            appBar: customAppBar(
              title: Text(context.tr(AppStrings.taskDetailsLabel)),
              automaticallyImplyLeading: true,
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () => context.push(AppRoutes.taskEdit, extra: current),
                  icon: FaIcon(
                    FontAwesomeIcons.penToSquare,
                    size: 22.sp,
                  ),
                  tooltip: context.tr(AppStrings.edit),
                ),
                IconButton(
                  onPressed: () async {
                    await context.read<MemoryDetailsCubit>().deleteMemory(model.id);
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.trashCan,
                    size: 22.sp,
                  ),
                ),
                4.horizontalSpace,
              ],
            ),
            body: switch (state) {
              MemoryDetailsLoading() => _loading(context, current),
              MemoryDetailsDeleted() => const SizedBox.shrink(),
              _ => _loaded(current),
            },
          );
        },
      ),
    );
  }

  Widget _loading(BuildContext context, TaskModel current) {
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: context.colorScheme.outlineVariant,
        highlightColor: context.colorScheme.outline.withValues(alpha: 0.50),
      ),
      enableSwitchAnimation: true,
      child: _loaded(current),
    );
  }

  Widget _loaded(TaskModel current) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      children: [
        DetailsHeader(model: current),
        16.verticalSpace,
        DescriptionWidget(description: current.description),
        16.verticalSpace,
        AttachmentsWidget(attachments: current.attachments),
        16.verticalSpace,
        DetailsFooter(creationDate: current.creationDate),
        32.verticalSpace,
      ],
    );
  }
}
