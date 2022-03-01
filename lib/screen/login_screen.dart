import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_database/database/database_utils.dart';
import 'package:login_database/screen/change_password.dart';
import 'package:login_database/screen/main_screen.dart';
import 'package:login_database/screen/profile_screen.dart';
import 'package:login_database/widgets/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../user_modal.dart';
import 'forget_password.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late SharedPreferences prefs;


  final loginScreenKey = GlobalKey<FormState>();
  bool isPassword=true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FocusNode emailFocus = FocusNode();

  save() async
  {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("email", _emailController.text);
    prefs.setString("password", _passwordController.text);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 0),
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.175,
              ),
              Form(
                key: loginScreenKey,
                child: Card(
                  elevation: 7,
                  shadowColor: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 14, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Welcome,",
                              style: TextStyle(
                                  fontSize: 30.0, fontWeight: FontWeight.w700),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpScreen()));
                              },
                              child: Text(
                                "Sign",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                    color: colorGreen),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Sign in to Continue",
                            style: TextStyle(
                                fontSize: 14.0,
                                color: colorGrey,
                                fontWeight: FontWeight.w400)),
                        const SizedBox(
                          height: 40,
                        ),
                        Text("Email",
                            style: TextStyle(
                                color: colorGrey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400)),
                        const SizedBox(
                          height: 17,
                        ),
                        Container(
                          width: double.infinity,
                          height: 33,
                          child: TextFormField(
                            focusNode: emailFocus,
                            autofocus: true,
                            validator: (value) {
                              if (!EmailValidator.validate(value ?? "")) {
                                return 'Enter valid email';
                              }
                            },
                            controller: _emailController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                                color: colorBlack,
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: colorGreen),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: colorGreen),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 39,
                        ),
                        Text("Password",
                            style: TextStyle(
                                color: colorGrey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400)),
                        const SizedBox(
                          height: 17,
                        ),
                        Container(
                          width: double.infinity,
                          height: 33,
                          child: TextFormField(
                            obscureText: isPassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Password';
                              }
                              if (_passwordController.text.length < 8) {
                                return 'Please Enter 8 Digits Password';
                              }
                            },
                            controller: _passwordController,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                                color: colorBlack,
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                            decoration:  InputDecoration(
                              suffixIcon: IconButton(
                                icon: isPassword
                                    ? Icon(
                                  Icons.visibility,
                                  color: Colors.black,
                                )
                                    : Icon(Icons.visibility_off,
                                    color: Colors.black),
                                onPressed: () {
                                  setState(() {
                                    isPassword = !isPassword;
                                  });
                                },
                              ),

                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: colorGreen),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: colorGreen),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 19,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                             forgotClick();
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        InkWell(
                          onTap: () {
                            if (loginScreenKey.currentState!.validate()) {
                              loginClick();
                            }
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: colorGreen,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "SIGN IN",
                              style: TextStyle(
                                  color: colorWhite,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  loginClick() async {
    Database db = await DatabaseUtils.db.database;
    final result = await db.rawQuery(
        "SELECT * FROM logindata WHERE email=?", [_emailController.text]);
    if (result.isNotEmpty) {
      final login = await db.rawQuery(
          "SELECT * FROM logindata WHERE email=? AND password=?",
          [_emailController.text, _passwordController.text]);
      if (login.isNotEmpty) {
        save();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Invalid Password"),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("InValid email "),
        ),
      );
    }
  }

  forgotClick() async {
    Database db = await DatabaseUtils.db.database;
    final result = await db.rawQuery(
        "SELECT * FROM logindata WHERE email=?", [_emailController.text]);
    if (result.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ForgotPassword(
                email: _emailController.text,
              )));
      
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("InValid email. Select Right Mail And Try Again ! "),
        ),
      );
    }
  }
}
