import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _formKey = GlobalKey<FormState>();
  String _phone, _password, _email;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _obscure = true, _isUser = true, _isSubmitting = false;

  Widget _showMobileNumberInput() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        validator: (val) => val.length != 10 ? 'Phone number invalid' : null,
        onSaved: (val) => _phone = val,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Phone',
            icon: Icon(Icons.phone),
            hintText: 'Enter valid Phone number'),
      ),
    );
  }

  Widget _showEmailInput() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        validator: (val) => !val.contains('@') ? 'Invalid email' : null,
        onSaved: (val) => _email = val,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Email',
            icon: Icon(Icons.email),
            hintText: 'Enter valid email'),
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        validator: (val) => val.length < 6 ? 'Password too short' : null,
        obscureText: _obscure,
        onSaved: (val) => _password = val,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Password',
            icon: Icon(Icons.lock),
            suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscure = !_obscure;
                  });
                },
                child: _obscure
                    ? Icon(Icons.visibility)
                    : Icon(Icons.visibility_off)),
            hintText: 'Enter Password, min 6 char'),
      ),
    );
  }

  Widget _toggleUserLoginForm() {
    return RaisedButton(
      onPressed: () {
        setState(() {
          _isUser = true;
        });
      },
      child: Text('User'),
      color: _isUser ? Colors.grey : Theme.of(context).primaryColor,
    );
  }

  Widget _toggleVendorLoginForm() {
    return RaisedButton(
      onPressed: () {
        setState(() {
          _isUser = false;
        });
      },
      child: Text('Vendor'),
      color: !_isUser ? Colors.grey : Theme.of(context).primaryColor,
    );
  }

  Widget _showSubmitButton() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          _isSubmitting == true
              ? CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).accentColor))
              : RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      _registerUser();
                    } else {
                      print('Invalid');
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.black),
                  ),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  color: Theme.of(context).primaryColor,
                ),
          FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            },
            child: Text('New User? Register'),
          )
        ],
      ),
    );
  }

  void _registerUser() async {
    setState(() {
      _isSubmitting = true;
    });
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final msg = jsonEncode({
      "mobileNumber": _phone,
      "password": _password,
    });
    if (_isUser == true) {
      var response = await http.post(
          Uri.parse('http://192.168.0.103:7000/users/signin'),
          headers: headers,
          body: msg);
      final responseData = response.body;
      if (response.statusCode == 200) {
        setState(() {
          _isSubmitting = false;
        });
        _showSuccessSnack();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('mobileNumber', _phone);
        _redirectUser();
        //print(responseData);
      } else {
        setState(() => _isSubmitting = false);
        final String errorMsg = 'Error Loging In!Retype your Credentials!';
        _showErrorSnack(errorMsg);
      }
    } else {
      var response = await http.post(
          Uri.parse('http://192.168.0.103:7000/vendors/signin'),
          headers: headers,
          body: msg);
      final responseData = response.body;
      if (response.statusCode == 200) {
        setState(() {
          _isSubmitting = false;
        });
        _showSuccessSnack();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('mobileNumber', _phone);
        _redirectUser();
        //print(responseData);
      } else {
        setState(() => _isSubmitting = false);
        final String errorMsg = 'Error Loging In!Retype your Credentials!';
        _showErrorSnack(errorMsg);
      }
    }
  }

  void _showErrorSnack(String errorMsg) {
    final snackBar =
        SnackBar(content: Text(errorMsg, style: TextStyle(color: Colors.red)));
    _scaffoldKey.currentState.showSnackBar(snackBar);
    throw Exception('Error Logging In');
  }

  void _redirectUser() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  void _showSuccessSnack() {
    final snackBar = SnackBar(
        content: Text('User succesfully logged In!',
            style: TextStyle(color: Colors.green)));
    _scaffoldKey.currentState.showSnackBar(snackBar);
    _formKey.currentState.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Shopperz'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _toggleUserLoginForm(),
                        VerticalDivider(
                          color: Colors.white,
                          width: 20,
                        ),
                        _toggleVendorLoginForm(),
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    _showMobileNumberInput(),
                    _showPasswordInput(),
                    _showSubmitButton()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
