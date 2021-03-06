import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/pages/product/detail_page_v2.dart';
import 'package:flutter_coding_thailand/pages/product/product_page_v2.dart';
import 'package:flutter_coding_thailand/routes/routes.dart';

class ProductStack extends StatefulWidget {
  @override
  _ProductStackState createState() => _ProductStackState();
}

class _ProductStackState extends State<ProductStack> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: Routes.products,
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case Routes.products:
            builder = (BuildContext _) => ProductPageV2();
            break;
          case Routes.detail:
            builder = (BuildContext _) => DetailPageV2();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
