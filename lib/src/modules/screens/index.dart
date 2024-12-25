import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prodigal/src/modules/controller/controller.dart';
import 'package:prodigal/src/modules/widgets/module_card.dart';
import 'package:prodigal/widgets/app_loader.dart';

class ModulesScreen extends ConsumerWidget {
  const ModulesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(modulesControllerProvider);
    final controller = ref.read(modulesControllerProvider.notifier);
    return switch (state.fetching) {
      true => const AppLoader(),
      false => RefreshIndicator.adaptive(
          onRefresh: controller.fetchModules,
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 10),
            itemCount: state.modules.length,
            itemBuilder: (context, index) {
              return ModuleCard(module: state.modules[index]);
            },
            separatorBuilder: (context, index) => 20.verticalSpace,
          ),
        ),
    };
  }
}
