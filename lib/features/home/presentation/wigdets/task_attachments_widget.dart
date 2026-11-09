import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/models/task_attachment_input.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../cubits/add_memory_cubit.dart';
import 'task_input_attachment_widget.dart';

class TaskAttachmentsWidget extends StatelessWidget {
  const TaskAttachmentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMemoryCubit, AddMemoryState>(
      buildWhen: (_, state) => state is AddMemoryAttachmentsUpdated || state is AddMemoryInitial,
      builder: (context, state) {
        final List<TaskAttachmentInput> attachments = state is AddMemoryAttachmentsUpdated ? state.attachments : [];
        if (attachments.isEmpty) return _empty(context);

        return _filled(context, attachments);
      },
    );
  }

  Widget _filled(BuildContext context, List<TaskAttachmentInput> attachments) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.tr(AppStrings.taskAttachments),
              style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
            GestureDetector(
              onTap: () => context.read<AddMemoryCubit>().pickAttachments(),
              child: FaIcon(
                FontAwesomeIcons.plus,
                size: 20.sp,
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 8,
            children: attachments.map((item) => TaskInputAttachmentWidget(input: item)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _empty(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<AddMemoryCubit>().pickAttachments(),
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: Radius.circular(16.r),
          padding: EdgeInsets.zero,
          color: context.colorScheme.outline.withValues(alpha: 0.50),
          dashPattern: [7, 5],
        ),
        child: ListTile(
          title: Text(context.tr(AppStrings.addTaskAttachmentTitle)),
          subtitle: Text(
            context.tr(AppStrings.addTaskAttachmentTypes),
            style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.outline),
          ),
          trailing: const Icon(Icons.attachment),
        ),
      ),
    );
  }
}
