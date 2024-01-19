import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pinyinpal/page/home.dart';


class LoginPage extends StatefulWidget {

   LoginPage({Key? key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //For LinearProgressIndicator.
  bool _visible = false;

  //Textediting Controller for Username and Password Input
  final userController = TextEditingController();
  final pwdController = TextEditingController();

  Future userLogin() async {
    //Login API URL
    //use your local IP address instead of localhost or use Web API
    String url = "https://pinyinpal.com/login_api/user_login.php";

    // Showing LinearProgressIndicator.
    setState(() {
      _visible = true;
    });

    // Getting username and password from Controller
    var data = {
      'username': userController.text.trim(),
      'password': pwdController.text.trim(),
    };

    //Starting Web API Call.
    var response = await http.post(Uri.parse(url), body: json.encode(data));
    if (response.statusCode == 200) {
      //Server response into variable
      print(response.body);
      var msg = jsonDecode(response.body);

      //Check Login Status
      if (msg['loginStatus'] == true) {
        setState(() {
          //hide progress indicator
          _visible = false;
        });

        // Navigate to Home Screen
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        setState(() {
          //hide progress indicator
          _visible = false;

          //Show Error Message Dialog
          showMessage(msg["message"]);
        });
      }
    } else {
      setState(() {
        //hide progress indicator
        _visible = false;

        //Show Error Message Dialog
        showMessage("Error during connecting to Server.");
      });
    }
  }

  Future<dynamic> showMessage(String _msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(_msg),
          actions: <Widget>[
            TextButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    throw{print("Unable to display the message!")};
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: _visible,
              child: Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: LinearProgressIndicator(),
              ),
            ),
            Container(
              height: 100.0,
            ),
            Icon(
              Icons.group,
              color: Theme.of(context).primaryColor,
              size: 80.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Login Here',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40.0,
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Theme(
                      data: new ThemeData(
                        primaryColor: Color.fromRGBO(84, 87, 90, 0.5),
                        primaryColorDark: Color.fromRGBO(24, 75, 126, 0.498),
                        hintColor:
                            Color.fromRGBO(84, 87, 90, 0.5), //placeholder color
                      ),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: userController,
                        decoration: InputDecoration(
                          focusedBorder: new OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              style: BorderStyle.solid,
                            ),
                          ),
                          enabledBorder: new OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(84, 87, 90, 0.5),
                              style: BorderStyle.solid,
                            ),
                          ),
                          errorBorder: new OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          labelText: 'Enter User Name',
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Color.fromRGBO(84, 87, 90, 0.5),
                          ),
                          border: new OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(84, 87, 90, 0.5),
                              style: BorderStyle.solid,
                            ),
                          ),
                          hintText: 'User Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter User Name';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Theme(
                      data: new ThemeData(
                        primaryColor: Color.fromRGBO(84, 87, 90, 0.5),
                        primaryColorDark: Color.fromRGBO(84, 87, 90, 0.5),
                        hintColor:
                            Color.fromRGBO(84, 87, 90, 0.5), //placeholder color
                      ),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: pwdController,
                        obscureText: true,
                        decoration: InputDecoration(
                          focusedBorder: new OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              style: BorderStyle.solid,
                            ),
                          ),
                          enabledBorder: new OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(84, 87, 90, 0.5),
                              style: BorderStyle.solid,
                            ),
                          ),
                          errorBorder: new OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          border: new OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(84, 87, 90, 0.5),
                              style: BorderStyle.solid,
                            ),
                          ),
                          labelText: 'Enter Password',
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Color.fromRGBO(84, 87, 90, 0.5),
                          ),
                          hintText: 'Password',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Password';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () => {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {userLogin()}
                        },
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Submit',
                            style: TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}