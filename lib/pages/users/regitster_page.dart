import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_coding_thailand/routes/routes.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  bool _obscureText = true;

  _register(Map<String, dynamic> value) async {
    var url = Uri.parse('https://api.codingthailand.com/api/register');
    var response = await post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': value['name'],
          'email': value['email'],
          'password': value['password'],
          'dob': value['dob'].toString().substring(0, 10),
        }));

    if (response.statusCode == 201) {
      Flushbar(
          message: 'Loading...',
          showProgressIndicator: true,
          flushbarPosition: FlushbarPosition.TOP,
          flushbarStyle: FlushbarStyle.GROUNDED,
          duration: Duration(seconds: 2))
        ..show(context);

      Future.delayed(Duration(seconds: 4), () {
        Navigator.pop(context);
      });
    } else {
      var messgage = jsonDecode(response.body);

      Flushbar(
        title: 'เกิดข้อผิดพลาด',
        message: '${messgage['message']}',
        icon: Icon(
          Icons.error_outline,
          color: Colors.red[300],
          size: 28,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.green,
      )..show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('register')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              _buildFormBuilder(context),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  FormBuilder _buildFormBuilder(BuildContext context) => FormBuilder(
        key: _formKey,
        initialValue: {
          'name': '',
          'email': '',
          'password': '',
          'dob': DateTime.now()
        },
        autovalidateMode: _autovalidateMode,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _nameFormBuilderTextField(context),
            SizedBox(height: 10),
            _emailFormBuilderTextField(context),
            SizedBox(height: 10),
            _passwordFormBuilderTextField(context),
            SizedBox(height: 10),
            _dateFormBuilderDateTimePicker(),
            SizedBox(height: 10),
            _registerButton(),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('มีบัญชีแล้ว ?'),
                  MaterialButton(
                    highlightColor: Colors.blue,
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.login);
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  SizedBox _registerButton() {
    return SizedBox(
      width: 200,
      child: MaterialButton(
        color: Colors.blue,
        padding: const EdgeInsets.all(20),
        highlightColor: Colors.amber,
        onPressed: () {
          if (_formKey.currentState.saveAndValidate()) {
            // print(_formKey.currentState.value);
            _register(_formKey.currentState.value);
          } else {
            setState(() {
              _autovalidateMode = AutovalidateMode.always;
            });
          }
        },
        child: Text(
          'Register',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  FormBuilderDateTimePicker _dateFormBuilderDateTimePicker() {
    return FormBuilderDateTimePicker(
      name: 'dob',
      inputType: InputType.date,
      format: DateFormat('yyyy-MM-dd'),
      decoration: InputDecoration(
        icon: FaIcon(FontAwesomeIcons.calendar),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        labelText: 'วัน/เดือน/ปี เกิด',
      ),
    );
  }

  FormBuilderTextField _passwordFormBuilderTextField(BuildContext context) {
    return FormBuilderTextField(
      textInputAction: TextInputAction.next,
      obscureText: _obscureText,
      maxLines: 1,
      name: 'password',
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: FaIcon(
              _obscureText ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash),
          onPressed: () => setState(() {
            _obscureText = !_obscureText;
          }),
        ),
        icon: FaIcon(FontAwesomeIcons.lock),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        labelText: 'Password',
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(context, errorText: 'ป้อนข้อมูล'),
        FormBuilderValidators.minLength(context, 3),
      ]),
      keyboardType: TextInputType.text,
    );
  }

  FormBuilderTextField _emailFormBuilderTextField(BuildContext context) {
    return FormBuilderTextField(
      textInputAction: TextInputAction.next,
      maxLines: 1,
      name: 'email',
      decoration: InputDecoration(
        icon: FaIcon(FontAwesomeIcons.envelope),
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        labelText: 'Email',
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(context, errorText: 'ป้อนข้อมูล'),
        FormBuilderValidators.email(context,
            errorText: 'รูปแบบอีเมล์ไม่ถูกต้อง'),
        FormBuilderValidators.max(context, 70),
      ]),
      keyboardType: TextInputType.emailAddress,
    );
  }

  FormBuilderTextField _nameFormBuilderTextField(BuildContext context) {
    return FormBuilderTextField(
      textInputAction: TextInputAction.next,
      maxLines: 1,
      name: 'name',
      decoration: InputDecoration(
        icon: FaIcon(FontAwesomeIcons.user),
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        labelText: 'Name',
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(context, errorText: 'ป้อนข้อมูล'),
        FormBuilderValidators.max(context, 70),
      ]),
      keyboardType: TextInputType.text,
    );
  }
}
