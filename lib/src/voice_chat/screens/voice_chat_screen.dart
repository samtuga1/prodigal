import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prodigal/src/voice_chat/controller/controller.dart';
import 'package:prodigal/src/voice_chat/screens/voice_chat_detail.dart';
import 'package:prodigal/utils/enums.dart';
import 'package:prodigal/utils/extensions.dart';
import 'package:prodigal/widgets/animated_column.dart';
import 'package:prodigal/widgets/custom_button.dart';
import 'package:prodigal/widgets/custom_text_field.dart';

class VoiceChatScreen extends ConsumerWidget {
  const VoiceChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(voiceChatControllerProvider.notifier);
    final state = ref.watch(voiceChatControllerProvider);
    return Center(
      child: AnimatedColumnWidget(
        mainAxisAlignment: MainAxisAlignment.center,
        verticalOffset: 70,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        animateType: AnimateType.slideUp,
        children: [
          CustomTextField(
            controller: controller.channelCtrl,
            hintText: 'Channel name',
          ),
          20.verticalSpace,
          ValueListenableBuilder(
            valueListenable: controller.channelCtrl,
            builder: (ctx, val, _) {
              return AppButton(
                isValidated: controller.channelCtrl.text.trim().isNotEmpty,
                onPressed: () async {
                  await controller.joinChannel();
                  if (context.mounted) {
                    Navigator.of(context).pushNamed(VoiceChatDetailScreen.route);
                  }
                },
                title: 'Join',
              );
            },
          ),
        ],
      ).paddingSymmetric(horizontal: 20),
    );
  }
}
