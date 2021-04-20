import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/view_models/menu_view_model.dart';
import 'package:flutter_coding_thailand/widgets/menu.dart' as mainMenu;


class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter'),
      ),
      drawer: mainMenu.Menu(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/bg.jpg'),
          ),
        ),
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[
            ..._buildMainMenu(),
          ],
        ),
      ),
    );
  }

  List<InkWell> _buildMainMenu() => MenuViewModel()
      .items
      .map(
        (item) => InkWell(
          onTap: () => item.onTap(context),
          child: GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Icon(
                    item.icon,
                    size: item.size,
                    color: item.iconColor,
                  ),
                  Text(
                    item.title,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              color: item.color,
            ),
          ),
        ),
      )
      .toList();
}
