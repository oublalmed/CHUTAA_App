import 'dart:convert';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:chuta_app/Model/Patient.dart';
import 'package:chuta_app/Model/User.dart' as us;
import 'package:chuta_app/Screens/AddPatient.dart';
import 'package:chuta_app/Screens/Camera.dart';
import 'package:chuta_app/Screens/LoginPage.dart';
import 'package:chuta_app/Screens/Widgets/Bottum_NavBar.dart';
import 'package:chuta_app/Screens/Widgets/chart2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pie_chart/pie_chart.dart';
import 'Camera.dart' as camera;

import 'ListPatients.dart';
import 'Widgets/Charts.dart';
import 'Widgets/appbar_widget.dart';
import 'Widgets/numbers_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  @override
  _BottomNavBarV2State createState() => _BottomNavBarV2State();

}
class _BottomNavBarV2State extends State<ProfilePage> {
  final Patient patient = Patient();
  int currentIndex = 0;
  var currentUser = us.User();
  QuerySnapshot? userProfileSnapshot;
  QuerySnapshot? querypatients;
  int querypatientslen = 0;
  QuerySnapshot? query2020;
  QuerySnapshot? query2021;
  QuerySnapshot? query2022;
  int query2020len = 0;
  int query2021len = 0;
  int query2022len = 0;

  QuerySnapshot? querystage1;
  QuerySnapshot? querystage2;
  QuerySnapshot? querystage3;
  QuerySnapshot? querystage4;
  int querystage1len = 0;
  int querystage2len = 0;
  int querystage3len = 0;
  int querystage4len = 0;

  getUser() async{
    final uid = FirebaseAuth.instance.currentUser?.uid;//use a Async-await function to get the data
    print(uid);
    final data =  await FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: uid)
        .get()
        .then((value) => {
      setState(() {
        userProfileSnapshot = value;
      })
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("patients")
        .where("year", isEqualTo: "2020")
        .get()
        .then((value) => {
            setState(() {
              query2020 = value;
              query2020len = query2020!.size;
            })
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("patients")
        .where("year", isEqualTo: "2021")
        .get()
        .then((value) => {
            setState(() {
              query2021 = value;
              query2021len = query2021!.size;
            })
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("patients")
        .where("year", isEqualTo: "2022")
        .get()
        .then((value) => {
            setState(() {
              query2022 = value;
              query2022len = query2022!.size;
            })
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("patients")
        .where("state", isEqualTo: "1")
        .get()
        .then((value) => {
            setState(() {
              querystage1 = value;
              querystage1len = querystage1!.size;
            })
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("patients")
        .where("state", isEqualTo: "2")
        .get()
        .then((value) => {
            setState(() {
              querystage2 = value;
              querystage2len = querystage2!.size;
            })
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("patients")
        .where("state", isEqualTo: "3")
        .get()
        .then((value) => {
            setState(() {
              querystage3 = value;
              querystage3len = querystage3!.size;
            })
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("patients")
        .where("state", isEqualTo: "4")
        .get()
        .then((value) => {
            setState(() {
              querystage4 = value;
              querystage4len = querystage4!.size;
            })
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("patients")
        .get()
        .then((value) => {
            setState(() {
              querypatients = value;
              querypatientslen = querypatients!.size;
            })
    });
  
    
  }
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
    getUser();
    super.initState();
  }
  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;

    });
  }

  Widget buildName() => Column(
    children: [
      Text(
        currentUser.fullName.toString(),
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        currentUser.email.toString(),
        style: TextStyle(color: Colors.grey),
      )
    ],
  );


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    currentUser.number = userProfileSnapshot?.docs[0].get("number");
    currentUser.fullName = userProfileSnapshot?.docs[0].get("fullName");
    currentUser.email = userProfileSnapshot?.docs[0].get("email");


    var data = [
      ClicksPerYear('2020', query2020len, Colors.red),
      ClicksPerYear('2021', query2021len, Colors.yellow),
      ClicksPerYear('2022', query2022len, Colors.green),
    ];

    var series = [
      charts.Series(
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (ClicksPerYear clickData, _) => clickData.color,
        id: 'Clicks',
        data: data,
      ),
    ];

    var chart = new charts.BarChart(
      series,
      animate: true,
    );

    Map<String, double> dataMap = {
      "Stade 1": querystage1len.toDouble(),
      "Stade 2": querystage2len.toDouble(),
      "Stade 3": querystage3len.toDouble(),
      "Stade 4": querystage4len.toDouble(),
    };

    List<Color> colorList = [
      const Color(0xffD95AF3),
      const Color(0xFF6200E3),
      const Color(0xff3398FC),
      const Color(0xffFA4A42),
      const Color(0xffFE9539)
    ];

      return Scaffold(
      //backgroundColor: Colors.transparent,
      appBar: buildAppBar(context),
      body:  Stack(
            children: [
              ListView(
                physics: BouncingScrollPhysics(),
                //padding: const EdgeInsets.only(top:70.0),
                children: [
                  const SizedBox(height: 20),
                  buildName(),
                  const SizedBox(height: 20),
                  NumbersWidget(querypatientslen),
                ],
              ),
               Padding(
              padding: EdgeInsets.only(top:100.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 18.0),
                      child: Text("Le pourcentage des stade de la maladie KPS",style:
                      TextStyle(
                        fontSize: 15,
                        color: Colors.black45,
                      ),),),
                    Center(
                      child: PieChart(
                        dataMap: dataMap,
                        colorList: colorList,
                        chartRadius: MediaQuery.of(context).size.width / 2.3,
                        animationDuration: const Duration(seconds: 5),
                        chartValuesOptions: const ChartValuesOptions(
                            showChartValues: true,
                            showChartValuesOutside: false,
                            showChartValuesInPercentage: true,
                            showChartValueBackground: true),

                      ),
                    ),
                    Center(
                      child: Text("Les maladies du KPS selon l'année",style:
                      TextStyle(
                      fontSize: 15,
                      color: Colors.black45,
                    ),),),
                    Padding(
                      padding: EdgeInsets.only(left: 18.0,right: 18.0),
                    child: SizedBox(
                        height: 200.0,
                        child: chart,
                      ),
                    ),
                  ],
                ),
              ),),
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
                      child: FloatingActionButton(backgroundColor: Color(0xFF90CAF9), child: Icon(Icons.camera), elevation: 0.1, onPressed: () {},),
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
                              color: currentIndex == 0 ? Color(0xFF90CAF9) : Colors.black,
                            ),
                            onPressed: () {
                              setBottomBarIndex(0);
                            },
                            splashColor: Colors.white,
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.person_add_alt_1_sharp,
                                color: currentIndex == 1 ? Color(0xFF90CAF9) : Colors.black,
                              ),
                              onPressed: () {
                                setBottomBarIndex(1);
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
