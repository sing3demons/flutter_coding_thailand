import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/redux/reducer/app_reducer.dart';
import 'package:flutter_coding_thailand/routes/routes.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  Menu({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  SharedPreferences prefs;
  String token;
  String name;

  _initPref() async {
    prefs = await SharedPreferences.getInstance();
    var profile = prefs.getString('profile');
    var json = jsonDecode(profile);

    setState(() {
      name = json['name'];
      token = prefs.getString('token');
    });
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
            StoreConnector<AppState, Map<String, dynamic>>(
              converter: (store) => store.state.profileState.profile,
              builder: (context, profile) => UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://cdn-images-1.medium.com/max/280/1*X5PBTDQQ2Csztg3a6wofIQ@2x.png'),
                ),
                accountName:
                    name != null ? Text('${profile['name']}') : Text('KPsing'),
                accountEmail: Text('${profile['email']}') ?? Text('s@dev.com'),
              ),
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                ),
                token == null
                    ? ListTile(
                        selected:
                            ModalRoute.of(context).settings.name == Routes.login
                                ? true
                                : false,
                        onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamedAndRemoveUntil(
                                  Routes.usersStack, (route) => false);
                        },
                        leading: FaIcon(FontAwesomeIcons.signInAlt),
                        title: Text('login'),
                      )
                    : ListTile(
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text('แจ้งเตือน'),
                              content: Text('Are you sure you want to logout?'),
                              actions: [
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Dismiss alert dialog
                                  },
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Colors.red,
                                  ),
                                  child: Text('Logout'),
                                  onPressed: () async {
                                    await prefs.remove('token');
                                    await prefs.remove('profile');

                                    Navigator.of(context, rootNavigator: true)
                                        .pushNamedAndRemoveUntil(
                                            Routes.usersStack,
                                            (route) =>
                                                false); // Dismiss alert dialog
                                  },
                                ),
                              ],
                            ),
                          );
                        },
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
