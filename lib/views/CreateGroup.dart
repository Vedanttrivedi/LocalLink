import 'package:flutter/material.dart';

import 'package:chatbotapp/services/database_service.dart';

class MyForm extends StatefulWidget {
  String? userid;
  String? username;
  MyForm(this.userid, this.username);
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  String? _groupName;
  String? _description;
  String? _activity;
  bool _isPublic = false;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Perform your form submission logic here, like saving data to a database or making an API call.

      //call api addGroup

      print('Group Name: $_groupName');
      print('Description: $_description');
      print('Activity: $_activity');
      print('Is Public Group: $_isPublic');

      DatabaseService db = DatabaseService(currentUserid: this.widget.userid!);
      db.createGroup(
          this.widget.username!, _groupName, _description, _activity);

      Navigator.pop(context);
    } else {
      setState(() {
        _isPublic = false; // Reset the checkbox if the form is not valid
      });
    }
  }

  String? _validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            print("button clicked");
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            size: 30,
                          ),
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Center(
                          child: Text(
                            "Create New Group",
                            style:
                                TextStyle(fontSize: 25, color: Colors.orange),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white), // Text color
                    decoration: InputDecoration(
                      labelText: 'Group Name',
                      labelStyle: TextStyle(color: Colors.deepPurpleAccent),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurpleAccent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurpleAccent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurpleAccent),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    validator: _validateRequired,
                    onSaved: (value) {
                      _groupName = value;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    style: TextStyle(color: Colors.white), // Text color
                    maxLines: 3, // Multiline
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Colors.deepPurpleAccent),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurpleAccent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurpleAccent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurpleAccent),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    validator: _validateRequired,
                    onSaved: (value) {
                      _description = value;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    style: TextStyle(color: Colors.white), // Text color
                    decoration: InputDecoration(
                      labelText: 'Activity',
                      labelStyle: TextStyle(color: Colors.deepPurpleAccent),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurpleAccent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurpleAccent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurpleAccent),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    validator: _validateRequired,
                    onSaved: (value) {
                      _activity = value;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CheckboxListTile(
                    title: Text(
                      'Public Group',
                      style: TextStyle(color: Colors.white),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    value: _isPublic,
                    onChanged: (value) {
                      setState(() {
                        _isPublic = value!;
                      });
                    },
                    activeColor: Colors.deepPurpleAccent,
                    checkColor: Colors.orange,
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurpleAccent,
                    ),
                    child: Text('Submit'),
                  ),
                  SizedBox(height: 16.0),
                  if (_formKey.currentState != null &&
                      !_formKey.currentState!.validate())
                    Text(
                      'Please fill in all required fields',
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
