import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

import 'core/cubits/app_flow_cubit.dart';
import 'core/cubits/theme_cubit.dart';
import 'core/di/di.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';

class Taskly extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<ThemeCubit>()),
            BlocProvider(create: (_) => getIt<AppFlowCubit>()),
          ],
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                themeMode: themeMode,
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                themeAnimationDuration: const Duration(milliseconds: 1500),
                themeAnimationCurve: Curves.fastOutSlowIn,
                routerConfig: AppRouter.router,
                builder: (context, child) => ToastificationWrapper(child: child!),
              );
            },
          ),
        );
      },
    );
  }
}
