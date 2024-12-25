import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:prodigal/src/speech/controller/controller.dart';
import 'package:prodigal/utils/extensions.dart';
import 'package:prodigal/widgets/custom_text_field.dart';

class Text2speechScreen extends ConsumerWidget {
  static const route = '/Text2speechScreen';
  const Text2speechScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(speechControllerProvider.notifier);
    ref.watch(speechControllerProvider);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: controller.textEditingController,
              minLines: 3,
              maxLines: 5,
            ),
            30.verticalSpace,
            IconButton.filled(
              onPressed: controller.speak,
              icon: const Icon(Bootstrap.megaphone_fill).paddingAll(8),
            ),
          ],
        ).paddingSymmetric(horizontal: 20),
      ),
    );
  }
}
