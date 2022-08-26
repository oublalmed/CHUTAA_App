import 'package:chuta_app/Model/Patient.dart';
import 'package:flutter/material.dart';

class PatientWidget extends StatelessWidget {
  final Patient patient;
  PatientWidget(this.patient);
  Widget textfield({@required hintText}) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF90CAF9),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 250,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(

                    )
                  ],
                ),
              )
            ],
          ),
          CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            painter: HeaderCurvedContainer(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "À propos du patient",
                  style: TextStyle(
                    fontSize: 25,
                    letterSpacing: 1.5,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
      Container(
        padding: EdgeInsets.only(top: 140.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Center(
             child: Text(
             patient.name.toString(),
             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
             textAlign: TextAlign.center,
           ),),

            const SizedBox(height: 16),
            Center (
                child: Text(
              "date de consultation : "+patient.consultation.toString(),
              style: TextStyle(fontSize: 16, height: 1.4),
                    textAlign: TextAlign.start,
            )),
            const SizedBox(height: 16),
            Center (
            child: Text(
              "date de naissance : "+patient.birthday.toString(),
              style: TextStyle(fontSize: 16, height: 1.4),
                textAlign: TextAlign.start,
            )),
            const SizedBox(height: 16),
            Center (
            child: Text(
              "Mail patient  : "+patient.email.toString(),
              style: TextStyle(fontSize: 16, height: 1.4),
                textAlign: TextAlign.start,
            )),
            const SizedBox(height: 16),
            Center (
            child: Text(
              "La maladie : KPS",
              style: TextStyle(fontSize: 16, height: 1.4),
                textAlign: TextAlign.start,
            )),
            const SizedBox(height: 16),
            Center (
            child: Text(
              "Le niveau  : stade 1",
              style: TextStyle(fontSize: 16, height: 1.4),
                textAlign: TextAlign.start
            )),
            const SizedBox(height: 16),
            Center (
            child: Text(
              "Num de téléphone  : "+patient.number.toString(),
              style: TextStyle(fontSize: 16, height: 1.4),
                textAlign: TextAlign.start,
            )),
            const SizedBox(height: 16),
            Center (
            child: Text(
              "Num de dossier  : "+patient.numFile.toString(),
              style: TextStyle(fontSize: 16, height: 1.4),
                textAlign: TextAlign.start,
            )),
          ],
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 100),
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 54,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [(new  Color(0xFF90CAF9)), new Color(0xFF90CAF9)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight
              ),
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey[200],
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: Color(0xffEEEEEE)
                ),
              ],
            ),
            child: Text(
              "Voir dossier",
              style: TextStyle(
                fontSize: 18,
                  color: Colors.white
              ),
            ),
          ),),
        ],
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xFF90CAF9);
    Path path = Path()
      ..relativeLineTo(0, 80)
      ..quadraticBezierTo(size.width / 2, 155, size.width, 80)
      ..relativeLineTo(0, -80)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}