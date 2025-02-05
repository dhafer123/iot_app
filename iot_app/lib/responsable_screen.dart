import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ResponsablePage extends StatefulWidget {
  @override
  _ResponsablePageState createState() => _ResponsablePageState();
}

class _ResponsablePageState extends State<ResponsablePage> {
  List<Map<String, dynamic>> complaints = [
    {'id': 1, 'date': '2023-10-01', 'message': 'Product not working properly.', 'response': ''},
    {'id': 2, 'date': '2023-10-05', 'message': 'Late delivery.', 'response': ''},
    {'id': 3, 'date': '2023-10-10', 'message': 'Poor customer service.', 'response': ''},
  ];

  String selectedDate = 'All';
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

  List<Map<String, dynamic>> get filteredComplaints {
    if (selectedDate == 'All') {
      return complaints;
    } else {
      return complaints.where((complaint) => complaint['date'] == selectedDate).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Complaints', style: TextStyle(
        color: Colors.white, )),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.blue.shade900],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
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
          Expanded(
            child: isLoading
                ? Center(
                    child: SpinKitFadingCircle(
                      color: Colors.blue,
                      size: 50.0,
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredComplaints.length,
                    itemBuilder: (context, index) {
                      final complaint = filteredComplaints[index];
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
                          trailing: IconButton(
                            icon: Icon(Icons.reply, color: Colors.blue.shade900),
                            onPressed: () {
                              _showResponseDialog(complaint['id']);
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
              child: Text('Cancel', style: TextStyle(
                  color: Colors.blue[900])),
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
                style: TextStyle(color: Colors.blue.shade900),
              ),
            ),
          ],
        );
      },
    );
  }
}