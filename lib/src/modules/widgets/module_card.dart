import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prodigal/models/module.dart';
import 'package:prodigal/src/modules/screens/cakes_screen.dart';
import 'package:prodigal/utils/extensions.dart';
import 'package:prodigal/widgets/custom_button.dart';

class ModuleCard extends StatelessWidget {
  const ModuleCard({super.key, required this.module});
  final Module module;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: context.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        gradient: LinearGradient(
          colors: [
            Colors.blueAccent,
            Colors.blueAccent.withOpacity(0.3),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            module.title,
            style: context.textTheme.bodyMedium?.copyWith(
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            module.description,
            style: context.textTheme.bodyMedium?.copyWith(
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          10.verticalSpace,
          SizedBox(
            width: 130,
            child: AppButton(
              onPressed: () => Navigator.of(context).pushNamed(
                CakesScreen.route,
                arguments: module,
              ),
              title: 'Get Started',
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 20, vertical: 30),
    );
  }
}
