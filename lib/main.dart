import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/pages/news/stack/news_stack.dart';
import 'package:flutter_coding_thailand/pages/product/stack/product_stack.dart';
import 'package:flutter_coding_thailand/pages/home/stack/home_stack.dart';
import 'package:flutter_coding_thailand/redux/reducer/app_reducer.dart';
import 'package:flutter_coding_thailand/routes/routes.dart';
import 'package:flutter_coding_thailand/pages/users/stack/users_stack.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:redux/redux.dart';

String token;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  token = pref.getString('token');
  final store = Store<AppState>(appReducer, initialState: AppState.initial());
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  // const MyApp({Key key}) : super(key: key);
  final Store<AppState> store;
  const MyApp({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          Routes.root: (BuildContext context) => HomeStack(),
          Routes.productstack: (context) => ProductStack(),
          Routes.usersStack: (context) =>
              token == null ? UsersStack() : HomeStack(),
          Routes.newsstack: (context) => NewsStack(),
        },
      ),
    );
  }
}
