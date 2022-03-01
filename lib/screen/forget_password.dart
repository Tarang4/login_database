import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:login_database/database/database_utils.dart';
import 'package:login_database/screen/profile_screen.dart';
import 'package:login_database/user_modal.dart';
import 'package:login_database/widgets/app_colors.dart';
import 'package:sqflite/sqflite.dart';

class ForgotPassword extends StatefulWidget {
  final String email;

  const ForgotPassword({Key? key, required this.email}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool isPasswordOdd = true;
  bool isPasswordNew = true;
  late String email;
  final loginScreenKey = GlobalKey<FormState>();

  final TextEditingController _oldController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _new1Controller = TextEditingController();
  final TextEditingController _new2Controller = TextEditingController();
  FocusNode emailFocus = FocusNode();

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool validatePassword(String value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return regex.hasMatch(value);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = widget.email;
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
                height: MediaQuery.of(context).size.height * 0.08,
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
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              size: 34,
                            )),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Forgot Password,",
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text("Enter Phone Number",
                            style: TextStyle(
                                color: colorGrey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400)),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: double.infinity,
                          height: 33,
                          child: TextFormField(
                            focusNode: emailFocus,
                            autofocus: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter phone Number';
                              }
                              if (_phoneController.text.length < 9) {
                                return 'Please Enter Right Phone Number';
                              }
                            },
                            controller: _phoneController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                                color: colorBlack,
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                            decoration: InputDecoration(
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
                          height: 40,
                        ),
                        Text("Enter New Password",
                            style: TextStyle(
                                color: colorGrey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400)),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: double.infinity,
                          height: 33,
                          child: TextFormField(
                            autofocus: true,
                            obscureText: isPasswordNew,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Password';
                              }
                              if (_new1Controller.text.length < 8) {
                                return 'Please Enter 8 Digits Password';
                              }
                            },
                            controller: _new1Controller,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                                color: colorBlack,
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: isPasswordNew
                                    ? Icon(
                                        Icons.visibility,
                                        color: Colors.black,
                                      )
                                    : Icon(Icons.visibility_off,
                                        color: Colors.black),
                                onPressed: () {
                                  setState(() {
                                    isPasswordNew = !isPasswordNew;
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
                          height: 39,
                        ),
                        Text("Enter New Password",
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Password';
                              }
                              if (_new2Controller.text.length < 8) {
                                return 'Please Enter 8 Digits Password';
                              }
                              // if(value!=_new1Controller){
                              //   return 'Please Enter Same password';
                              //
                              // }
                            },
                            controller: _new2Controller,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
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
                          height: 19,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Other Option?",
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        InkWell(
                          onTap: () {
                            if (loginScreenKey.currentState!.validate()) {
                              if (_new1Controller.text ==
                                  _new2Controller.text) {
                                changePass();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Please Enter Same Passwred"),
                                  ),
                                );
                              }
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
                              "DONE",
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

  changePass() async {
    Database db = await DatabaseUtils.db.database;
    final result = await db.rawQuery(
        "SELECT * FROM logindata WHERE email=? AND phone=? ",
        [email.toString(), _phoneController.text]);
    if (result.isNotEmpty) {
      UserLoginModal userLoginModal = UserLoginModal();
      userLoginModal
        ..password = _new1Controller.text
        ..email = email.toString();
      await DatabaseUtils.db.updatePassword(userLoginModal);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Your Password Update."),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Wrong Phone Number."),
        ),
      );
    }
  }
}
