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
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://cdn-images-1.medium.com/max/280/1*X5PBTDQQ2Csztg3a6wofIQ@2x.png'),
              ),
              accountName: Text('KPsing'),
              accountEmail: Text('sing@dev.com'),
            ),
            ListTile(
              selected: ModalRoute.of(context).settings.name == Routes.home
                  ? true
                  : false,
              leading: FaIcon(FontAwesomeIcons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamedAndRemoveUntil(Routes.root, (route) => false);
              },
            ),
            ListTile(
              selected: ModalRoute.of(context).settings.name == Routes.products
                  ? true
                  : false,
              leading: FaIcon(
                FontAwesomeIcons.cartArrowDown,
                color: Colors.grey,
              ),
              title: Text('products'),
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamedAndRemoveUntil(
                        Routes.productstack, (route) => false);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Setting'),
            ),
            Spacer(),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.signOutAlt),
              title: Text('logout'),
            ),
          ],
        ),
      ),
    );
  }
}
