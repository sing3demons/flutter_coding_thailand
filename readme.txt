import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/routes/routes.dart';
import 'package:flutter_coding_thailand/view_models/menu_view_model.dart';
import 'package:flutter_coding_thailand/widgets/menu.dart' as mainMenu;

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var result;
  double _sizeIcon = 80.0;
  Color _colorIcon = Colors.cyan;
  Color _color = Colors.white70;
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
           
         Container(
           padding: const EdgeInsets.all(8),
           child: Column(
             children: [
               Icon(
                 Icons.business,
                 size: _sizeIcon,
                 color: _colorIcon,
               ),
               Text(
                 'company',
                 style: TextStyle(fontSize: 20),
               ),
             ],
           ),
           color: _color,
         ),
         Container(
           padding: const EdgeInsets.all(8),
           child: Column(
             children: [
               Icon(
                 Icons.map,
                 size: _sizeIcon,
                 color: _colorIcon,
               ),
               Text(
                 'Map',
                 style: TextStyle(fontSize: 20),
               ),
             ],
           ),
           color: _color,
         ),
         Container(
           padding: const EdgeInsets.all(8),
           child: Column(
             children: [
               Icon(
                 Icons.camera,
                 size: _sizeIcon,
                 color: _colorIcon,
               ),
               Text(
                 'Camera',
                 style: TextStyle(fontSize: 20),
               ),
             ],
           ),
           color: _color,
         ),
         GestureDetector(
         onTap: () async {
           result = await Navigator.pushNamed(context, Routes.about,
               arguments: {
                 'email': 'sing3demons@livew.com',
               });
           setState(() {});
           ScaffoldMessenger.of(context)
             ..removeCurrentSnackBar()
             ..showSnackBar(SnackBar(content: Text('$result')));
         },
         child: Container(
           padding: const EdgeInsets.all(8),
           child: Column(
             children: [
               Icon(
                 Icons.person,
                 size: _sizeIcon,
                 color: _colorIcon,
               ),
               Text(
                 'About',
                 style: TextStyle(fontSize: 20),
               ),
               Text(
                 '${result ?? ''}',
               ),
             ],
           ),
           color: _color,
         ),
         ),
          ],
        ),
      ),
    );
  }

  _buildHomePagev1() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home Page'),
            Text("${result ?? ''}"),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Text('go to About'),
              onPressed: () async {
                result = await Navigator.pushNamed(context, Routes.about,
                    arguments: {
                      'email': 'sing3demons@livew.com',
                    });
                setState(() {});
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text('$result')));
              },
            ),
             TextButton(
               child: Text('go to contact page'),
               onPressed: () => {Navigator.pushNamed(context, "/contact")},
             ),
             TextButton(
               child: Text('go to Covid page'),
               onPressed: () => {Navigator.pushNamed(context, "/covid")},
             ),
          ],
        ),
      );


}
