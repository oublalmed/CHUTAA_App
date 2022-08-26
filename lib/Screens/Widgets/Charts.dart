import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Charts extends StatefulWidget {


  @override
  _ChartsState createState() => _ChartsState();
}

class ClicksPerYear {
  final String year;
  final int clicks;
  final charts.Color color;

  ClicksPerYear(this.year, this.clicks, Color color)
      : this.color = new charts.Color(r: Colors.red.red, g: Colors.green.green, b: Colors.blue.blue, a: Colors.red.alpha);
}

class _ChartsState extends State<Charts> {

  @override
  Widget build(BuildContext context) {
    var data = [
      ClicksPerYear('2016', 12, Colors.red),
      ClicksPerYear('2017', 42, Colors.yellow),
      ClicksPerYear('2018', 75, Colors.green),
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

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        Padding(
        padding: EdgeInsets.all(32.0),
        child: SizedBox(
          height: 200.0,
          child: chart,
        ),
      ),
          ],
        ),
      ),
      );
  }

}
