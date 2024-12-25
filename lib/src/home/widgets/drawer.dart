import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:prodigal/injection/injection.dart';
import 'package:prodigal/models/user.dart';
import 'package:prodigal/providers/theme_provider/theme_provider.dart';
import 'package:prodigal/repositories/user.repo.dart';
import 'package:prodigal/src/home/controller/controller.dart';
import 'package:prodigal/utils/extensions.dart';
import 'package:prodigal/widgets/theme_switcher.dart';

class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(homeControllerProvider.notifier);
    final activeTheme = ref.read(themeProviderProvider);
    return SafeArea(
      top: false,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.paddingOf(context).top,
              left: 10.w,
            ),
            height: context.height * 0.2,
            color: context.theme.colorScheme.primary,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.person),
                ),
                10.horizontalSpace,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Transform.translate(
                      offset: const Offset(0, 8),
                      child: FutureBuilder<User?>(
                        future: sl<AuthedUserRepository>().getUser(),
                        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
                          return Text(
                            snapshot.data?.username ?? '',
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontSize: 17.sp,
                              color: switch (activeTheme == ThemeMode.light) {
                                true => Colors.white,
                                false => Colors.black,
                              },
                              fontWeight: FontWeight.bold,
                            ),
                          ).paddingOnly(left: 10);
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'View Profile',
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontSize: 17.sp,
                          color: switch (activeTheme == ThemeMode.light) {
                            true => Colors.white,
                            false => Colors.black,
                          },
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          20.verticalSpace,
          for (int i = 0; i < controller.pages.length; i++)
            ListTile(
              leading: controller.pages[i].icon,
              title: Text(
                controller.pages[i].title,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                HapticFeedback.lightImpact();
                controller.switchPage(i);
                Scaffold.of(context).closeDrawer();
              },
              trailing: const RotatedBox(
                quarterTurns: 2,
                child: Icon(CupertinoIcons.chevron_left),
              ),
            ),
          const Spacer(),
          const ThemeSwitcher(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(
              'Logout',
              style: context.textTheme.bodyMedium?.copyWith(
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () async {
              await sl<AuthedUserRepository>().delete();
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
              }
            },
            trailing: const RotatedBox(
              quarterTurns: 2,
              child: Icon(CupertinoIcons.chevron_left),
            ),
          ),
          8.verticalSpace,
          Center(
            child: FutureBuilder(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                return Text(
                  "Version ${snapshot.data?.version}",
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
