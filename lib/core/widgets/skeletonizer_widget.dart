import 'package:material_ui/material_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../utils/extensions.dart';

class SkeletonizerWidget extends StatelessWidget {
  final Widget child;

  const SkeletonizerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: context.colorScheme.outlineVariant,
        highlightColor: context.colorScheme.outline.withValues(alpha: 0.50),
      ),
      enableSwitchAnimation: true,
      child: child,
    );
  }
}
