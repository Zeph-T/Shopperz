import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

class Registerscreen extends StatefulWidget {
  @override
  _RegisterscreenState createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  var _formKey = GlobalKey<FormState>();
  String _phone, _email, _password, _name;
  bool _obscure = true, _isUser = true;

  Widget _showUsernameInput() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        onSaved: (val) => _name = val,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Name',
            icon: Icon(Icons.phone),
            hintText: 'Enter your name'),
      ),
    );
  }

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

  Widget _toggleUserForm() {
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

  Widget _toggleVendorForm() {
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
          RaisedButton(
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: Theme.of(context).primaryColor,
          ),
          FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Text('Existing User? Login'),
          )
        ],
      ),
    );
  }

  void _registerUser() async {
    var response = await http.post(
        Uri.parse('http://192.168.0.103:1337/auth/local/register'),
        body: {
          "username": _name,
          "email": _email,
          "password": _password,
          "mobileNumber": _phone
        });
    final responseData = json.decode(response.body);
    print(responseData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        _toggleUserForm(),
                        VerticalDivider(
                          color: Colors.white,
                          width: 20,
                        ),
                        _toggleVendorForm(),
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    _showUsernameInput(),
                    _showMobileNumberInput(),
                    _showEmailInput(),
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
