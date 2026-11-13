import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/cubits/voice_recording_cubit.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_toast.dart';
import '../../../../core/utils/extensions.dart';

class VoiceRecordingDialog extends StatefulWidget {
  const VoiceRecordingDialog({super.key});

  @override
  State<VoiceRecordingDialog> createState() => _VoiceRecordingDialogState();
}

class _VoiceRecordingDialogState extends State<VoiceRecordingDialog> with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _outerRingAnimation;
  late final Animation<double> _innerRingAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _outerRingAnimation = Tween<double>(begin: 0.90, end: 1.15).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );

    _innerRingAnimation = Tween<double>(begin: 0.95, end: 1.08).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );

    startRecording();
  }

  void startRecording() {
    context.read<VoiceRecordingCubit>().startRecording();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VoiceRecordingCubit, VoiceRecordingState>(
      listener: (context, state) {
        if (state is VoiceRecordingSuccess) {
          context.pop(state.words);
        }
        // TODO: Handle this better later
        if (state is VoiceRecordingError) {
          context.pop();
          AppToast.error(state.error);
        }
      },
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 20.h,
            children: [
              _header(context),
              _button(context),
              BlocSelector<VoiceRecordingCubit, VoiceRecordingState, String>(
                selector: (state) => switch (state) {
                  VoiceRecordingListening(words: final words) || VoiceRecordingSuccess(words: final words) => words,
                  _ => '',
                },
                builder: (context, words) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text(
                      words.isNotEmpty ? words : context.tr(AppStrings.voiceListening),
                      style: context.textTheme.labelMedium?.copyWith(
                        color: words.isNotEmpty ? context.colorScheme.onSurface : context.colorScheme.outline,
                        fontStyle: words.isNotEmpty ? FontStyle.normal : FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 6,
          children: [
            Icon(
              Icons.lock,
              size: 12,
              color: context.colorScheme.secondary,
            ),
            Text(
              context.tr(AppStrings.secureLocal),
              style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.secondary),
            ),
          ],
        ),
        8.verticalSpace,
        Text(
          context.tr(AppStrings.voiceTitle),
          style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        Text(
          context.tr(AppStrings.voiceDescription),
          style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.outline),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _button(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Outer pulsing ripple ring
            Transform.scale(
              scale: _outerRingAnimation.value,
              child: CircleAvatar(
                radius: 84.r,
                backgroundColor: context.colorScheme.primary.withValues(
                  alpha: (0.12 * (1.2 - (_outerRingAnimation.value - 0.90) / 0.25)).clamp(0.04, 0.15),
                ),
              ),
            ),
            // Inner pulsing ripple ring
            Transform.scale(
              scale: _innerRingAnimation.value,
              child: CircleAvatar(
                radius: 64.r,
                backgroundColor: context.colorScheme.primary.withValues(
                  alpha: (0.24 * (1.2 - (_innerRingAnimation.value - 0.95) / 0.13)).clamp(0.10, 0.28),
                ),
              ),
            ),
            // Central microphone button (tap to stop recording)
            GestureDetector(
              onTap: () => context.read<VoiceRecordingCubit>().toggle(),
              child: CircleAvatar(
                radius: 48.r,
                backgroundColor: context.read<VoiceRecordingCubit>().isRecording
                    ? context.colorScheme.primary
                    : context.colorScheme.surfaceContainerLow,
                child: Icon(
                  Icons.mic,
                  color: context.read<VoiceRecordingCubit>().isRecording
                      ? context.colorScheme.onPrimary
                      : context.colorScheme.onSurface,
                  size: 48.sp,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
