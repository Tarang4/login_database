import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_database/database/database_utils.dart';
import 'package:login_database/screen/profile_screen.dart';
import 'package:login_database/widgets/app_colors.dart';

import '../user_modal.dart';

class UpaDateScreen extends StatefulWidget {
  final String fName;
  final String lName;
  final String eMail;
  final String password;

  const UpaDateScreen(
      {Key? key,
      required this.fName,
      required this.lName,
      required this.eMail,
      required this.password})
      : super(key: key);

  @override
  _UpadateScreenState createState() => _UpadateScreenState();
}

class _UpadateScreenState extends State<UpaDateScreen> {
  String? photo;
  int? isGender;
  String? fName;
  String? lName;
  String? eMail;
  String? password;

  final ImagePicker _imagePicker = ImagePicker();
  final updateScreenKey = GlobalKey<FormState>();

  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
    fName = widget.fName;
    lName = widget.lName;
    eMail = widget.eMail;
    password = widget.password;
    _fNameController.text = fName!;
    _lNameController.text = lName!;
    _emailController.text = eMail!;
    _passwordController.text = password!;
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
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Form(
                key: updateScreenKey,
                child: Card(
                  elevation: 7,
                  shadowColor: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 14, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [ IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            size: 34,
                          )),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Profile Edit,",
                              style: TextStyle(
                                  fontSize: 30.0, fontWeight: FontWeight.w700),
                            ),
                            TextButton(
                              onPressed: () async {
                                updateData();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfileScreen()));
                              },
                              child: Text(
                                "Save",
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
                        InkWell(
                          onTap: () => openImageDialog(),
                          child: photo != null && photo!.isNotEmpty
                              ? Container(
                                  height: 100,
                                  width: 100,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(70),
                                  ),
                                  child: Image.file(
                                    File(photo ?? ""),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  height: 100,
                                  width: 100,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(70),
                                      color: Colors.grey.withOpacity(0.5)),
                                  child: const Icon(
                                    Icons.person,
                                    size: 45,
                                  ),
                                ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "First Name",
                          style: TextStyle(
                              fontSize: 14.0,
                              color: colorGrey,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 10,
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
                            onChanged: (nameVal) => setState(() {
                              var _fName = nameVal;
                            }),
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
                          height: 20,
                        ),
                        Text(
                          "Last Name",
                          style: TextStyle(
                              fontSize: 14.0,
                              color: colorGrey,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 10,
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
                          height: 20,
                        ),
                        Text("Email",
                            style: TextStyle(
                                color: colorGrey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400)),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: List.generate(
                              2,
                              (index) => InkWell(
                                    onTap: () {
                                      setState(() {
                                        isGender = index;
                                      });
                                    },
                                    child: Container(
                                      height: 30,
                                      alignment: Alignment.center,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                        width: 1,
                                        color: isGender == index
                                            ? colorGreen
                                            : colorGrey,
                                      )),
                                      margin: EdgeInsets.only(
                                          top: 10, right: 10, bottom: 10),
                                      child: Text(
                                          index == 0
                                              ? "Male"
                                              : index == 1
                                                  ? "Female"
                                                  : "Male",
                                          style: TextStyle(
                                              color: isGender == index
                                                  ? colorBlack
                                                  : colorGrey,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                  )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Mobile Number",
                            style: TextStyle(
                                color: colorGrey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400)),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          height: 33,
                          child: TextFormField(
                            controller: _phoneController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
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
                          height: 20,
                        ),

                        Text("Email",
                            style: TextStyle(
                                color: colorGrey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400)),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          height: 33,
                          child: TextFormField(
                            focusNode: emailFocus,
                            readOnly: true,
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
                          height: 20,
                        ),
                        Text("Password",
                            style: TextStyle(
                                color: colorGrey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400)),
                        const SizedBox(
                          height: 10,
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
                          height: 20,
                        ),
                        const Text("Address",
                            style: TextStyle(
                                color: colorGrey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400)),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          height: 33,
                          child: TextFormField(
                            controller: _addressController,
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
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("city",
                                      style: TextStyle(
                                          color: colorGrey,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 33,
                                    child: TextFormField(
                                      controller: _cityController,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      cursorColor: Colors.black,
                                      style: const TextStyle(
                                          color: colorBlack,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal),
                                      decoration: const InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: colorGreen),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: colorGreen),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                width: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Pin Code",
                                        style: TextStyle(
                                            color: colorGrey,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 33,
                                      child: TextFormField(
                                        controller: _pinCodeController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.number,
                                        cursorColor: Colors.black,
                                        style: const TextStyle(
                                            color: colorBlack,
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal),
                                        decoration: const InputDecoration(
                                          border: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: colorGreen),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: colorGreen),
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

                        const SizedBox(
                          height: 20,
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     if (updateScreenKey.currentState!.validate()) {
                        //
                        //     }
                        //   },
                        //   child: Container(
                        //     height: 50,
                        //     width: MediaQuery.of(context).size.height,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(4),
                        //       color: colorGreen,
                        //     ),
                        //     alignment: Alignment.center,
                        //     child: Text(
                        //       "SIGN IN",
                        //       style: TextStyle(
                        //           color: colorWhite,
                        //           fontSize: 14.0,
                        //           fontWeight: FontWeight.w400),
                        //     ),
                        //   ),
                        // )
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

  openImageDialog() {
    return showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            title: Text(
              "select",
              style: TextStyle(fontSize: 25),
            ),
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  getIamge(ImageSource.camera);
                },
                child: const Text('camera'),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  getIamge(ImageSource.gallery);
                },
                child: const Text('gallery'),
              ),
              CupertinoActionSheetAction(
                onPressed: () async {
                  Navigator.pop(context);
                  photo = (await _imagePicker.pickImage(
                      source: ImageSource.gallery)) as String?;
                },
                child: const Text('close'),
              ),
            ],
          );
        });
  }

  getIamge(ImageSource imageSource) async {
    final getIamge = await _imagePicker.pickImage(source: imageSource);
    setState(() {
      photo = getIamge?.path;
    });
  }

  updateData() async {
    UserLoginModal loginModal = UserLoginModal();
    loginModal
      ..fName = _fNameController.text
      ..lName = _lNameController.text
      ..email = _emailController.text
      ..imgDp = photo.toString()
      ..phone = int.parse(_phoneController.text)
      ..gender = int.parse(isGender.toString())
      ..address = _addressController.text
      ..city = _cityController.text
      ..pinCode = int.parse(_pinCodeController.text);
    return await DatabaseUtils.db.upDateData(loginModal);
  }
}
