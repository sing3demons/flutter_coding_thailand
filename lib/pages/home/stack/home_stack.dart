import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/pages/home/CustomerPage.dart';
import 'package:flutter_coding_thailand/pages/home/about_page.dart';
import 'package:flutter_coding_thailand/pages/home/company_page.dart';
import 'package:flutter_coding_thailand/pages/home/contact_page.dart';
import 'package:flutter_coding_thailand/pages/home/covid_data.dart';
import 'package:flutter_coding_thailand/pages/home/edit_profile_page.dart';
import 'package:flutter_coding_thailand/pages/home/home_page.dart';
import 'package:flutter_coding_thailand/pages/home/room_page_v2.dart';
import 'package:flutter_coding_thailand/pages/users/login_page.dart';
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
          case Routes.login:
            builder = (BuildContext _) => LoginPage();
            break;
          case Routes.contact:
            builder = (BuildContext _) => ContactPage();
            break;
          case Routes.company:
            builder = (BuildContext _) => CompanyPage();
            break;
          case Routes.covid:
            builder = (BuildContext _) => CovidPage();
            break;
          case Routes.editprofile:
            builder = (BuildContext _) => EditProfilePage();
            break;
          case Routes.room:
            builder = (BuildContext _) => RoomPageV2();
            break;
          case Routes.customer:
            builder = (BuildContext _) => CustomerPage();
            break;

          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
