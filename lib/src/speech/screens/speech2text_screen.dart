import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prodigal/src/speech/controller/controller.dart';
import 'package:prodigal/src/speech/widgets/equalizer.dart';
import 'package:prodigal/utils/extensions.dart';
import 'package:prodigal/widgets/frequency_animation_shader.dart';
import 'package:prodigal/widgets/shockwave_shader.dart';

class Speech2TextScreen extends ConsumerStatefulWidget {
  static const route = '/Speech2TextScreen';
  const Speech2TextScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Speech2TextScreenState();
}

class _Speech2TextScreenState extends ConsumerState<Speech2TextScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(speechControllerProvider.notifier).initializeSpeech();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(speechControllerProvider);
    final controller = ref.read(speechControllerProvider.notifier);

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        ref.read(speechControllerProvider.notifier).disposeTicker();
      },
      child: AnimatedBuilder(
        animation: Listenable.merge([
          controller.data,
          controller.data2Animation,
          controller.elapsed,
          controller.shockwaveAnimationStart,
        ]),
        builder: (ctx, _) {
          return Material(
            child: ShockwaveShader(
              elapsed: controller.elapsed.value,
              shockwaveAnimationStart: controller.shockwaveAnimationStart.value,
              child: FrequencyAnimationShader(
                listening: state.listeningToSpeech,
                elapsed: controller.elapsed.value,
                data2Animation: controller.data2Animation.value,
                child: Container(
                  color: context.theme.scaffoldBackgroundColor,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: SafeArea(
                          child: Text(
                            state.speech2TextString,
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontSize: 20.sp,
                            ),
                          ).paddingSymmetric(horizontal: 20, vertical: 60),
                        ),
                      ),
                      Positioned(
                        bottom: 120,
                        left: 30,
                        right: 30,
                        height: context.height * 0.2,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          child: switch (state.listeningToSpeech) {
                            true => Equalizer(data: controller.data.value),
                            false => const SizedBox.shrink(),
                          },
                        ),
                      ),
                      Positioned(
                        right: 0,
                        left: 0,
                        bottom: MediaQuery.paddingOf(context).bottom + 20,
                        child: GestureDetector(
                          onLongPress: controller.listenToSpeech,
                          onLongPressEnd: (_) => controller.stopListening(),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: switch (state.listeningToSpeech) {
                                  true => context.theme.scaffoldBackgroundColor,
                                  false => null,
                                },
                                child: switch (state.listeningToSpeech) {
                                  true => null,
                                  false => const Icon(Icons.mic),
                                },
                              ),
                              if (!state.listeningToSpeech) const Text('Press and hold'),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.paddingOf(context).top + 10,
                        left: 5,
                        child: const BackButton(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
