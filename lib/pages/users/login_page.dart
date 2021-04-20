import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/pages/users/widgets/login_form.dart';
import 'package:flutter_coding_thailand/widgets/menu.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      drawer: Menu(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: LoginForm(),
          ),
        ],
      ),
    );
  }
}
