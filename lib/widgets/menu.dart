import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/routes/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Menu extends StatefulWidget {
  Menu({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.home, (route) => false);
              },
            ),
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.cartArrowDown,
                color: Colors.grey,
              ),
              title: Text('products'),
              onTap: () {
                Navigator.pushNamed(context, Routes.products);
              },
            ),
          ],
        ),
      ),
    );
  }
}
