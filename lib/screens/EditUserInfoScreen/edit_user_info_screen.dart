import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Create a Form widget.
class EditUserInfoScreen extends StatefulWidget {
  @override
  EditUserInfoScreenState createState() => EditUserInfoScreenState();
}

// Create a corresponding State class.
// This class holds data related to the form.
class EditUserInfoScreenState extends State<EditUserInfoScreen> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  var nickname;
  var age;
  var bio;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Edit Info",
                    style: TextStyle(
                      fontSize: 50
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  onChanged: (value){
                    nickname = value;
                  },
                  decoration: InputDecoration(
                      labelText: "Nickname",
                      errorStyle: TextStyle(
                          color: Colors.black
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                  maxLength: 16,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  onChanged: (value){
                    age = int.parse(value);
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  maxLength: 3,
                  decoration: InputDecoration(
                      labelText: "Age",
                      errorStyle: TextStyle(
                          color: Colors.black
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your age';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  onChanged: (value){
                    bio = value;
                  },
                  maxLength: 242,
                  decoration: InputDecoration(
                      labelText: "Bio",
                      errorStyle: TextStyle(
                          color: Colors.black
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: RaisedButton(
                  onPressed: (){
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, update user info.
                      Map<String, dynamic> result = {
                        "nickname" : nickname,
                        "age" : age,
                        "bio" : bio
                      };
                      Navigator.pop(context, result);
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}