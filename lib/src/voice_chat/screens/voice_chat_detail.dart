import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:prodigal/src/voice_chat/controller/controller.dart';
import 'package:prodigal/utils/extensions.dart';
import 'package:prodigal/widgets/animated_grid_view.dart';
import 'package:prodigal/widgets/app_loader.dart';

class VoiceChatDetailScreen extends ConsumerWidget {
  static const route = '/VoiceChatDetailScreen';
  const VoiceChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(voiceChatControllerProvider.notifier);
    final state = ref.watch(voiceChatControllerProvider);

    return PopScope(
      onPopInvokedWithResult: (didPop, result) async {
        await controller.leaveChannel();
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          minimum: EdgeInsets.symmetric(vertical: 20.h),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: switch (state.initializing) {
              true => const Center(child: AppLoader(strokeWidth: 4)),
              false => Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                      height: context.height,
                      child: Center(
                        child: AnimatedGridWidget(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.h,
                          children: state.users
                              .map(
                                (user) => Stack(
                                  alignment: Alignment.topRight,
                                  fit: StackFit.loose,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 200.h,
                                      decoration: BoxDecoration(
                                        color: user.localColor,
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 25,
                                            child: Text(
                                              user.username.initials,
                                              style: context.textTheme.bodyMedium?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20.sp,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            user.username,
                                            style: context.textTheme.bodyMedium?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (user.speaking)
                                      const SizedBox.square(
                                        dimension: 20,
                                        child: LoadingIndicator(indicatorType: Indicator.lineScale),
                                      ).paddingAll(10)
                                    else
                                      switch (user.muted) {
                                        true => const Icon(Icons.mic_off),
                                        false => const Icon(Icons.mic),
                                      }
                                          .paddingAll(10),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    SizedBox.square(
                      dimension: 60,
                      child: IconButton.filledTonal(
                        onPressed: () => controller.toggleMicrophone(),
                        style: IconButton.styleFrom(),
                        icon: Icon(
                          switch (state.muted) {
                            true => Icons.mic_off,
                            false => Icons.mic,
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                              child: ColoredBox(
                                color: Colors.grey.shade200,
                                child: const Text(
                                  'This meeting is being moderated, please be polite',
                                  style: TextStyle(color: Colors.black),
                                ).paddingAll(5),
                              ),
                            ),
                          ),
                          10.horizontalSpace,
                          const CircleAvatar(
                            radius: 23,
                            child: Padding(
                              padding: EdgeInsets.only(right: 3, bottom: 2),
                              child: Icon(
                                FontAwesome.robot_solid,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 10),
                    ),
                  ],
                ),
            },
          ),
        ),
      ),
    );
  }
}
