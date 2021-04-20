import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController;
  TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          print('ok');
        },
        child: _buildColumnNews(),
      ),
    );
  }

  Column _buildColumnNews() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          'Sign In',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Email'),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Password'),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text('Forgot Password'),
          style: TextButton.styleFrom(primary: Colors.blue),
        ),
        Container(
          height: 50,
          width: double.maxFinite,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: TextButton(
            onPressed: () {
              String email = emailController.text;
              String password = passwordController.text;

              if (email.isNotEmpty && password.isNotEmpty) {
                print('Email: $email');
                print('Password: $password');
              }
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
            child: Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('ไม่มีบัญชี ?'),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
