import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:login_database/database/database_utils.dart';
import 'package:login_database/screen/profile_screen.dart';
import 'package:login_database/user_modal.dart';
import 'package:sqflite/sqflite.dart';

import '../widgets/app_colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final signupScreenKey = GlobalKey<FormState>();

  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _signEmailController = TextEditingController();
  final TextEditingController _signPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 16, bottom: 20, right: 15),
          child: Form(
            key: signupScreenKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                Card(
                  elevation: 6.8,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 14, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              size: 34,
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 48,
                        ),
                        Text(
                          "First Name",
                          style: TextStyle(
                              fontSize: 14.0,
                              color: colorGrey,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        Container(
                          width: double.infinity,
                          height: 33,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Name';
                              }
                            },
                            controller: _fNameController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                                color: colorBlack,
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: colorLightGrey),
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
                        Text(
                          "Last Name",
                          style: TextStyle(
                              fontSize: 14.0,
                              color: colorGrey,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        Container(
                          width: double.infinity,
                          height: 33,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Name';
                              }
                            },
                            controller: _lNameController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                                color: colorBlack,
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: colorLightGrey),
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
                        Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        Container(
                          width: double.infinity,
                          height: 33,
                          child: TextFormField(
                            validator: (value) {
                              if (!EmailValidator.validate(value ?? "")) {
                                return 'Enter valid email';
                              }
                            },
                            controller: _signEmailController,
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
                        Text(
                          "Password",
                          style: TextStyle(
                              fontSize: 14.0,
                              color: colorGrey,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        Container(
                          width: double.infinity,
                          height: 33,
                          child: TextFormField(
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Password';
                              }
                              if (_signPasswordController.text.length < 8) {
                                return 'Please Enter 8 Digits Password';
                              }
                            },
                            controller: _signPasswordController,
                            textInputAction: TextInputAction.done,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // TextButton(
                            //     onPressed: () {
                            //       // Navigator.push(
                            //       //     context,
                            //       //     MaterialPageRoute(
                            //       //         builder: (context) =>
                            //       //             ProfileScreen()));
                            //     },
                            //     child: Text("Next")),
                            // TextButton(
                            //     // onPressed: () {
                            //     //   UserLoginModal loginModal = UserLoginModal(
                            //     //       fName: _fNameController.text,
                            //     //       lName: _lNameController.text,
                            //     //       email: _signEmailController.text,
                            //     //       password: _signPasswordController.text);
                            //     //   DatabaseUtils.db.insertData(loginModal);
                            //     //   Navigator.push(
                            //     //       context,
                            //     //       MaterialPageRoute(
                            //     //           builder: (context) =>
                            //     //               ProfileScreen()));
                            //     // },
                            //     onPressed: () {  },
                            //     child: Text("simple insert")),
                          ],
                        ),
                        const SizedBox(
                          height: 0,
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        InkWell(
                          onTap: () {
                            if (signupScreenKey.currentState!.validate()) {
                              signInClick();
                            }
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.height,
                            color: colorGreen,
                            alignment: Alignment.center,
                            child: const Text(
                              "SIGN IN",
                              style: TextStyle(color: colorWhite),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  signInClick() async {
    Database db = await DatabaseUtils.db.database;
    final result = await db.rawQuery(
        "SELECT * FROM loginData WHERE email=?", [_signEmailController.text]);
    if (result.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email is already Exist \n please select new email"),
          backgroundColor: colorBlack,
        ),
      );
    } else {
      UserLoginModal loginModal = UserLoginModal();
      loginModal
        ..fName = _fNameController.text
        ..lName = _lNameController.text
        ..email = _signEmailController.text
        ..password = _signPasswordController.text;
      await DatabaseUtils.db.insertData(loginModal);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfileScreen()));
    }
  }
}
