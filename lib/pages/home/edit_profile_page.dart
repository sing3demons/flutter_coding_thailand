import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_coding_thailand/redux/acions/action.dart';
import 'package:flutter_coding_thailand/redux/reducer/app_reducer.dart';
import 'package:flutter_coding_thailand/routes/routes.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormBuilderState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  SharedPreferences prefs;

  _initPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> _saveProfile(String body) async {
    var data = jsonDecode(body);
    var profile = data['data']['user'];

    await prefs.setString('profile', jsonEncode(profile));
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(getProfileAction(profile));
  }

  _updateProfile(Map<String, dynamic> value) async {
    String tokenString = prefs.getString('token');
    Map<String, dynamic> token = jsonDecode(tokenString);
    var url = Uri.parse('https://api.codingthailand.com/api/editprofile');
    var response = await post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${token['access_token']}"
        },
        body: jsonEncode({
          'name': value['name'],
        }));

    if (response.statusCode == HttpStatus.ok) {
      var profile = response.body;
      await _saveProfile(profile);

      Navigator.of(context, rootNavigator: false)
          .pushNamedAndRemoveUntil(Routes.home, (route) => false);
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
    }
  }

  @override
  void initState() {
    super.initState();
    _initPref();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              _buildFormBuilder(context, data),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  FormBuilder _buildFormBuilder(BuildContext context, Map data) => FormBuilder(
        key: _formKey,
        initialValue: {
          'name': data['name'],
        },
        autovalidateMode: _autovalidateMode,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _nameFormBuilderTextField(context),
            SizedBox(height: 10),
            _registerButton(),
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
            _updateProfile(_formKey.currentState.value);
          } else {
            setState(() {
              _autovalidateMode = AutovalidateMode.always;
            });
          }
        },
        child: Text(
          'Update',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  FormBuilderTextField _nameFormBuilderTextField(BuildContext context) {
    return FormBuilderTextField(
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
