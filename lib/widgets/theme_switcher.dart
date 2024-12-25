import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prodigal/providers/theme_provider/theme_provider.dart';
import 'package:prodigal/utils/extensions.dart';

class ThemeSwitcher extends ConsumerStatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends ConsumerState<ThemeSwitcher> with TickerProviderStateMixin {
  late AnimationController themeSwitchController;
  late AnimationController themeScaleController;
  late Animation<double> themeSwitchAngle;
  late Animation<double> themeScaleValue;
  @override
  void initState() {
    // get the theme from get it
    themeSwitchController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
    );
    themeSwitchAngle = CurvedAnimation(
      parent: Tween<double>(begin: 0, end: 1).animate(themeSwitchController),
      curve: Curves.fastOutSlowIn,
    );
    themeScaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
    );
    themeScaleValue = CurvedAnimation(
      parent: Tween<double>(begin: 0, end: 1).animate(themeScaleController),
      curve: Curves.fastOutSlowIn,
    );
    super.initState();
  }

  @override
  void dispose() {
    themeScaleController.dispose();
    themeSwitchController.dispose();
    super.dispose();
  }

  void themeSwitchTapped(bool val) {
    if (themeSwitchController.isCompleted) {
      themeSwitchController.reverse();
      themeScaleController.animateTo(0.4).then((value) => themeScaleController.animateBack(0));
    } else {
      themeSwitchController.forward();
      themeScaleController.animateTo(0.4).then((value) => themeScaleController.animateBack(0));
    }
    late ThemeMode theme;
    final isLight = context.theme.brightness == Brightness.light;
    if (isLight) {
      theme = ThemeMode.dark;
    } else {
      theme = ThemeMode.light;
    }

    ref.read(themeProviderProvider.notifier).toggleTheme(theme);
  }

  @override
  Widget build(BuildContext context) {
    final themeStatus = ref.watch(themeProviderProvider);
    return ListTile(
      // titleStyle: context.getTheme.textTheme.titleLarge,
      trailing: Switch.adaptive(
        activeColor: context.theme.primaryColor,
        value: themeStatus == ThemeMode.dark,
        onChanged: themeSwitchTapped,
      ),
      title: Text(
        'Theme',
        style: context.textTheme.bodyMedium?.copyWith(
          fontSize: 17.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: AnimatedBuilder(
        animation: themeSwitchAngle,
        builder: (ctx, child) => AnimatedBuilder(
          animation: themeScaleController,
          builder: (ctx, _) => Transform.scale(
            scale: (themeScaleValue.value + 1),
            child: Transform.rotate(
              angle: themeSwitchAngle.value * pi,
              child: Image.asset(
                'assets/images/color-palette.png',
                height: 25,
                width: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
