import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/pages/home/CustomerPage.dart';
import 'package:flutter_coding_thailand/pages/news/stack/news_stack.dart';
import 'package:flutter_coding_thailand/pages/product/stack/product_stack.dart';
import 'package:flutter_coding_thailand/pages/home/stack/home_stack.dart';
import 'package:flutter_coding_thailand/pages/users/login_page.dart';
import 'package:flutter_coding_thailand/redux/reducer/app_reducer.dart';
import 'package:flutter_coding_thailand/routes/routes.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:redux/redux.dart';

String token;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  token = pref.getString('token');
  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [thunkMiddleware],
  );
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  // const MyApp({Key key, this.store}) : super(key: key);
  final Store<AppState> store;
  MyApp({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, bool>(
          converter: (store) => store.state.profileState.isLogin,
          builder: (context, isLogin) {
            return MaterialApp(
              initialRoute: '/',
              routes: {
                Routes.root: (BuildContext context) =>
                    isLogin != true ? LoginPage() : HomeStack(),
                Routes.home: (context) => HomeStack(),
                Routes.login: (context) => LoginPage(),
                Routes.productstack: (context) => ProductStack(),
                Routes.newsstack: (context) => NewsStack(),
                Routes.customer: (context) => CustomerPage(),
              },
            );
          }),
    );
  }
}
