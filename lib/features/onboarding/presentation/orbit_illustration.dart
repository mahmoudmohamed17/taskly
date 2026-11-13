import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../domain/models/onboarding_model.dart';

class OrbitIllustration extends StatelessWidget {
  final OnboardingModel model;
  final double size;

  const OrbitIllustration({
    super.key,
    required this.model,
    this.size = 280,
  });

  @override
  Widget build(BuildContext context) {
    final center = size / 2;
    final outerR = size * 0.44;
    final innerR = size * 0.33;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // 1. Concentric Orbit Rings
          CustomPaint(
            size: Size(size, size),
            painter: const _OrbitPainter(Color(0xFFD6DFE3)),
          ),

          // 2. Central Squircle Badge
          Container(
            width: size * 0.35,
            height: size * 0.35,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.28),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Icon(model.centerIcon, size: size * 0.16, color: Colors.white),
          ),

          // 3. Upper Satellite Badge (Top-Right)
          Positioned(
            left: center + innerR * math.cos(math.pi * -0.22) - 22,
            top: center + innerR * math.sin(math.pi * -0.22) - 22,
            child: _satelliteBadge(model.upperIcon, AppColors.primary),
          ),

          // 4. Lower Satellite Badge (Bottom-Left)
          Positioned(
            left: center + outerR * math.cos(math.pi * 0.72) - 22,
            top: center + outerR * math.sin(math.pi * 0.72) - 22,
            child: _satelliteBadge(model.lowerIcon, AppColors.secondary),
          ),
        ],
      ),
    );
  }

  Widget _satelliteBadge(IconData icon, Color color) {
    return Container(
      width: 44.w,
      height: 44.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, size: 21.sp, color: color),
    );
  }
}

class _OrbitPainter extends CustomPainter {
  final Color color;
  const _OrbitPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;

    // Inner subtle ring
    canvas.drawCircle(center, size.width * 0.33, paint..color = color.withValues(alpha: 0.45));

    // Outer dashed ring
    final r = size.width * 0.44;
    for (double deg = 0; deg < 360; deg += 9) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: r),
        deg * math.pi / 180,
        5 * math.pi / 180,
        false,
        paint..color = color,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
