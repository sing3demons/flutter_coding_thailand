import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/routes/product_stack.dart';
import 'package:flutter_coding_thailand/routes/home_stack.dart';
import 'package:flutter_coding_thailand/routes/routes.dart';
import 'package:flutter_coding_thailand/routes/users_stack.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: LoginPage(),
      initialRoute: '/',
      routes: {
        Routes.root: (BuildContext context) => HomeStack(),
        Routes.productstack: (context) => ProductStack(),
        Routes.usersStack: (context) => UsersStack(),
      },
    );
  }
}
