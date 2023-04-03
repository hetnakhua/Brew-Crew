import 'package:brew_crew/models/my_user.dart';
import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<myUser?>(context);
    print(user);

    // return Home or Authenticate widget after listening the authentication status
    return (user == null) ? Authenticate() : Home();
  }
}
