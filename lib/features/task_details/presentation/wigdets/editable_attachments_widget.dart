import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/models/task_attachment_input.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../cubits/edit_memory_cubit.dart';
import 'attachment_item.dart';

class EditableAttachmentsWidget extends StatelessWidget {
  const EditableAttachmentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditMemoryCubit, EditMemoryState>(
      buildWhen: (previous, current) => current is EditAttachmentsUpdated || previous is EditAttachmentsUpdated,
      builder: (context, state) {
        final cubit = context.read<EditMemoryCubit>();
        final existing = state is EditAttachmentsUpdated ? state.keptAttachments : cubit.keptAttachments;
        final pending = state is EditAttachmentsUpdated ? state.selectedAttachments : cubit.selectedAttachments;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 2.h,
          children: [
            _header(context, cubit),
            8.verticalSpace,
            if (existing.isEmpty && pending.isEmpty)
              _empty(context)
            else
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                crossAxisSpacing: 6.w,
                mainAxisSpacing: 6.h,
                childAspectRatio: 0.85,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ...existing.map(
                    (item) => Stack(
                      children: [
                        Positioned.fill(child: AttachmentItem(model: item)),
                        _removeButton(() => cubit.removeExistingAttachment(item.attachmentId)),
                      ],
                    ),
                  ),
                  ...pending.map((item) => _pendingAttachment(context, item, cubit)),
                ],
              ),
          ],
        );
      },
    );
  }

  Widget _header(BuildContext context, EditMemoryCubit cubit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.tr(AppStrings.taskAttachments),
          style: context.textTheme.bodyLarge,
        ),
        GestureDetector(
          onTap: () => cubit.pickAttachments(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 6.w,
            children: [
              Text(
                context.tr(AppStrings.addTaskAttachmentTitle),
                style: context.textTheme.labelMedium?.copyWith(color: context.colorScheme.primary),
              ),
              FaIcon(
                FontAwesomeIcons.plus,
                size: 16.sp,
                color: context.colorScheme.primary,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _pendingAttachment(
    BuildContext context,
    TaskAttachmentInput item,
    EditMemoryCubit cubit,
  ) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: context.colorScheme.outlineVariant),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: FaIcon(item.type.icon, color: item.type.colors.base, size: 28.sp),
                ),
              ),
              Text(item.name, maxLines: 1, overflow: TextOverflow.ellipsis),
              Text(item.type.label, style: context.textTheme.bodySmall),
            ],
          ),
        ),
        _removeButton(() => cubit.removeSelectedAttachment(item)),
      ],
    );
  }

  Widget _empty(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          const FaIcon(FontAwesomeIcons.paperclip),
          8.verticalSpace,
          Text(context.tr(AppStrings.taskNoAttachments)),
        ],
      ),
    );
  }

  Widget _removeButton(VoidCallback onPressed) => Positioned(
    top: 4,
    right: 4,
    child: Material(
      color: Colors.white70,
      shape: const CircleBorder(),
      child: IconButton(
        visualDensity: VisualDensity.compact,
        iconSize: 18,
        onPressed: onPressed,
        icon: const Icon(Icons.close),
      ),
    ),
  );
}
