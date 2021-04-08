part of 'side_menu_nav_drawer_widget.dart';

class SideMenuNavDrawerHeader extends StatelessWidget {
  const SideMenuNavDrawerHeader(
    Key? key,
    this._headerTitle,
  ) : super(key: key);

  final String _headerTitle;

  @override
  Widget build(BuildContext context) {
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
              _headerTitle,
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
}
