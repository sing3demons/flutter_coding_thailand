import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/routes/routes.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map msg = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('เกี่ยวกับเรา'),
        automaticallyImplyLeading: true ,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('About Page'),
            Text('email: ${msg['email']}'),
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'KPSING');
              },
              child: Text('go to home'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.contact);
              },
              child: Text('contact'),
            ),
          ],
        ),
      ),
    );
  }
}