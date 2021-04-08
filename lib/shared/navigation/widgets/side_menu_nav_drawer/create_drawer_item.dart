part of 'side_menu_nav_drawer_widget.dart';

Widget createDrawerItem({
  required IconData icon,
  required String name,
  required GestureTapCallback onTap,
  TextStyle? nameStyle,
  Color? iconColour,
}) {
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
