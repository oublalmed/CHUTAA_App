import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:chuta_app/Model/Patient.dart';
import 'package:chuta_app/Model/User.dart';
import 'package:chuta_app/Screens/Camera.dart';
import 'package:chuta_app/Screens/LoginPage.dart';
import 'package:chuta_app/Screens/Widgets/AddPatientWidget.dart';
import 'package:chuta_app/Screens/profilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Camera.dart' as camera;

import 'ListPatients.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPatient extends StatefulWidget {
  @override
  _BottomNavBarV2State createState() => _BottomNavBarV2State();
}

class _BottomNavBarV2State extends State<AddPatient> {
  final Patient patient = Patient();
  int currentIndex = 0;
  signOut() async{
    print("logout");
    await FirebaseAuth.instance.signOut();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        )
    );
  }
  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: Colors.transparent,
      body: Stack(

        children: [
          AddPatientWidget(),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: size.width,
              height: 80,
              child: Stack(
                clipBehavior: Clip.none, children: [
                CustomPaint(
                  size: Size(size.width, 80),
                  painter: BNBCustomPainter(),
                ),
                Center(
                  heightFactor: 0.6,
                  child: FloatingActionButton(backgroundColor: Color(0xFF90CAF9), child: Icon(Icons.camera), elevation: 0.1, onPressed: ()  {

                  }),
                ),
                Container(
                  width: size.width,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.home,
                          color: currentIndex == 1 ? Color(0xFF90CAF9) : Colors.black,
                        ),
                        onPressed: () {
                          setBottomBarIndex(1);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(),
                              )
                          );
                        },
                        splashColor: Colors.white,
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.person_add_alt_1_sharp,
                            color: currentIndex == 0 ? Color(0xFF90CAF9) : Colors.black,
                          ),
                          onPressed: () {
                            setBottomBarIndex(0);

                          }),
                      Container(
                        width: size.width * 0.20,
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.list,
                            color: currentIndex == 2 ? Color(0xFF90CAF9) : Colors.black,
                          ),
                          onPressed: () {
                            setBottomBarIndex(2);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ListPatient(),
                                )
                            );
                          }),
                      IconButton(
                          icon: Icon(
                            Icons.login_outlined,
                            color: currentIndex == 3 ? Color(0xFF90CAF9) : Colors.black,
                          ),
                          onPressed: () {
                            setBottomBarIndex(3);
                            signOut();
                          }),
                    ],
                  ),
                )
              ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20), radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}
