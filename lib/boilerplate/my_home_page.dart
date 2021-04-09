import 'package:flutter/material.dart';
import 'package:testable_web_app/shared/navigation/widgets/side_menu_nav_drawer/side_menu_nav_drawer_widget.dart'
    show SideMenuNavigationDrawer;

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    this.title,
  }) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      drawer: const SideMenuNavigationDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Home',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Do something',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
