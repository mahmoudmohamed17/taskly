import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class UpdateMemoryForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController title;
  final TextEditingController description;

  const UpdateMemoryForm({
    super.key,
    required this.formKey,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          CustomTextFormField(
            controller: title,
            hint: AppStrings.addTaskNamePlaceholder,
            label: AppStrings.addTaskNameLabel,
            validator: (value) {
              final error = Validators.requiredField(value);
              return error != null ? context.tr(error) : null;
            },
          ),
          CustomTextFormField(
            controller: description,
            maxLines: null,
            hint: AppStrings.addTaskDetailsPlaceholder,
            label: AppStrings.addTaskDetailsLabel,
            validator: (value) {
              final error = Validators.requiredField(value);
              return error != null ? context.tr(error) : null;
            },
          ),
        ],
      ),
    );
  }
}
