import 'package:flutter/material.dart';

class Registerscreen extends StatefulWidget {
  @override
  _RegisterscreenState createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  var _formKey = GlobalKey<FormState>();
  String _phone, _email, _password, _name;
  bool _obscure = true, _isUser = true;
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
                        RaisedButton(
                          onPressed: () {
                            setState(() {
                              _isUser = true;
                            });
                          },
                          child: Text('User'),
                          color: _isUser
                              ? Colors.grey
                              : Theme.of(context).primaryColor,
                        ),
                        VerticalDivider(
                          color: Colors.white,
                          width: 20,
                        ),
                        RaisedButton(
                          onPressed: () {
                            setState(() {
                              _isUser = false;
                            });
                          },
                          child: Text('Vendor'),
                          color: !_isUser
                              ? Colors.grey
                              : Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextFormField(
                        onSaved: (val) => _name = val,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name',
                            icon: Icon(Icons.phone),
                            hintText: 'Enteryour name'),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextFormField(
                        validator: (val) =>
                            val.length != 10 ? 'Phone number invalid' : null,
                        onSaved: (val) => _phone = val,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Phone',
                            icon: Icon(Icons.phone),
                            hintText: 'Enter valid Phone number'),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextFormField(
                        validator: (val) =>
                            !val.contains('@') ? 'Invalid email' : null,
                        onSaved: (val) => _email = val,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            icon: Icon(Icons.email),
                            hintText: 'Enter valid email'),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextFormField(
                        validator: (val) =>
                            val.length < 6 ? 'Password too short' : null,
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
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                print('valid');
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
                              Navigator.pushNamed(context, '/login');
                            },
                            child: Text('Existing User? Login'),
                          )
                        ],
                      ),
                    )
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
