import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/routes/routes.dart';
import 'package:email_validator/email_validator.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:http/http.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController;
  TextEditingController passwordController;
  String _errorEmail;
  bool emailIsValid = false;
  Map<String, dynamic> _formKey = {};
  SharedPreferences prefs;

  _initPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  _login(Map<String, dynamic> value) async {
    Uri url = Uri.parse('https://api.codingthailand.com/api/login');
    var response = await post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(value),
    );

    Future<void> _getProfile() async {
      var tokenString = await prefs.getString('token');
      var token = jsonDecode(tokenString);

      var response = await get(
          Uri.parse('https://api.codingthailand.com/api/profile'),
          headers: {'Authorization': "Bearer ${token['access_token']}"});

      var data = jsonDecode(response.body);
      var profile = data['data']['user'];

      prefs.setString('profile', jsonEncode(profile));
    }

    if (response.statusCode == 200) {
      await prefs.setString('token', response.body);

      _getProfile();

      await Flushbar(
          title: 'เข้าสู่ระบบสำเร็จ',
          message: 'Loading...',
          showProgressIndicator: true,
          flushbarPosition: FlushbarPosition.TOP,
          flushbarStyle: FlushbarStyle.GROUNDED,
          duration: Duration(seconds: 2))
        ..show(context);

      Future.delayed(Duration(seconds: 3), () async {
        await Navigator.of(context, rootNavigator: true)
            .pushNamedAndRemoveUntil('/', (route) => false);
      });
    } else {
      var feedback = jsonDecode(response.body);
      Flushbar(
        title: '${feedback['message']}',
        message: 'เกิดข้อผิดพลาด',
        icon: Icon(
          Icons.error,
          color: Colors.red[300],
          size: 28,
        ),
        duration: Duration(seconds: 1),
        leftBarIndicatorColor: Colors.green,
      )..show(context);
      //
    }
  }

  FocusNode myFocusNode;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _initPref();
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

              if (!email.isNotEmpty || !password.isNotEmpty || !emailIsValid) {
                _errorEmail = 'The Email must be a valid email.';
              }

              if (_errorEmail == null) {
                _formKey = {
                  'email': email,
                  'password': password,
                };
                _login(_formKey);
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
