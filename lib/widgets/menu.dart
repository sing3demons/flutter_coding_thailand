import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/routes/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  Menu({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  SharedPreferences prefs;
  var name;

  _initPref() async {
    prefs = await SharedPreferences.getInstance();
    var profile = await prefs.getString('profile');
    var json = jsonDecode(profile);
    setState(() {
      name = json['name'];
    });
    print(name);
  }

  @override
  void initState() {
    _initPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://cdn-images-1.medium.com/max/280/1*X5PBTDQQ2Csztg3a6wofIQ@2x.png'),
              ),
              accountName: name != null ? Text('$name') : Text('KPsing'),
              accountEmail: Text('sing@dev.com'),
            ),
            Column(
              children: [
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
                  selected:
                      ModalRoute.of(context).settings.name == Routes.products
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
                  selected: ModalRoute.of(context).settings.name == Routes.news,
                  title: Text('News'),
                  leading: Icon(Icons.new_releases_sharp),
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamedAndRemoveUntil(
                            Routes.newsstack, (route) => false);
                  },
                ),
                ListTile(
                  selected: ModalRoute.of(context).settings.name == Routes.login
                      ? true
                      : false,
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamedAndRemoveUntil(
                            Routes.usersStack, (route) => false);
                  },
                  leading: FaIcon(FontAwesomeIcons.signInAlt),
                  title: Text('login'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.signOutAlt),
                  title: Text('logout'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
