import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:prodigal/utils/enums.dart';

class AnimatedListView extends StatelessWidget {
  final List<Widget> children;
  final AnimateType animateType;
  final EdgeInsets padding;
  final int duration, delay;
  final double slideOffset;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final bool isBuilder;
  final int itemCount;
  final Widget child;
  final Widget? divider;

  const AnimatedListView({
    super.key,
    required this.children,
    this.animateType = AnimateType.slideLeft,
    this.padding = EdgeInsets.zero,
    this.duration = 500,
    this.slideOffset = 50.0,
    this.controller,
    this.physics,
  })  : isBuilder = false,
        itemCount = 0,
        child = const SizedBox(),
        divider = const SizedBox(),
        delay = 0;

  const AnimatedListView.separated({
    super.key,
    required this.itemCount,
    required this.child,
    this.animateType = AnimateType.slideLeft,
    this.divider,
    this.padding = EdgeInsets.zero,
    this.duration = 500,
    this.delay = 200,
    this.slideOffset = 100.0,
    this.controller,
    this.physics,
  })  : isBuilder = true,
        children = const [];

  @override
  Widget build(BuildContext context) {
    Widget widget = const SizedBox.shrink();

    if (isBuilder) {
      widget = AnimationLimiter(
        child: ListView.separated(
          physics: physics,
          controller: controller,
          padding: padding,
          itemCount: itemCount,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              delay: const Duration(milliseconds: 200),
              duration: Duration(milliseconds: duration),
              child: SlideAnimation(
                verticalOffset: slideOffset,
                child: FadeInAnimation(child: child),
              ),
            );
          },
          separatorBuilder: (context, index) => AnimationConfiguration.staggeredList(
            position: index,
            duration: Duration(milliseconds: duration),
            child: SlideAnimation(
              verticalOffset: slideOffset,
              child: divider == null ? const SizedBox.shrink() : divider!,
            ),
          ),
        ),
      );
    } else {
      if (animateType == AnimateType.slideUp || animateType == AnimateType.slideDown) {
        widget = AnimationLimiter(
          child: ListView(
            shrinkWrap: true,
            controller: controller,
            padding: padding,
            physics: physics,
            children: AnimationConfiguration.toStaggeredList(
              duration: Duration(milliseconds: duration),
              childAnimationBuilder: (widget) => SlideAnimation(
                verticalOffset: switch (animateType == AnimateType.slideUp) {
                  true => slideOffset,
                  false => -slideOffset,
                },
                child: SlideAnimation(child: widget),
              ),
              children: children,
            ),
          ),
        );
      }

      if (animateType == AnimateType.slideLeft || animateType == AnimateType.slideRight) {
        widget = AnimationLimiter(
          child: ListView(
            shrinkWrap: true,
            controller: controller,
            padding: padding,
            children: AnimationConfiguration.toStaggeredList(
              duration: Duration(milliseconds: duration),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: switch (animateType == AnimateType.slideLeft) {
                  true => slideOffset,
                  false => -slideOffset,
                },
                child: FadeInAnimation(child: widget),
              ),
              children: children,
            ),
          ),
        );
      }
    }

    return widget;
  }
}
