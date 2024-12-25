import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:prodigal/src/home/controller/controller.dart';
import 'package:prodigal/src/home/widgets/drawer.dart';
import 'package:prodigal/utils/extensions.dart';

class HomeScreen extends ConsumerWidget {
  static const route = '/HomeScreen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeControllerProvider);
    final controller = ref.read(homeControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (ctx) {
          return IconButton(
            onPressed: Scaffold.of(ctx).openDrawer,
            icon: const Icon(FontAwesome.bars_solid),
          );
        }),
        centerTitle: true,
        title: Text(
          controller.pages[state.selected!].title,
          style: context.textTheme.bodyMedium?.copyWith(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      drawer: Drawer(
        width: context.width * 0.8,
        child: const HomeDrawer(),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: controller.pages[state.selected!].page,
      ),
    );
  }
}
