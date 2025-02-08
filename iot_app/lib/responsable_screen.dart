import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'statistics_page.dart'; // Import the statistics page
import 'satisfaction_page.dart'; // Import the satisfaction page

class ResponsablePage extends StatefulWidget {
  @override
  _ResponsablePageState createState() => _ResponsablePageState();
}

class _ResponsablePageState extends State<ResponsablePage> {
  List<Map<String, dynamic>> complaints = [
    {'id': 1, 'date': '2023-10-01', 'message': 'Product not working properly.', 'response': '', 'status': 'Open'},
    {'id': 2, 'date': '2023-10-05', 'message': 'Late delivery.', 'response': '', 'status': 'Open'},
    {'id': 3, 'date': '2023-10-10', 'message': 'Poor customer service.', 'response': '', 'status': 'Open'},
  ];

  String selectedDate = 'All';
  String searchQuery = '';
  bool isLoading = false;

  void _filterComplaints(String date) {
    setState(() {
      selectedDate = date;
    });
  }

  void _respondToComplaint(int id, String response) {
    setState(() {
      isLoading = true;
    });

    // Simulate a network call or delay
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        complaints.firstWhere((complaint) => complaint['id'] == id)['response'] = response;
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: "Response submitted!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    });
  }

  void _markAsResolved(int id) {
    setState(() {
      complaints.firstWhere((complaint) => complaint['id'] == id)['status'] = 'Resolved';
    });
    Fluttertoast.showToast(
      msg: "Complaint marked as resolved!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
    );
  }

  void _escalateComplaint(int id) {
    setState(() {
      complaints.firstWhere((complaint) => complaint['id'] == id)['status'] = 'Escalated';
    });
    Fluttertoast.showToast(
      msg: "Complaint escalated!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
    );
  }

  List<Map<String, dynamic>> get filteredComplaints {
    return complaints.where((complaint) {
      bool matchesDate = selectedDate == 'All' || complaint['date'] == selectedDate;
      bool matchesSearch = complaint['message'].toLowerCase().contains(searchQuery.toLowerCase());
      return matchesDate && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Client Complaints',
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
        leading: IconButton( // Button for Satisfaction Page
          icon: Icon(Icons.analytics, color: Colors.white), // Change the icon
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SatisfactionPage()),
            );
          },
        ),
        actions: [
          IconButton( // Button for Statistics Page
            icon: Icon(Icons.bar_chart, color: Colors.white), // Set icon color to white
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StatisticsPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search complaints...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          // Date Filter Dropdown
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: DropdownButton<String>(
                  value: selectedDate,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      _filterComplaints(newValue);
                    }
                  },
                  items: <String>['All', '2023-10-01', '2023-10-05', '2023-10-10']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                  isExpanded: true,
                  underline: SizedBox(),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          // Complaints List
          Expanded(
            child: isLoading
                ? Center(
                    child: SpinKitFadingCircle(
                      color: Colors.blue,
                      size: 50.0,
                    ),
                  )
                : filteredComplaints.isEmpty
                    ? Center(
                        child: Text(
                          'No complaints found.',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredComplaints.length,
                        itemBuilder: (context, index) {
                          final complaint = filteredComplaints[index];
                          Color statusColor;
                          switch (complaint['status']) {
                            case 'Resolved':
                              statusColor = Colors.green;
                              break;
                            case 'Escalated':
                              statusColor = Colors.orange;
                              break;
                            default:
                              statusColor = Colors.red;
                          }
                          return Card(
                            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(16.0),
                              title: Text(
                                complaint['message'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8),
                                  Text(
                                    'Date: ${complaint['date']}',
                                    style: TextStyle(fontSize: 14, color: Colors.grey),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Status: ${complaint['status']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: statusColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (complaint['response'].isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        'Response: ${complaint['response']}',
                                        style: TextStyle(fontSize: 14, color: Colors.green),
                                      ),
                                    ),
                                ],
                              ),
                              trailing: PopupMenuButton<String>(
                                icon: Icon(Icons.more_vert),
                                onSelected: (String value) {
                                  if (value == 'resolve') {
                                    _markAsResolved(complaint['id']);
                                  } else if (value == 'escalate') {
                                    _escalateComplaint(complaint['id']);
                                  } else if (value == 'respond') {
                                    _showResponseDialog(complaint['id']);
                                  }
                                },
                                itemBuilder: (BuildContext context) {
                                  return [
                                    PopupMenuItem(
                                      value: 'resolve',
                                      child: Text('Mark as Resolved'),
                                    ),
                                    PopupMenuItem(
                                      value: 'escalate',
                                      child: Text('Escalate'),
                                    ),
                                    PopupMenuItem(
                                      value: 'respond',
                                      child: Text('Respond'),
                                    ),
                                  ];
                                },
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  void _showResponseDialog(int id) {
    TextEditingController responseController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Respond to Complaint',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: TextField(
            controller: responseController,
            decoration: InputDecoration(
              hintText: 'Enter your response',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (responseController.text.isNotEmpty) {
                  _respondToComplaint(id, responseController.text);
                  Navigator.of(context).pop();
                } else {
                  Fluttertoast.showToast(
                    msg: "Please enter a response!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                  );
                }
              },
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }
}