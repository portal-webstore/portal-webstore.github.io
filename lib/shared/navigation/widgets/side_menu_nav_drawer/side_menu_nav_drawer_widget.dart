library side_menu_nav_drawer;

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:testable_web_app/shared/navigation/routes_constant.dart'
    show Routes;

import 'app_info/app_info.dart'
    show getAppInfoTextOrProgressBuilder, getAppNameVersion, mockPackageInfo;

part 'drawer_header.dart';
part 'drawer_item.dart';

class SideMenuNavigationDrawer extends StatelessWidget {
  const SideMenuNavigationDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const _SideMenuNavDrawerHeader(
            title: 'Webstore',
          ),
          _SideMenuNavDrawerItem(
            icon: Icons.home_rounded,
            name: 'Home',
            onTap: () => Navigator.pushReplacementNamed(
              context,
              Routes.home,
            ),
          ),
          const Divider(),
          _SideMenuNavDrawerItem(
            icon: Icons.timer,
            name: 'Timer bloc',
            onTap: () => Navigator.pushReplacementNamed(
              context,
              Routes.timer,
            ),
          ),
          _SideMenuNavDrawerItem(
            icon: Icons.add_alarm,
            name: 'Demo boilerplate counter',
            onTap: () => Navigator.pushReplacementNamed(
              context,
              Routes.boilerplateCounter,
            ),
          ),
          _SideMenuNavDrawerItem(
            icon: Icons.add_alarm_outlined,
            name: 'Sample counter bloc',
            onTap: () => Navigator.pushReplacementNamed(
              context,
              Routes.counter,
            ),
          ),
          const Divider(),
          ListTile(
            title: FutureBuilder<PackageInfo>(
              future: getAppNameVersion(),
              builder: getAppInfoTextOrProgressBuilder,
              initialData: mockPackageInfo,
            ),
          )
        ],
      ),
    );
  }
}
