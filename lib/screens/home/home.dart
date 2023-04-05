import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/colors.dart';
import 'package:brew_crew/services/auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  void _showSettingsPanel(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            child: SettingsForm(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      initialData: [],
      catchError: (_, __) => [],
      child: Scaffold(
        backgroundColor: lightBrown,
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: darkBrown,
          elevation: 0.0,
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                _showSettingsPanel(context);
              },
            ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
