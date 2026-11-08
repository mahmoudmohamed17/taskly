import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/app_toast.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/memory_category_selection_widget.dart';
import '../../cubits/add_memory_cubit.dart';
import 'memory_attachments_widget.dart';
import 'memory_creation_form.dart';

class MemoryCreationBottomSheet extends StatefulWidget {
  const MemoryCreationBottomSheet({super.key});

  @override
  State<MemoryCreationBottomSheet> createState() => _MemoryCreationBottomSheetState();
}

class _MemoryCreationBottomSheetState extends State<MemoryCreationBottomSheet> {
  late final TextEditingController _title;
  late final TextEditingController _description;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  MemoryCategory? _selectedCategory;
  final ValueNotifier<bool?> _isCategorySelected = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    _title = TextEditingController();
    _description = TextEditingController();
  }

  void _addCategory() {
    final isFormValid = _formKey.currentState?.validate() ?? false;
    final isCategoryValid = _selectedCategory != null;

    if (!isCategoryValid) {
      _isCategorySelected.value = false;
    }
    if (isFormValid && isCategoryValid) {
      context.read<AddMemoryCubit>().addMemory(
        title: _title.text,
        description: _description.text,
        category: _selectedCategory!,
      );
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _isCategorySelected.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddMemoryCubit, AddMemoryState>(
      listener: (context, state) {
        if (state is AddMemorySuccess) {
          context.pop();
          AppToast.success(context.tr(AppStrings.addTaskSaved));
        } else if (state is AddMemoryError) {
          AppToast.error(context.tr(state.message));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16.h,
            children: [
              _header(context),
              MemoryCreationForm(
                formKey: _formKey,
                title: _title,
                description: _description,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  MemoryCategorySelectionWidget(
                    onSelected: (category) {
                      _isCategorySelected.value = true;
                      _selectedCategory = category;
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: _isCategorySelected,
                    builder: (context, value, child) {
                      final showError = value == false;
                      return showError
                          ? Text(
                              context.tr(AppStrings.addTaskCategoryNotSet),
                              style: context.textTheme.labelMedium?.copyWith(
                                color: context.colorScheme.error,
                              ),
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                ],
              ),
              const MemoryAttachmentsWidget(),
              CustomElevatedButton(
                text: AppStrings.addTaskSave,
                onPressed: _addCategory,
                icon: const Icon(Icons.lock),
                iconAlignment: IconAlignment.end,
                width: double.infinity,
              ),
              16.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return ListTile(
      title: Text(
        context.tr(AppStrings.addTaskTitle),
        style: context.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        context.tr(AppStrings.addTaskSubtitle),
        style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.outline),
      ),
      trailing: GestureDetector(
        onTap: () => context.pop(),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: context.colorScheme.primaryContainer,
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.all(8.sp),
          child: const Icon(Icons.close),
        ),
      ),
      contentPadding: EdgeInsets.zero,
    );
  }
}
