import 'package:brew_crew/shared/colors.dart';
import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  // fillColor: lightBrown,
  // filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide:
        BorderSide(color: Color.fromARGB(255, 201, 198, 198), width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: darkBrown, width: 2.0),
  ),
);
