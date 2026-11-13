import 'package:material_ui/material_ui.dart';

AppBar customAppBar({
  Widget? title,
  TextStyle? titleTextStyle,
  List<Widget>? actions,
  bool centerTitle = false,
  bool automaticallyImplyLeading = false,
  double elevation = 0,
}) {
  return AppBar(
    title: title,
    titleTextStyle: titleTextStyle,
    elevation: elevation,
    actions: actions,
    automaticallyImplyLeading: automaticallyImplyLeading,
    centerTitle: centerTitle,
  );
}
