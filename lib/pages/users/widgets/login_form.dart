import 'dart:convert';
import 'dart:io';
import 'package:flutter_coding_thailand/redux/acions/action.dart';
import 'package:flutter_coding_thailand/redux/reducer/app_reducer.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  bool _obscureText;

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
      String tokenString = prefs.getString('token');
      Map<String, dynamic> token = jsonDecode(tokenString);
      FocusNode _passwordFocusNode;

      var response = await get(
          Uri.parse('https://api.codingthailand.com/api/profile'),
          headers: {'Authorization': "Bearer ${token['access_token']}"});

      var data = jsonDecode(response.body);
      var profile = data['data']['user'];

      prefs.setString('profile', jsonEncode(profile));

      final store = StoreProvider.of<AppState>(context);
      store.dispatch(getProfileAction(profile));
    }

    Flushbar _loading() => Flushbar(
        title: 'เข้าสู่ระบบสำเร็จ',
        message: 'Loading...',
        showProgressIndicator: true,
        flushbarPosition: FlushbarPosition.TOP,
        flushbarStyle: FlushbarStyle.GROUNDED,
        duration: Duration(seconds: 2))
      ..show(context);

    if (response.statusCode == HttpStatus.ok) {
      await prefs.setString('token', response.body);

      _getProfile();

      _loading();

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
    _obscureText = true;
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
              _emailTextField(),
              SizedBox(height: 10),
              _passwordTextField(),
            ],
          ),
        ),
        _forgotPasswordButton(),
        _loginButton(),
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

  TextButton _forgotPasswordButton() {
    return TextButton(
        onPressed: () {},
        child: Text('Forgot Password'),
        style: TextButton.styleFrom(primary: Colors.blue),
      );
  }

  Container _loginButton() {
    return Container(
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
      );
  }

  TextField _passwordTextField() => TextField(
        focusNode: myFocusNode,
        controller: passwordController,
        obscureText: _obscureText,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: FaIcon(_obscureText
                ? FontAwesomeIcons.eye
                : FontAwesomeIcons.eyeSlash),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          border: OutlineInputBorder(),
          labelText: 'Password',
          icon: FaIcon(FontAwesomeIcons.lock),
        ),
      );

  TextField _emailTextField() => TextField(
        textInputAction: TextInputAction.next,
        onSubmitted: (value) =>
            FocusScope.of(context).requestFocus(myFocusNode),
        autofocus: true,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: FaIcon(FontAwesomeIcons.envelope),
          errorText: _errorEmail,
          border: OutlineInputBorder(),
          labelText: 'Email',
        ),
      );
}
