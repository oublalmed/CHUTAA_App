// import 'package:chuta_app/Model/Patient.dart';
// import 'package:chuta_app/Screens/Widgets/appbar_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
//
// List <Patient> Patients = [
//   Patient(
//       "1ff",
//       'ALAOUI Amine',
//       "email",
//       "number",
//       "birthday",
//       '17 janvier 2021',
//       "ffff",
//       "sane"),
//   Patient(
//       "1feeff",
//       'ALAOUI haname',
//       "email",
//       "number",
//       "birthday",
//       '17 janvier 2022',
//       "fffdef",
//       "sane"),
// ];
// class ListPatients extends StatelessWidget {
//
//
//
//   static Future<void> getAllFeedPatients()async
//   {
//       final uid = FirebaseAuth.instance.currentUser?.uid;//use a Async-await function to get the data
//       QuerySnapshot patients = await FirebaseFirestore.instance.collection("users")
//           .doc("cxd8VYF1LjVKd5ZjY8W4").collection("patients").get();
//       for (var patientDoc in patients.docs ) {
//         //PostSrc post = PostSrc.fromDoc(postDoc);
//         allPosts.add(patientDoc.get("number"));
//
//         Patient patient = Patient(patientDoc.get("patientId"),
//                                   patientDoc.get("name"),
//                                   patientDoc.get("email"),
//                                   patientDoc.get("number"),
//                                   patientDoc.get("birthday"),
//                                   patientDoc.get("consultation"),
//                                   patientDoc.get("numFile"),
//                                   patientDoc.get("state"));
//         print(patient);
//         Patients.add(patient);
//
//   }}
//
//   @override
//   Widget build(BuildContext context) {
//     getAllFeedPatients();
//     print(allPosts);
//     return Scaffold(
//       backgroundColor: Color(0xfff6f7f9),
//
//       appBar: buildAppBar(context),
//       body: ListView(
//         padding: const EdgeInsets.only(top: 30.0),
//         children: <Widget>[
//           Column(
//               children: Patients
//                   .map(
//                     (e) => Container(
//                   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(13),
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.grey,
//                           blurRadius: 10,
//                           spreadRadius: 3,
//                           offset: Offset(3, 4))
//                     ],
//                   ),
//
//                   child: ListTile(
//                     title: Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         e.name.toString(),
//                         style: TextStyle(fontSize: 22),
//                       ),
//                     ),
//                     subtitle: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text("" + e.consultation.toString()),
//                         SizedBox(height: 20),
//                         Container(
//                           alignment:Alignment.centerRight,
//                           padding:EdgeInsets.symmetric(horizontal:10.0,vertical:10.0),
//                           child:Align(
//                             alignment: Alignment.centerRight,
//                             child: FlatButton(
//                               onPressed:(){},
//                               color:Colors.red[200],
//                               shape:RoundedRectangleBorder(
//                                   borderRadius:BorderRadius.circular(20.0)
//                               ),
//
//                               child: Text("Consulter",style:TextStyle(color:Colors.white),
//                               ),
//                             ),
//                           ),
//                           // FlatButton
//                         ),// Container
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//                   .toList()
//           )
//         ],
//       ),
//     );
//   }
// }