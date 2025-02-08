import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class SatisfactionPage extends StatelessWidget {
  // Generate random satisfaction data for the last 7 days
  final Random random = Random();
  final List<double> satisfactionData = List.generate(7, (index) => Random().nextInt(100).toDouble());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Client Satisfaction',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Satisfaction Trend (Last 7 Days)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Line Chart
            Container(
              height: 300,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()}%',
                            style: TextStyle(fontSize: 12),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            'Day ${value.toInt() + 1}',
                            style: TextStyle(fontSize: 12),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: _generateLineChartSpots(),
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 4,
                      belowBarData: BarAreaData(show: false),
                      dotData: FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Satisfaction Distribution',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Pie Chart
            Container(
              height: 300,
              child: PieChart(
                PieChartData(
                  sections: _generatePieChartSections(),
                  centerSpaceRadius: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Generate line chart data points
  List<FlSpot> _generateLineChartSpots() {
    return List.generate(7, (index) {
      return FlSpot(index.toDouble(), satisfactionData[index]);
    });
  }

  // Generate pie chart data
  List<PieChartSectionData> _generatePieChartSections() {
    return List.generate(5, (index) {
      return PieChartSectionData(
        value: satisfactionData[index % satisfactionData.length],
        color: _getColor(index),
        title: '${index + 1}',
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    });
  }

  // Get colors for pie chart sections
  Color _getColor(int index) {
    switch (index) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.orange;
      case 2:
        return Colors.yellow;
      case 3:
        return Colors.green;
      case 4:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}