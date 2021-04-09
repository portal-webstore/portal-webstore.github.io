library side_menu_nav_drawer;

import 'package:flutter/material.dart';
import 'package:testable_web_app/shared/navigation/routes_constant.dart'
    show Routes;

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
        ],
      ),
    );
  }
}
