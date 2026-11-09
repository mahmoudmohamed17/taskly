import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/models/task_attachment_input.dart';
import '../../../../core/utils/extensions.dart';
import '../../cubits/add_memory_cubit.dart';

class MemoryInputAttachmentWidget extends StatelessWidget {
  final TaskAttachmentInput input;

  const MemoryInputAttachmentWidget({super.key, required this.input});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      width: 120.w,
      child: Stack(
        children: [
          Column(
            spacing: 4,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: input.type.colors.tint,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  alignment: Alignment.center,
                  child: FaIcon(
                    input.type.icon,
                    color: input.type.colors.base,
                  ),
                ),
              ),
              Text(
                input.name,
                style: context.textTheme.labelSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () async {
                await context.read<AddMemoryCubit>().removeAttachment(input);
              },
              child: CircleAvatar(
                backgroundColor: Colors.white38,
                radius: 14.r,
                child: FaIcon(
                  FontAwesomeIcons.xmark,
                  color: Colors.black,
                  size: 14.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
