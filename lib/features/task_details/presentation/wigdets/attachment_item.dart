import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/models/attachment_model.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/format_bytes.dart';

class AttachmentItem extends StatelessWidget {
  final AttachmentModel model;

  const AttachmentItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Open the file based on the file type
      },
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: context.colorScheme.outlineVariant),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: model.type.colors.tint,
                ),
                alignment: Alignment.center,
                child: FaIcon(
                  model.type.icon,
                  color: model.type.colors.base,
                  size: 24.sp,
                ),
              ),
            ),
            Text(
              model.fileName,
              style: context.textTheme.labelMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Row(
              spacing: 4,
              children: [
                Flexible(
                  child: Text(
                    model.type.label.toUpperCase(),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.outline,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                CircleAvatar(
                  radius: 2,
                  backgroundColor: context.colorScheme.outline,
                ),
                Expanded(
                  child: Text(
                    formatBytes(model.sizeBytes),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.outline,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
