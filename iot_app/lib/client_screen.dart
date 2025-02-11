import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class ClientPage extends StatefulWidget {
  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _complaintController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();

  List<Map<String, dynamic>> complaints = [];
  List<Map<String, String>> questions = [];

  File? _image;
  File? _file;

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to pick image: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        setState(() {
          _file = File(result.files.single.path!);
        });
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to pick file: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  void _submitComplaint() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        complaints.add({
          'date': DateTime.now().toString(),
          'message': _complaintController.text,
          'image': _image,
          'file': _file,
        });
        _complaintController.clear();
        _image = null;
        _file = null;
      });
      Fluttertoast.showToast(
        msg: "Complaint submitted successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    }
  }

  void _askQuestion() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        questions.add({
          'date': DateTime.now().toString(),
          'message': _questionController.text,
        });
        _questionController.clear();
      });
      Fluttertoast.showToast(
        msg: "Question submitted successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Page client',
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
            // Submit a Complaint Section
            Text(
              'Soumettre une plainte',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _complaintController,
                    decoration: InputDecoration(
                      labelText: 'Entrez votre plainte',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null) {
                        return 'Veuillez entrer votre plainte';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      IconButton(
                        onPressed: _pickImage,
                        icon: Icon(Icons.image, color: Colors.blue),
                        tooltip: 'Attach Image',
                      ),
                      IconButton(
                        onPressed: _pickFile,
                        icon: Icon(Icons.attach_file, color: Colors.blue),
                        tooltip: 'Attach File',
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: _submitComplaint,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Soumettre la plainte',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  if (_image != null)
                    Column(
                      children: [
                        Text(
                          'Image sélectionnée :',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Image.file(
                          _image!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  if (_file != null)
                    Column(
                      children: [
                        Text(
                          'Fichier sélectionné :',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          _file!.path.split('/').last,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Ask a Question Section
            Text(
              'Poser une question',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: _questionController,
                    decoration: InputDecoration(
                      labelText: 'Entrez votre question',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre question';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _askQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Poser la question',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Your Complaints Section
            Text(
              'Vos plaintes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            complaints.isEmpty
                ? Text('Aucune plainte soumise pour le moment.')
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: complaints.length,
                    itemBuilder: (context, index) {
                      final complaint = complaints[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(complaint['message']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Date: ${complaint['date']}'),
                              if (complaint['image'] != null)
                                Image.file(
                                  complaint['image'],
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              if (complaint['file'] != null)
                                Text(
                                    'File: ${complaint['file'].path.split('/').last}'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
            SizedBox(height: 20),

            // Your Questions Section
            Text(
              'Vos questions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            questions.isEmpty
                ? Text('Aucune question soumise pour le moment.')
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      final question = questions[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(
                              question['message']!), // Use ! to assert non-null
                          subtitle: Text(
                              'Date: ${question['date']!}'), // Use ! to assert non-null
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
