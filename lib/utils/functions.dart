import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prodigal/utils/extensions.dart';
import 'package:toastification/toastification.dart';

void showToast(
  BuildContext context, {
  ToastificationType type = ToastificationType.error,
  required String message,
}) {
  final titleStyle = context.textTheme.bodyMedium?.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.w800,
  );
  toastification.show(
    padding: REdgeInsets.symmetric(horizontal: 12, vertical: 8),
    margin: REdgeInsets.symmetric(horizontal: 12, vertical: 0),
    context: context,
    type: type,
    style: ToastificationStyle.fillColored,
    title: switch (type) {
      ToastificationType.error => Text(
          "An error occurred",
          style: titleStyle?.copyWith(color: Colors.white, fontSize: 18.sp),
        ),
      ToastificationType.success => Text("Success", style: titleStyle?.copyWith(color: Colors.white)),
      _ => const Text("Info"),
    },
    description: Text(message, style: context.textTheme.labelMedium?.copyWith(color: Colors.white)),
    alignment: Alignment.topCenter,
    autoCloseDuration: const Duration(seconds: 4),
    borderRadius: BorderRadius.circular(12.0.r),
    dragToClose: true,
  );
}

Color get randomColor {
  final random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}
