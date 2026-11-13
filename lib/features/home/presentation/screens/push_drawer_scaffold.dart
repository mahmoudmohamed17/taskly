import 'package:material_ui/material_ui.dart';

import '../../../../core/utils/extensions.dart';

class PushDrawerScaffold extends StatefulWidget {
  final Widget drawer;
  final Widget child;
  /// Indicates how much width of the screen the drawer would take. The value
  /// must be between 0 and 1.
  final double widthFactor;

  const PushDrawerScaffold({
    super.key,
    required this.drawer,
    required this.child,
    this.widthFactor = 0.87,
  }) : assert(
         widthFactor > 0 && widthFactor <= 1,
         'widthFactor must be greater than 0 and at most 1',
       );

  @override
  State<PushDrawerScaffold> createState() => PushDrawerScaffoldState();
}

class PushDrawerScaffoldState extends State<PushDrawerScaffold> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
  );

  void open() => _c.forward();
  void close() => _c.reverse();
  void toggle() => _c.isDismissed ? open() : close();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenW = context.screenWidth;
    final drawerW = screenW * widget.widthFactor;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final sign = isRtl ? -1.0 : 1.0; // RTL: page moves left, LTR: page moves right

    return GestureDetector(
      onHorizontalDragUpdate: (d) {
        _c.value += (d.primaryDelta! * sign) / drawerW;
      },
      onHorizontalDragEnd: (d) {
        final v = d.primaryVelocity! * sign;
        if (v.abs() > 700) {
          v > 0 ? open() : close();
        } else {
          _c.value > 0.5 ? open() : close();
        }
      },
      child: Stack(
        children: [
          // Drawer sits underneath, at the start edge (right in RTL)
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: SizedBox(
              width: drawerW,
              height: double.infinity,
              child: widget.drawer,
            ),
          ),

          // Page on top, pushed aside
          AnimatedBuilder(
            animation: _c,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(sign * drawerW * _c.value, 0),
                child: Stack(
                  children: [
                    child!,
                    // tap the visible part of the page to close
                    if (_c.value > 0)
                      Positioned.fill(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: close,
                          child: Container(color: Colors.black45.withValues(alpha: 0.4)),
                        ),
                      ),
                  ],
                ),
              );
            },
            child: Material(
              // elevation: 8,
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}
