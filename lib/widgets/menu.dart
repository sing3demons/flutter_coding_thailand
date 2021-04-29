import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/redux/acions/action.dart';
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

  _initPref() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });
  }

  @override
  void initState() {
    super.initState();
    _initPref();
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
                    profile != null ? Text('${profile['name']}') : Text(''),
                accountEmail:
                    profile != null ? Text('${profile['email']}') : Text(''),
                otherAccountsPictures: [
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.edit),
                    onPressed: () => Navigator.of(context).pushNamed(
                        Routes.editprofile,
                        arguments: {'name': profile['name']}),
                  )
                ],
              ),
            ),
            Column(
              children: [
                listMenu(
                    route: Routes.home,
                    title: 'Home',
                    icon: Icons.home,
                    onTap: () => Navigator.of(context, rootNavigator: true)
                        .pushNamedAndRemoveUntil(
                            Routes.root, (route) => false)),
                listMenu(
                    route: Routes.products,
                    title: 'products',
                    icon: Icons.shopping_cart,
                    onTap: () => Navigator.of(context, rootNavigator: true)
                        .pushNamedAndRemoveUntil(
                            Routes.productstack, (route) => false)),
                listMenu(
                    route: Routes.news,
                    title: 'News',
                    icon: Icons.new_releases_sharp,
                    onTap: () => Navigator.of(context, rootNavigator: true)
                        .pushNamedAndRemoveUntil(
                            Routes.newsstack, (route) => false)),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                ),
                StoreConnector<AppState, bool>(
                    converter: (store) => store.state.profileState.isLogin,
                    builder: (context, isLogin) => isLogin != true
                        ? _buildDrawerLogin(context)
                        : _buildDrawerLogout(context)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ListTile listMenu(
          {@required String route,
          @required String title,
          @required IconData icon,
          @required Function onTap}) =>
      ListTile(
        selected: ModalRoute.of(context).settings.name == route,
        title: Text(title),
        leading: Icon(icon),
        onTap: onTap,
      );

  ListTile _buildDrawerLogout(BuildContext context) => ListTile(
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
                    Navigator.of(context).pop(); // Dismiss alert dialog
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

                    final store = StoreProvider.of<AppState>(context);

                    store.dispatch(logout(false));

                     Navigator.of(context).pop();
                    await Navigator.pushNamedAndRemoveUntil(
                        context, Routes.login, (route) => false);
                  },
                ),
              ],
            ),
          );
        },
        leading: FaIcon(FontAwesomeIcons.signOutAlt),
        title: Text('logout'),
      );

  ListTile _buildDrawerLogin(BuildContext context) => ListTile(
        selected:
            ModalRoute.of(context).settings.name == Routes.login ? true : false,
        onTap: () async {
          await Navigator.of(context, rootNavigator: true)
              .pushNamedAndRemoveUntil(Routes.login, (route) => false);
        },
        leading: FaIcon(FontAwesomeIcons.signInAlt),
        title: Text('login'),
      );
}
