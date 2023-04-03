import 'package:brew_crew/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightBrown,
      child: Center(
        child: SpinKitChasingDots(
          color: darkBrown,
          size: 50,
        ),
      ),
    );
  }
}
