import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: HomePage(),
      initialRoute: '/',
      routes: Routes.getPage(),
    );
  }
}
