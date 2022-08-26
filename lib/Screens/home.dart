import 'package:flutter/material.dart';

import 'Widgets/GetStarted.dart';

class SplachScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  'assets/images/bg.jpg'),
              fit: BoxFit.cover
          ),
        ),
        child: const Align(
          alignment: Alignment(0.4, 0.8),
          child: GetStarted(),
        ),
      ),
    );
  }
}