import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/pages/users/login_page.dart';
import 'package:flutter_coding_thailand/routes/routes.dart';

class UsersStack extends StatefulWidget {
  @override
  _UsersStackState createState() => _UsersStackState();
}

class _UsersStackState extends State<UsersStack> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: Routes.login,
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case Routes.login:
            builder = (BuildContext _) => LoginPage();
            break;

          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
