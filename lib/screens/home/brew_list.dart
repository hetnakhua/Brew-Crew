import 'package:brew_crew/models/brew.dart';
import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({super.key});

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);
    // if (brews != null) {
    //   for (var brew in brews) {
    //     print(brew.name);
    //     print(brew.sugars);
    //     print(brew.strength);
    //   }
    // }

    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
          child: Card(
            margin: EdgeInsets.fromLTRB(16, 4, 16, 0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.brown[brews[index].strength],
                backgroundImage: AssetImage("assets/coffee_icon.png"),
              ),
              title: Text(brews[index].name),
              subtitle: Text('Takes ${brews[index].sugars} spoon(s) sugar'),
            ),
          ),
        );
      },
    );
  }
}
