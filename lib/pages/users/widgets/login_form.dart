import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/routes/routes.dart';
import 'package:email_validator/email_validator.dart';
import 'package:another_flushbar/flushbar.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController;
  TextEditingController passwordController;
  String _errorEmail;
  bool emailIsValid = false;

  FocusNode myFocusNode;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    emailController?.dispose();
    passwordController?.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _buildColumnNews(),
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
          child: Column(
            children: [
              TextField(
                autofocus: true,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  errorText: _errorEmail,
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                focusNode: myFocusNode,
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Password'),
              ),
            ],
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
              emailIsValid = EmailValidator.validate(email);

              _errorEmail = null;

              if (!email.isNotEmpty && !password.isNotEmpty && !emailIsValid) {
                _errorEmail = 'The Email must be a valid email.';
              }

              if (_errorEmail == null) {
                setState(() {});
                if (email == 'sing@dev.com' && password == '1234') {
                  print('pass');
                } else {
                  Flushbar(
                    title: "email or password is incorrect",
                    message: "Please try again",
                    icon: Icon(
                      Icons.error,
                      size: 28,
                      color: Colors.red,
                    ),
                    duration: Duration(seconds: 4),
                  )..show(context);
                }
              } else {
                print(_errorEmail);
                setState(() {});
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
                onPressed: () {
                  Navigator.pushNamed(context, Routes.regitster);
                },
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
