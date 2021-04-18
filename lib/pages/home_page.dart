import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/routes/routes.dart';
import 'package:flutter_coding_thailand/widgets/menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter'),
      ),
      drawer: Menu(),
      body: Center(
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
            // TextButton(
            //   child: Text('go to contact page'),
            //   onPressed: () => {Navigator.pushNamed(context, "/contact")},
            // ),
            // TextButton(
            //   child: Text('go to Covid page'),
            //   onPressed: () => {Navigator.pushNamed(context, "/covid")},
            // ),
          ],
        ),
      ),
    );
  }
}
