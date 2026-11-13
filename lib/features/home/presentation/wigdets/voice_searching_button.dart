import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/cubits/voice_recording_cubit.dart';
import '../../../../core/di/di.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import 'voice_recording_dialog.dart';

class VoiceSearchingButton extends StatelessWidget {
  const VoiceSearchingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24.r),
      child: Container(
        height: 120.h,
        decoration: BoxDecoration(
          color: context.colorScheme.primary,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Stack(
          children: [
            // Large outer circle (top-left, barely visible ring)
            Positioned(
              left: -30.w,
              top: -30.h,
              child: _DecorativeCircle(
                size: 160.r,
                color: Colors.white10,
              ),
            ),

            // Medium inner circle (creates concentric ring illusion)
            Positioned(
              left: -10.w,
              top: -10.h,
              child: _DecorativeCircle(
                size: 110.r,
                color: Colors.white10,
              ),
            ),

            // Small accent circle (bottom-right, for balance)
            Positioned(
              right: -20.w,
              bottom: -55.h,
              child: _DecorativeCircle(
                size: 120.r,
                color: Colors.white10,
              ),
            ),

            // Actual content row — sits on top of the decorative layers
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 4.h,
                      children: [
                        Badge(
                          label: Text(
                            context.tr(AppStrings.homeVoiceEyebrow),
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.white10,
                        ),
                        Flexible(
                          child: Text(
                            context.tr(AppStrings.homeVoiceTitle),
                            style: context.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            context.tr(AppStrings.homeVoiceDescription),
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 12.w),

                  // Microphone circular button
                  GestureDetector(
                    onTap: () {
                      showDialog<String>(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => BlocProvider(
                          create: (context) => getIt<VoiceRecordingCubit>(),
                          child: const VoiceRecordingDialog(),
                        ),
                      ).then((text) {
                        if (text == null || text.isEmpty) return;
                      });
                    },
                    child: Container(
                      width: 64.r,
                      height: 64.r,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.mic,
                        color: AppColors.primary,
                        size: 30.r,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Reusable helper widget — a plain filled circle used as decoration
// ─────────────────────────────────────────────────────────────────────────────
class _DecorativeCircle extends StatelessWidget {
  const _DecorativeCircle({
    required this.size,
    required this.color,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
