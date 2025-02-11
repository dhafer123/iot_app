import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  // Example data
  final int totalComplaints = 25;
  final int openComplaints = 10;
  final int resolvedComplaints = 12;
  final int escalatedComplaints = 3;
  final double averageResolutionTime = 2.5; // in days

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Statistiques et Analyses',
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
            // Total Complaints
            _buildStatCard(
              title: 'Total des plaintes',
              value: totalComplaints.toString(),
              icon: Icons.receipt,
              color: Colors.blue,
            ),
            SizedBox(height: 10),
            // Open Complaints
            _buildStatCard(
              title: 'Plaintes ouvertes',
              value: openComplaints.toString(),
              icon: Icons.warning,
              color: Colors.orange,
            ),
            SizedBox(height: 10),
            // Resolved Complaints
            _buildStatCard(
              title: 'Plaintes résolues',
              value: resolvedComplaints.toString(),
              icon: Icons.check_circle,
              color: Colors.green,
            ),
            SizedBox(height: 10),
            // Escalated Complaints
            _buildStatCard(
              title: 'Plaintes escaladées',
              value: escalatedComplaints.toString(),
              icon: Icons.error,
              color: Colors.red,
            ),
            SizedBox(height: 10),
            // Average Resolution Time
            _buildStatCard(
              title: 'ATemps moyen de résolution',
              value: '$averageResolutionTime jours',
              icon: Icons.timer,
              color: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  // Build a stat card
  Widget _buildStatCard({required String title, required String value, required IconData icon, required Color color}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  value,
                  style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}