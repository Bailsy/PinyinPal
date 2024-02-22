import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pinyinpal/models/lvl.dart';
import 'package:pinyinpal/pages/login/signup.dart';
import 'package:pinyinpal/services/cachelogin.dart';
import 'package:pinyinpal/services/profile_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    checkCache();
  }

  void checkCache() async {
    bool credentialsExist = await CacheLogin.credentialsExist();
    try {
      if (credentialsExist) {
        List<String> loginInfo = await CacheLogin.retrieveCredentials();
        userLogin(loginInfo[0], loginInfo[1]);
      }
    } catch (error) {
      print("failed to check cache!");
    }
  }

  //For LinearProgressIndicator.
  bool _visible = false;

  //Textediting Controller for Username and Password Input
  final userController = TextEditingController();
  final pwdController = TextEditingController();

  Future userLogin(String username, String password) async {
    // Create storage
    // Create storage
    CacheLogin.saveCredentials(username, password);

    //userController.text.trim()
    //pwdController.text.trim()

    String userUrl = "https://pinyinpal.com/login_api/user_login.php";

    // Showing LinearProgressIndicator.
    setState(() {
      _visible = true;
    });

    // Getting username and password from Controller
    var data = {
      'username': username,
      'password': password,
    };

    //Starting Web API Call.
    var response = await http.post(Uri.parse(userUrl), body: json.encode(data));
    if (response.statusCode == 200) {
      //Server response into variable
      var msg = jsonDecode(response.body);
      //Check Login Status
      if (msg['loginStatus'] == true) {
        setState(() {
          //hide progress indicator
          _visible = false;
        });

        await ProfileService.setDetails(msg);
        HskPath.hsklvl = 'hsk1';
        await HskPath.loadData();

        // Navigate to Home Screen
        Navigator.pushReplacementNamed(
          context,
          '/home',
        );
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

  Future<dynamic> showMessage(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(msg),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    throw {print("Unable to display the message!")};
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
                margin: const EdgeInsets.only(bottom: 10.0),
                child: const LinearProgressIndicator(),
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
            const SizedBox(
              height: 10.0,
            ),
            Text(
              'Login Here',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Theme(
                      data: ThemeData(
                        primaryColor: const Color.fromRGBO(84, 87, 90, 0.5),
                        primaryColorDark:
                            const Color.fromRGBO(24, 75, 126, 0.498),
                        hintColor: const Color.fromRGBO(
                            84, 87, 90, 0.5), //placeholder color
                      ),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: userController,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              style: BorderStyle.solid,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(84, 87, 90, 0.5),
                              style: BorderStyle.solid,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          labelText: 'Enter User Name',
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color.fromRGBO(84, 87, 90, 0.5),
                          ),
                          border: OutlineInputBorder(
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
                    const SizedBox(
                      height: 20.0,
                    ),
                    Theme(
                      data: ThemeData(
                        primaryColor: const Color.fromRGBO(84, 87, 90, 0.5),
                        primaryColorDark: const Color.fromRGBO(84, 87, 90, 0.5),
                        hintColor: const Color.fromRGBO(
                            84, 87, 90, 0.5), //placeholder color
                      ),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: pwdController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              style: BorderStyle.solid,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(84, 87, 90, 0.5),
                              style: BorderStyle.solid,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(84, 87, 90, 0.5),
                              style: BorderStyle.solid,
                            ),
                          ),
                          labelText: 'Enter Password',
                          prefixIcon: Icon(
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
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white.withOpacity(0.2)),
                          textAlign: TextAlign.center,
                        ),
                        InkWell(
                          child: const Text(
                            "Sign Up",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.blue),
                            textAlign: TextAlign.center,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpPage()));
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () => {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate())
                            {
                              userLogin(userController.text.trim(),
                                  pwdController.text.trim())
                            }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColor),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Submit',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
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
