import 'package:brew_crew/shared/colors.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:brew_crew/shared/re_use.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final VoidCallback toggleViewProperty;
  Register({required this.toggleViewProperty});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String error = '';

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: lightBrown,
            appBar: AppBar(
              backgroundColor: darkBrown,
              elevation: 0,
              title: Text('Register for Brew Crew'),
              actions: [
                TextButton.icon(
                  onPressed: widget.toggleViewProperty,
                  label: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.brown[100]),
                  ),
                  icon: Icon(
                    Icons.person,
                    color: Colors.brown[100],
                  ),
                ),
              ],
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 48.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20.0),

                    // email text field
                    TextFormField(
                      controller: _email,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter an email' : null,
                      decoration:
                          textInputDecoration.copyWith(labelText: 'Email'),
                    ),

                    SizedBox(height: 20.0),

                    // password text field
                    TextFormField(
                      controller: _password,
                      validator: (value) => value!.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      obscureText: true,
                      decoration:
                          textInputDecoration.copyWith(labelText: 'Password'),
                    ),

                    SizedBox(height: 20.0),

                    // register button
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        if (_formKey.currentState!.validate()) {
                          dynamic result =
                              await _authService.registerWithEmailAndPassword(
                                  _email.text.trim(), _password.text.trim());
                          print(result);
                          if (result == null) {
                            print("galat hai");
                            setState(() {
                              error = 'Please enter a valid email';
                              loading = false;
                            });
                          }
                        }
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    SizedBox(height: 20.0),

                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
