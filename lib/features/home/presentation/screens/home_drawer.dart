import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeDrawer extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: List.generate(
          5,
          (_) => ListTile(
            leading: FaIcon(FontAwesomeIcons.user),
            title: Text('Mahmoud Mohamed'),
            subtitle: Text('mahmoud.dev@gmail.com'),
          ),
        ),
      ),
    );
  }
}
