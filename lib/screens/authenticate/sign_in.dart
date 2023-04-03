import 'package:brew_crew/shared/colors.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:brew_crew/shared/re_use.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final VoidCallback toggleViewProperty;
  SignIn({required this.toggleViewProperty});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String error = '';

  bool loading = false;

  // String email = '';
  // String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: lightBrown,
            appBar: AppBar(
              backgroundColor: darkBrown,
              elevation: 0,
              title: Text('Sign In to Brew Crew'),
              actions: [
                TextButton.icon(
                  onPressed: widget.toggleViewProperty,
                  label: Text(
                    'Register',
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
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 48),
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
                      // onChanged: (val) {
                      //   setState(() {
                      //     email = val;
                      //   });
                      // },
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
                      // onChanged: (val) {
                      //   setState(() {
                      //     password = val;
                      //   });
                      // },
                    ),

                    SizedBox(height: 20.0),

                    // sign in button
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result =
                              await _authService.signInWithEmailAndPassword(
                                  _email.text.trim(), _password.text.trim());
                          if (result == null) {
                            print("galat hai");
                            setState(() {
                              error =
                                  'could not sign in with the provided credentials';
                              loading = false;
                            });
                          }
                        }
                      },
                      child: Text(
                        'Sign In',
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

            // Container(
            //   padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            //   child: ElevatedButton(
            //     onPressed: () async {
            //       dynamic result = await _authService.signInAnon();
            //       if (result == null) {
            //         print('error signing in');
            //       } else {
            //         print(result.uid);
            //       }
            //     },
            //     child: Text('Sign in anon'),
            //   ),
            // ),
          );
  }
}
