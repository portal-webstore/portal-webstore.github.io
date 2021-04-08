part of 'side_menu_nav_drawer_widget.dart';

class SideMenuNavDrawerItem extends StatelessWidget {
  const SideMenuNavDrawerItem({
    Key? key,
    required this.icon,
    required this.name,
    required this.onTap,
    this.nameStyle,
    this.iconColour,
  }) : super(key: key);

  final IconData icon;
  final String name;
  final GestureTapCallback onTap;
  final TextStyle? nameStyle;
  final Color? iconColour;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            color: iconColour,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              name,
              style: nameStyle,
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
