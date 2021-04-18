import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/routes/routes.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ติดต่อเรา'),
        // automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Contact Page'),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.home, (route) => false);
              },
              child: Text('go to home'),
            ),
          ],
        ),
      ),
    );
  }
}
