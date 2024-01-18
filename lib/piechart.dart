import 'package:fl_chart/fl_chart.dart';
import'package:flutter/material.dart';

class MyPieChart extends StatelessWidget{
  final int value1;
  final int value2;

  const MyPieChart({required this.value1, required this.value2, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return PieChart(
      swapAnimationDuration: const Duration(milliseconds: 750),
      swapAnimationCurve: Curves.easeInOutQuint,
      PieChartData(
        sections: [
          PieChartSectionData(
            showTitle: false,
            value: value1.toDouble(),
            color: Color.fromARGB(255, 48, 201, 86),
          ),
          PieChartSectionData(
            showTitle: false,
            value: value2.toDouble(),
            color: Color.fromARGB(255, 201, 48, 48),
          )
        ]
      ),
    );
  }
}