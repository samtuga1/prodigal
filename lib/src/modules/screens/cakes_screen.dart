import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prodigal/models/module.dart';
import 'package:prodigal/src/modules/controller/controller.dart';
import 'package:prodigal/utils/enums.dart';
import 'package:prodigal/utils/extensions.dart';
import 'package:prodigal/widgets/animated_list.dart';
import 'package:prodigal/widgets/app_loader.dart';
import 'package:prodigal/widgets/custom_button.dart';
import 'package:prodigal/widgets/custom_cache_image.dart';
import 'package:prodigal/widgets/custom_text_field.dart';

class CakesScreen extends ConsumerStatefulWidget {
  static const route = '/CakesScreen';
  const CakesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CakesScreenState();
}

class _CakesScreenState extends ConsumerState<CakesScreen> {
  Module? module;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      module = ModalRoute.of(context)!.settings.arguments as Module;
      ref.read(modulesControllerProvider.notifier).fetchCakes(module!.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(modulesControllerProvider);
    return FutureBuilder(
      future: Future.value(1),
      builder: (ctx, _) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              module?.title ?? "",
              style: context.textTheme.bodyMedium?.copyWith(
                fontSize: 21.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: SizedBox(
            height: context.height,
            child: switch (state.fetchingCakes) {
              true => const AppLoader(),
              false => AnimatedListView(
                  slideOffset: 100,
                  padding: const EdgeInsets.only(right: 20, left: 10, top: 10, bottom: 30),
                  children: [
                    for (var i = 0; i < state.cakes.length; i++)
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  child: Text('${i + 1}'),
                                ),
                                const Expanded(
                                  child: VerticalDivider(thickness: 1),
                                ),
                              ],
                            ),
                            10.horizontalSpace,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  switch (state.cakes[i].contentType) {
                                    CakeContentType.image => ClipRRect(
                                        borderRadius: BorderRadius.circular(8.r),
                                        child: CustomCacheImage(
                                          state.cakes[i].content,
                                          height: 250,
                                          fit: BoxFit.fill,
                                          width: double.maxFinite,
                                        ),
                                      ),
                                    CakeContentType.text => Text(
                                        state.cakes[i].content,
                                        style: context.textTheme.bodyMedium?.copyWith(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        maxLines: 5,
                                      ),
                                    _ => const SizedBox(), // handle audio here
                                  },
                                  10.verticalSpace,
                                  Text(
                                    state.cakes[i].instruction,
                                    style: context.textTheme.bodyMedium?.copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 5,
                                  ),
                                  10.verticalSpace,
                                  const CustomTextField(minLines: 3, maxLines: 10),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ).paddingOnly(bottom: 30),
                    20.verticalSpace,
                    AppButton(
                      onPressed: () {},
                      title: 'Submit',
                    ),
                  ],
                ),
            },
          ),
        );
      },
    );
  }
}
