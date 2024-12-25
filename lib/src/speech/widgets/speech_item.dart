import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prodigal/utils/extensions.dart';

class SpeechContainer extends StatelessWidget {
  const SpeechContainer({
    super.key,
    required this.assetPath,
    required this.label,
    required this.onTap,
    required this.icon,
  });
  final String assetPath;
  final String label;
  final VoidCallback onTap;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              assetPath,
              filterQuality: FilterQuality.medium,
            ),
          ),
          Positioned(
            top: 10,
            left: 11,
            child: CircleAvatar(
              radius: 24,
              child: icon,
            ),
          ),
          Positioned(
            left: 11,
            bottom: 60,
            child: Text(
              label,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 17.sp,
              ),
            ),
          )
        ],
      ),
    );
  }
}
