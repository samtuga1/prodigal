import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AnimatedGridWidget extends StatelessWidget {
  final List<dynamic> children;
  final bool primary;
  final EdgeInsetsGeometry padding;
  final bool shrinkWrap;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final double childAspectRatio;
  final int duration;

  const AnimatedGridWidget({
    required this.children,
    required this.crossAxisCount,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.shrinkWrap = true,
    this.padding = EdgeInsets.zero,
    this.primary = false,
    this.duration = 500,
    this.childAspectRatio = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.count(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        primary: primary,
        padding: padding,
        shrinkWrap: shrinkWrap,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        children: children
            .map((e) => AnimationConfiguration.staggeredGrid(
                  position: children.indexOf(e),
                  duration: Duration(milliseconds: duration),
                  columnCount: crossAxisCount,
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                      child: e,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
