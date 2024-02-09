import 'dart:convert';
import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class MyPieChart extends StatelessWidget {
  final int value1;
  final int value2;

  const MyPieChart({required this.value1, required this.value2, super.key});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      swapAnimationDuration: const Duration(milliseconds: 750),
      swapAnimationCurve: Curves.easeInOutQuint,
      PieChartData(sections: [
        PieChartSectionData(
          showTitle: false,
          value: value1.toDouble(),
          color: const Color.fromARGB(255, 48, 201, 86),
        ),
        PieChartSectionData(
          showTitle: false,
          value: value2.toDouble(),
          color: const Color.fromARGB(255, 201, 48, 48),
        )
      ]),
    );
  }
}

class StatsChart extends StatefulWidget {
  StatsChart({Key? key}) : super(key: key);

  @override
  _StatsChartState createState() => _StatsChartState();
}

class _StatsChartState extends State<StatsChart> {
  int confidence0 = 0;
  int confidence1 = 0;
  int confidence2 = 0;
  int confidence3 = 0;
  int confidence4 = 0;
  int confidence5 = 0;

  @override
  void initState() {
    super.initState();
    getConfidence();
  }

  Future<void> getConfidence() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String filePath = '${documentsDirectory.path}/stats.json';

    File file = File(filePath);
    String jsonString = await file.readAsString();

    // Parse JSON content into a Dart list of maps
    List<dynamic> jsonList = jsonDecode(jsonString);
    List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(jsonList);

    // Update the score based on the character
    for (var item in data) {
      switch (item['score']) {
        case 0:
          setState(() {
            confidence0++;
          });
          break;
        case 1:
          setState(() {
            confidence1++;
          });
          break;
        case 2:
          setState(() {
            confidence2++;
          });
          break;
        case 3:
          setState(() {
            confidence3++;
          });
          break;
        case 4:
          setState(() {
            confidence4++;
          });
          break;
      }

      if (item['score'] >= 5) {
        setState(() {
          confidence5++;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PieChart(
      swapAnimationDuration: const Duration(milliseconds: 750),
      swapAnimationCurve: Curves.easeInOutQuint,
      PieChartData(sections: [
        PieChartSectionData(
          showTitle: false,
          value: confidence0.toDouble(),
          color: Colors.red,
        ),
        PieChartSectionData(
            showTitle: false,
            value: confidence1.toDouble(),
            color: Colors.yellow),
        PieChartSectionData(
            showTitle: false,
            value: confidence2.toDouble(),
            color: Colors.amber),
        PieChartSectionData(
            showTitle: false,
            value: confidence3.toDouble(),
            color: Colors.lightGreen),
        PieChartSectionData(
            showTitle: false,
            value: confidence4.toDouble(),
            color: Colors.green),
        PieChartSectionData(
            showTitle: false,
            value: confidence5.toDouble(),
            color: Colors.blue),
      ]),
    );
  }
}
