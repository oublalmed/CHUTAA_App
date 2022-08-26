import 'package:chuta_app/Screens/LoginPage.dart';
import 'package:flutter/material.dart';
import '../../constant.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
            side: BorderSide(color: mFacebookColor)),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              )
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 12,
              ),
              Text(
                'Get Started with us',
                style: TextStyle(color: mFacebookColor),
              ),
            ],
          ),
        ),
      ),

    );
  }
}