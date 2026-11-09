import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/cubits/app_flow_cubit.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/custom_text_button.dart';
import '../domain/models/onboarding_model.dart';
import 'onboarding_footer.dart';
import 'onboarding_item.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _controller;
  late final ValueNotifier<int> _currentIndexNotifier;
  final List<OnboardingModel> _items = OnboardingModel.onboardingList();

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _currentIndexNotifier = ValueNotifier<int>(0);
  }

  @override
  void dispose() {
    _controller.dispose();
    _currentIndexNotifier.dispose();
    super.dispose();
  }

  void _onNext() {
    _controller.nextPage(
      duration: AppMotion.slow,
      curve: AppMotion.pulse,
    );
  }

  void _onComplete() {
    context.read<AppFlowCubit>().completeOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.screenMargin.w,
            vertical: AppSpacing.md.h,
          ),
          child: Column(
            children: [
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: ValueListenableBuilder<int>(
                  valueListenable: _currentIndexNotifier,
                  builder: (context, currentIndex, child) {
                    final isLastPage = currentIndex == _items.length - 1;
                    return AnimatedOpacity(
                      opacity: isLastPage ? 0.0 : 1.0,
                      duration: AppMotion.base,
                      child: IgnorePointer(
                        ignoring: isLastPage,
                        child: child,
                      ),
                    );
                  },
                  child: CustomTextButton(
                    text: AppStrings.skip,
                    onPressed: _onComplete,
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _items.length,
                  onPageChanged: (index) {
                    _currentIndexNotifier.value = index;
                  },
                  itemBuilder: (context, index) {
                    final model = _items[index];
                    return OnboardingItem(model: model);
                  },
                ),
              ),
              ValueListenableBuilder<int>(
                valueListenable: _currentIndexNotifier,
                builder: (context, currentIndex, _) {
                  return OnboardingFooter(
                    controller: _controller,
                    total: _items.length,
                    isLastPage: currentIndex == _items.length - 1,
                    onNext: _onNext,
                    onStart: _onComplete,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
