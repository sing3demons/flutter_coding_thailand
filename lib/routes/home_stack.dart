import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/pages/about_page.dart';
import 'package:flutter_coding_thailand/pages/contact_page.dart';
import 'package:flutter_coding_thailand/pages/home_page.dart';
import 'package:flutter_coding_thailand/routes/routes.dart';

class HomeStack extends StatefulWidget {
  HomeStack({Key key}) : super(key: key);

  @override
  _HomeStackState createState() => _HomeStackState();
}

class _HomeStackState extends State<HomeStack> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: Routes.home,
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case Routes.home:
            builder = (BuildContext _) => HomePage();
            break;
          case Routes.about:
            builder = (BuildContext _) => AboutPage();
            break;
          case Routes.contact:
            builder = (BuildContext _) => ContactPage();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
