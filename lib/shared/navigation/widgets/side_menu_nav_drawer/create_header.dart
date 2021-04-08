part of 'side_menu_nav_drawer_widget.dart';

Widget createHeader({
  String headerTitle = 'OncWS',
}) {
  return DrawerHeader(
    margin: EdgeInsets.zero,
    padding: EdgeInsets.zero,
    decoration: const BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.scaleDown,
        image: AssetImage(
          'assets/images/icons/logo.png',
        ),
      ),
    ),
    child: Stack(
      children: <Widget>[
        Positioned(
          bottom: 16.0,
          left: 16.0,
          child: Text(
            headerTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}
