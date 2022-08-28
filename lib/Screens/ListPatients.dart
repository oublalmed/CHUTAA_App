import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:chuta_app/Model/Patient.dart';
import 'package:chuta_app/Model/User.dart';
import 'package:chuta_app/Screens/AddPatient.dart';
import 'package:chuta_app/Screens/LoginPage.dart';
import 'package:chuta_app/Screens/ProfilePatient.dart';
import 'package:chuta_app/Screens/Widgets/AddPatientWidget.dart';
import 'package:chuta_app/Screens/Widgets/ListWidget.dart';
import 'package:chuta_app/Screens/Widgets/appbar_widget.dart';
import 'package:chuta_app/Screens/profilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Camera.dart' as camera;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class ListPatient extends StatefulWidget {
  @override
  _BottomNavBarV2State createState() => _BottomNavBarV2State();
}

class _BottomNavBarV2State extends State<ListPatient> {
  List <Patient> Patients=[];
  int currentIndex = 0;

  Future<void> getAllFeedPatients() async
  {
    final uid = FirebaseAuth.instance.currentUser?.uid;//use a Async-await function to get the data
    QuerySnapshot patients = await FirebaseFirestore.instance.collection("users")
        .doc(uid).collection("patients").get();
    for (var patientDoc in patients.docs ) {
      //PostSrc post = PostSrc.fromDoc(postDoc);
      // allPosts.add(patientDoc.get("number"));

      Patient patient = Patient(
          patientId: patientDoc.get("patientId"),
          name: patientDoc.get("name"),
          email: patientDoc.get("email"),
          number: patientDoc.get("number"),
          birthday: patientDoc.get("birthday"),
          consultation: patientDoc.get("consultation"),
          numFile: patientDoc.get("numFile"),
          state: patientDoc.get("state"));

      setState(() {
        print(patient.toString());
        Patients.add(patient);
      });

    }}

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

  @override
  void initState() {
    getAllFeedPatients();
    super.initState();
  }
  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget ListPatients() {
    // getAllFeedPatients();
    // print(allPosts);
    return Scaffold(
      backgroundColor: Color(0xfff6f7f9),

      appBar: buildAppBar(context),
      body: ListView(
        padding: const EdgeInsets.only(top: 30.0),
        children: <Widget>[
          Column(
              children: Patients
                  .map(
                    (e) => Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10,
                          spreadRadius: 3,
                          offset: Offset(3, 4))
                    ],
                  ),

                  child: ListTile(
                    title: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        e.name.toString(),
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("" + e.consultation.toString()),
                        SizedBox(height: 20),
                        Container(
                          alignment:Alignment.centerRight,
                          padding:EdgeInsets.symmetric(horizontal:10.0,vertical:10.0),
                          child:Align(
                            alignment: Alignment.centerRight,
                            child: FlatButton(
                              onPressed: () {
                                setBottomBarIndex(2);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProfilePatient(e),
                                    )
                                );
                              },
                              color:Colors.red[200],
                              shape:RoundedRectangleBorder(
                                  borderRadius:BorderRadius.circular(20.0)
                              ),

                              child: Text("Consulter",style:TextStyle(color:Colors.white),
                              ),
                            ),
                          ),
                          // FlatButton
                        ),// Container
                      ],
                    ),
                  ),
                ),
              )
                  .toList()
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //getAllFeedPatients();
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          ListPatients(),
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
                  child: FloatingActionButton(backgroundColor: Color(0xFF90CAF9), child: Icon(Icons.camera), elevation: 0.1, onPressed: () async {
                    await availableCameras().then(
                          (value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => camera.CameraPage(cameras: value, patient: Patients[0],),
                        ),
                      ),
                    );
                  },),
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
                          color: currentIndex == 2 ? Color(0xFF90CAF9) : Colors.black,
                        ),
                        onPressed: () {
                          setBottomBarIndex(2);
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
                            color: currentIndex == 1 ? Color(0xFF90CAF9) : Colors.black,
                          ),
                          onPressed: () {
                            setBottomBarIndex(0);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddPatient(),
                                )
                            );
                          }),
                      Container(
                        width: size.width * 0.20,
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.list,
                            color: currentIndex == 0 ? Color(0xFF90CAF9) : Colors.black,
                          ),
                          onPressed: () {
                            setBottomBarIndex(0);
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