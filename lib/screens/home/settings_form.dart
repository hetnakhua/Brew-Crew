import 'package:brew_crew/models/my_user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/re_use.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _curName = '';
  String _curSugars = '';
  int _curStrength = 100;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<myUser>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.requireData;
          _curName = userData.name;
          _curSugars = userData.sugars;
          _curStrength = userData.strength;
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Update your brew settings.',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),

                // name
                TextFormField(
                  initialValue: userData.name,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a name' : null,
                  decoration: textInputDecoration.copyWith(labelText: 'Name'),
                  onChanged: (val) {
                    setState(() {
                      _curName = val;
                    });
                  },
                ),
                SizedBox(height: 20),

                // dropdown
                DropdownButtonFormField(
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                        value: sugar,
                        child: Text(
                          '$sugar sugars',
                        ));
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _curSugars = val ?? '';
                    });
                  },
                ),

                SizedBox(height: 40),

                // slider
                Slider(
                  value: (_curStrength).toDouble(),
                  min: 100.0,
                  max: 900.0,
                  activeColor: Colors.brown[_curStrength],
                  inactiveColor: Colors.brown[_curStrength],
                  divisions: 8,
                  onChanged: (val) {
                    setState(() {
                      _curStrength = val.round();
                    });
                  },
                ),

                // submit button
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await DatabaseService(uid: user.uid)
                          .updateUserData(_curName, _curSugars, _curStrength);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
