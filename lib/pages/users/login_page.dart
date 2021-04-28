import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/pages/users/widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Login'),
      ),
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
