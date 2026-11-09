import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class TaskCreationForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController title;
  final TextEditingController description;

  const TaskCreationForm({
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
        spacing: 8.h,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextFormField(
            controller: title,
            hint: AppStrings.addTaskNamePlaceholder,
            label: AppStrings.addTaskNameLabel,
            validator: (value) {
              final error = Validators.requiredField(value);
              return error != null ? context.tr(error) : null;
            },
            textInputAction: TextInputAction.next,
          ),
          CustomTextFormField(
            controller: description,
            hint: AppStrings.addTaskDetailsPlaceholder,
            label: AppStrings.addTaskDetailsLabel,
            validator: (value) {
              final error = Validators.requiredField(value);
              return error != null ? context.tr(error) : null;
            },
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
}
