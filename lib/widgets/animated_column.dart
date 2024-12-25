import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:prodigal/utils/enums.dart';

class AnimatedColumnWidget extends StatelessWidget {
  final List<Widget> children;
  final AnimateType animateType;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final int duration;
  final double verticalOffset;
  final double horizontalOffset;

  const AnimatedColumnWidget({
    super.key,
    required this.children,
    this.animateType = AnimateType.slideUp,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.duration = 350,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.verticalOffset = 50,
    this.horizontalOffset = 50,
  });

  @override
  Widget build(BuildContext context) {
    if (animateType == AnimateType.slideUp || animateType == AnimateType.slideDown) {
      return AnimationLimiter(
        child: Column(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisSize: mainAxisSize,
          children: AnimationConfiguration.toStaggeredList(
            duration: Duration(milliseconds: duration),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: switch (animateType == AnimateType.slideUp) {
                true => verticalOffset,
                false => -verticalOffset,
              },
              child: FadeInAnimation(child: widget),
            ),
            children: children,
          ),
        ),
      );
    }
    if (animateType == AnimateType.slideRight) {
      return AnimationLimiter(
        child: Column(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisSize: mainAxisSize,
          children: AnimationConfiguration.toStaggeredList(
            duration: Duration(milliseconds: duration),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: -horizontalOffset,
              child: FadeInAnimation(child: widget),
            ),
            children: children,
          ),
        ),
      );
    } else {
      return AnimationLimiter(
        child: Column(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisSize: mainAxisSize,
          children: AnimationConfiguration.toStaggeredList(
            duration: Duration(milliseconds: duration),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: horizontalOffset,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: children,
          ),
        ),
      );
    }
  }
}
