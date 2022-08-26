import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  final icon = CupertinoIcons.moon_stars;

  return AppBar(
    leading: BackButton(),
    backgroundColor: Color(0xFF90CAF9),
    elevation: 0,
    actions: [
      IconButton(
        icon: Icon(icon),
        color: Colors.white,
        onPressed: () {
        },
      ),
    ],
  );
}