import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class VoiceSearchResultsScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: Text(
          context.tr(AppStrings.searchVoiceResults),
        ),
        titleTextStyle: context.textTheme.labelLarge,
        automaticallyImplyLeading: true,
      ),
    );
  }
}
