import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/models/attachment_model.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import 'attachment_item.dart';

class AttachmentsWidget extends StatelessWidget {
  final List<AttachmentModel> attachments;

  const AttachmentsWidget({super.key, required this.attachments});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          context.tr(AppStrings.taskAttachments),
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colorScheme.outline,
          ),
        ),
        Builder(
          builder: (context) {
            if (attachments.isEmpty) return _empty(context);
            return GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 6.w,
              mainAxisSpacing: 6.h,
              childAspectRatio: 0.85,
              physics: const NeverScrollableScrollPhysics(),
              children: attachments.map((item) => AttachmentItem(model: item)).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _empty(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          const FaIcon(FontAwesomeIcons.paperclip),
          Text(
            context.tr(AppStrings.taskNoAttachments),
            style: context.textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
