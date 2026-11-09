import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/models/task_model.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_toast.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/task_category_selection_widget.dart';
import '../cubits/edit_memory_cubit.dart';
import '../wigdets/editable_attachments_widget.dart';
import '../wigdets/update_task_form.dart';

class EditTaskScreen extends StatefulWidget {
  final TaskModel model;

  const EditTaskScreen({super.key, required this.model});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _title;
  late final TextEditingController _description;
  late TaskCategory _selectedCategory;
  final ValueNotifier<bool> _isModelUpdated = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    context.read<EditMemoryCubit>().initializeAttachments(widget.model.attachments);
    _selectedCategory = widget.model.category;
    _title = TextEditingController(text: widget.model.title)..addListener(_checkIfUpdated);
    _description = TextEditingController(text: widget.model.description)..addListener(_checkIfUpdated);
  }

  void _checkIfUpdated() {
    final titleChanged = _title.text.trim() != widget.model.title.trim();
    final descriptionChanged = _description.text.trim() != widget.model.description.trim();
    final categoryChanged = _selectedCategory != widget.model.category;

    final hasChanges =
        titleChanged || descriptionChanged || categoryChanged || context.read<EditMemoryCubit>().hasAttachmentChanges;
    final isNotEmpty = _title.text.trim().isNotEmpty && _description.text.trim().isNotEmpty;

    _isModelUpdated.value = hasChanges && isNotEmpty;
  }

  void _onUpdate() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    context.read<EditMemoryCubit>().updateMemory(
      id: widget.model.id,
      title: _title.text.trim(),
      description: _description.text.trim(),
      category: _selectedCategory,
    );
  }

  @override
  void dispose() {
    _isModelUpdated.dispose();
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditMemoryCubit, EditMemoryState>(
      listener: (context, state) {
        if (state is EditAttachmentsUpdated) {
          _checkIfUpdated();
        } else if (state is EditMemorySuccess) {
          context.pop();
          AppToast.success(context.tr(AppStrings.editTaskUpdatedSuccessfully));
        } else if (state is EditMemoryError) {
          AppToast.error(context.tr(AppStrings.errorTaskUpdateFailed));
        }
      },
      child: Scaffold(
        appBar: customAppBar(
          title: Text(context.tr(AppStrings.editTaskTitle)),
          automaticallyImplyLeading: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            UpdateTaskForm(formKey: _formKey, title: _title, description: _description),
            18.verticalSpace,
            TaskCategorySelectionWidget(
              initialCategory: widget.model.category,
              onSelected: (category) {
                _selectedCategory = category;
                _checkIfUpdated();
              },
              gridItemColor: context.colorScheme.surfaceContainerHigh,
            ),
            18.verticalSpace,
            const EditableAttachmentsWidget(),
            24.verticalSpace,
            ValueListenableBuilder<bool>(
              valueListenable: _isModelUpdated,
              builder: (context, isUpdated, child) {
                return CustomElevatedButton(
                  onPressed: isUpdated ? _onUpdate : null,
                  width: double.infinity,
                  text: AppStrings.editTaskUpdate,
                  icon: const Icon(Icons.check),
                  backgroundColor: isUpdated
                      ? null
                      : WidgetStatePropertyAll(context.colorScheme.surfaceContainerHighest),
                );
              },
            ),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}
