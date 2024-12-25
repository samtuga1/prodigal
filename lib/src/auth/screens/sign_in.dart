import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prodigal/src/auth/controller/controller.dart';
import 'package:prodigal/src/home/home_screen.dart';
import 'package:prodigal/utils/enums.dart';
import 'package:prodigal/utils/extensions.dart';
import 'package:prodigal/utils/functions.dart';
import 'package:prodigal/widgets/animated_column.dart';
import 'package:prodigal/widgets/app_loader.dart';
import 'package:prodigal/widgets/custom_button.dart';
import 'package:prodigal/widgets/custom_text_field.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(authControllerProvider.notifier);
    final state = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (prev, current) {
      if (prev?.loadingSuccess != current.loadingSuccess) {
        if (current.loadingSuccess == true) {
          Navigator.pushReplacementNamed(context, HomeScreen.route);
        } else if (current.loadingSuccess == false) {
          showToast(context, message: current.loadingError!);
        }
      }
    });

    return Scaffold(
      body: SafeArea(
        child: CustomPaint(
          painter: _BackroundPainter1(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: AnimatedColumnWidget(
                duration: 250,
                verticalOffset: 30,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                animateType: AnimateType.slideUp,
                children: [
                  (context.height * 0.03).verticalSpace,
                  Text(
                    switch (state.usernameExists) {
                      true => 'Seems username exists, kindly login',
                      false => "Let’s set up your profile",
                    },
                    textAlign: TextAlign.start,
                    style: context.textTheme.titleLarge!.copyWith(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  40.verticalSpace,
                  Text(
                    "Enter username",
                    textAlign: TextAlign.start,
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  5.verticalSpace,
                  CustomTextField(
                    hintText: 'Enter username',
                    controller: controller.usernameCtrl,
                    onChanged: (_) {
                      controller.debounce.run(controller.checkUserExist);
                    },
                    suffixIcon: switch (state.checkingUserExist) {
                      true => const SizedBox.square(
                          dimension: 18,
                          child: AppLoader(),
                        ).paddingOnly(right: 10),
                      false => null,
                    },
                  ),
                  20.verticalSpace,
                  Text(
                    "Enter password",
                    textAlign: TextAlign.start,
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  5.verticalSpace,
                  CustomTextField(hintText: 'Enter password', controller: controller.passwordCtrl),
                  40.verticalSpace,
                  AnimatedBuilder(
                    animation: Listenable.merge([controller.passwordCtrl, controller.usernameCtrl]),
                    builder: (ctx, _) {
                      final validFields = controller.validateFields;
                      return AppButton(
                        title: switch (state.usernameExists) {
                          true => 'Login',
                          false => "Get started",
                        },
                        isValidated: !(state.checkingUserExist || state.loading) && validFields,
                        isBusy: state.loading,
                        onPressed: () {
                          if (state.usernameExists) {
                            controller.login();
                          } else {
                            controller.register();
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BackroundPainter1 extends CustomPainter {
  _BackroundPainter1(this.context);

  final BuildContext context;

  @override
  void paint(Canvas canvas, Size size) {
    final topCircle = Rect.fromCircle(
      center: Offset((size.width / 2) - (size.width / 2.2), size.height / 30),
      radius: size.width / 3.5,
    );

    final bottomCircle = Rect.fromCircle(
      center: Offset((size.width + size.width * 0.1), size.height + (size.height * 0.1)),
      radius: size.width / 2.3,
    );

    _drawCircleGradient(
      canvas,
      topCircle,
      Colors.amber.withOpacity(0.8),
    );

    _drawCircleGradient(
      canvas,
      bottomCircle,
      Colors.deepPurple.withOpacity(0.5),
    );
  }

  _drawCircleGradient(Canvas canvas, Rect rect, Color color) {
    final paint = Paint()..color = color;

    paint.imageFilter = ImageFilter.blur(sigmaX: 50, sigmaY: 50, tileMode: TileMode.decal);

    canvas.drawCircle(rect.center, rect.width / 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
