import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobilevote/Admin/fpa_page.dart';
import 'package:mobilevote/model/vote.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:syncfusion_flutter_charts/charts.dart';

class FskmPage extends StatefulWidget {
  const FskmPage({Key? key}) : super(key: key);

  @override
  _FskmPageState createState() => _FskmPageState();
}

class _FskmPageState extends State<FskmPage> {
  bool loading = true;
  @override
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<double>>(
      future: FirebaseFirestore.instance
          .runTransaction((Transaction transaction) async {
        CollectionReference reference =
            FirebaseFirestore.instance.collection('vote');
        double countCand1 = 0;
        double countCand2 = 0;
        double countCand3 = 0;
        // Get docs from collection reference
        QuerySnapshot querySnapshot = await reference.get();

        // Get data from docs and convert map to List
        await FirebaseFirestore.instance
            .collection('vote')
            .get()
            .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            print(doc["candidate"]);
            if (doc["candidate"] == "candidate1") {
              countCand1++;
            } else if (doc["candidate"] == "candidate2") {
              countCand2++;
            } else if (doc["candidate"] == "candidate3") {
              countCand3++;
            }
          });
        });
        var candidates = [countCand1, countCand2, countCand3];
        return candidates;
      }), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<List<double>> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text('Please wait its loading...'));
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else
            return Scaffold(
                body: Center(
                    child: Container(
                        child: SfCircularChart(
                            series: <CircularSeries>[
                  // Renders doughnut chart
                  DoughnutSeries<ChartData, String>(
                    dataSource: [
                      ChartData(
                          'Wan Nur Ain',
                          double.parse('${snapshot.data![0]}'),
                          Colors.pink.shade400),
                      ChartData(
                          'Ain Saqinah',
                          double.parse('${snapshot.data![1]}'),
                          Colors.purple.shade300),
                      ChartData(
                          'Aqib Fawwaz',
                          double.parse('${snapshot.data![2]}'),
                          Colors.blue.shade900),
                    ],
                    //chartData,
                    pointColorMapper: (ChartData data, _) => data.color,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    //dataLabelMapper: (ChartData data, _) => data.text,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    explode: true,
                    explodeGesture: ActivationMode.singleTap,
                    innerRadius: '60%',
                  ),
                ],
                            legend: Legend(
                                isVisible: true,
                                title: LegendTitle(
                                  text: 'Fskm Results',
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w500),
                                ))))));
          // snapshot.data  :- get your object which is pass from your downloadData() function
        }
      },
    );
  }
}
