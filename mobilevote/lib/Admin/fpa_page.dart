import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matcher/matcher.dart';
import 'package:mobilevote/Admin/fskm_page.dart';
import 'package:mobilevote/model/vote.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:syncfusion_flutter_charts/charts.dart';

class FpaPage extends StatefulWidget {
  const FpaPage({Key? key}) : super(key: key);

  @override
  _FpaPageState createState() => _FpaPageState();
}

class _FpaPageState extends State<FpaPage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                child: SfCircularChart(
                    series: <CircularSeries>[
          // Renders doughnut chart
          DoughnutSeries<ChartData, String>(
            dataSource: [
              ChartData(' Aqil', 4, Colors.pink.shade400),
              ChartData('Dawson ', 3, Colors.purple.shade300),
              ChartData(' Idris', 2, Colors.blue.shade900),
              //           QuerySnapshot querySnapshot = await reference.get();
              //           var users = [];
              //           int count = 0;
              //           // Get data from docs and convert map to List
              //           await FirebaseFirestore.instance
              //           .collection('voteFPA')
              //           .get()
              //           .then((QuerySnapshot querySnapshot) {
              //            querySnapshot.docs.forEach((doc) {
              //           users.add(doc[]);
              //           print(doc["candidate"]);
              //   });
              // });
              // print(count);
            ],
            //chartData,
            pointColorMapper: (ChartData data, _) => data.color,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            //dataLabelMapper: (ChartData data, _) => data.text,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            explode: true,
            explodeGesture: ActivationMode.singleTap,
            innerRadius: '70%',
          ),
        ],
                    legend: Legend(
                        isVisible: true,
                        title: LegendTitle(
                          text: 'FPA Results',
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500),
                        ))))));
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
