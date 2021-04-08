import 'package:flutter/material.dart';
import 'package:testable_web_app/shared/navigation/routes_constant.dart';

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
          const SideMenuNavDrawerHeader(
            title: 'Webstore',
          ),
          SideMenuNavDrawerItem(
            icon: Icons.home_rounded,
            name: 'Home',
            onTap: () => Navigator.pushReplacementNamed(
              context,
              Routes.home,
            ),
          ),
          const Divider(),
          SideMenuNavDrawerItem(
            icon: Icons.home_rounded,
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
