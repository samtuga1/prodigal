import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prodigal/data/theme/app_theme.dart';
import 'package:prodigal/providers/theme_provider/theme_provider.dart';
import 'package:prodigal/router/router.dart';
import 'package:toastification/toastification.dart';

GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      rebuildFactor: (old, data) => true,
      useInheritedMediaQuery: true,
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Prodigal',
          onGenerateRoute: AppRouter.onGenerateRoute,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ref.watch(themeProviderProvider),
          scrollBehavior: const CupertinoScrollBehavior(),
          navigatorKey: navigatorKey,
          builder: (context, child) {
            return ToastificationConfigProvider(
              config: const ToastificationConfig(
                alignment: Alignment.center,
                itemWidth: 440,
                animationDuration: Duration(milliseconds: 500),
              ),
              child: child!,
            );
          },
        );
      },
    );
  }
}
