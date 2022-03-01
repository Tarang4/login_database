import 'dart:io';

import 'package:flutter/material.dart';
import 'package:login_database/database/database_utils.dart';
import 'package:login_database/screen/change_password.dart';
import 'package:login_database/screen/update_screen.dart';
import 'package:login_database/user_modal.dart';
import 'package:login_database/widgets/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late SharedPreferences prefs;
  String emailSd = '';

  String passwordSd = '';


  delete() async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    prefs.remove('password');
    setState(() {});
  }

  retrieve() async {
    prefs = await SharedPreferences.getInstance();
    emailSd = prefs.getString('email')!;
    passwordSd = prefs.getString('password')!;
    setState(() {});
  }

  List<UserLoginModal> listModal = [];

  getData() async {
    List<UserLoginModal> modalList = await DatabaseUtils.db.getData();
    setState(() {
      listModal = modalList;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(appBar: AppBar(
        title: Text("Home page"),
        actions: [
          IconButton(
              onPressed: () {
                retrieve();
              },
              icon: Icon(Icons.slideshow)),
          IconButton(
              onPressed: () {
                delete();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              icon: Icon(Icons.logout)),
        ],
      ),
        body: SingleChildScrollView(


          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listModal.length,
              itemBuilder: (BuildContext context, int index) {
                UserLoginModal userLoginModal = listModal[index];
                String photo = userLoginModal.imgDp.toString();
                String phone = userLoginModal.phone.toString();
                String address = userLoginModal.address.toString();
                String gender = userLoginModal.gender.toString();
                String pinCode = userLoginModal.pinCode.toString();
                String city = userLoginModal.city.toString();
                return Card(
                  elevation: 6.5,
                  margin: EdgeInsets.only(bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${emailSd}        and       ${passwordSd}",
                          style: TextStyle(
                              fontSize: 10.0, fontWeight: FontWeight.w700,color: colorBlack),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Text(
                              "user ${userLoginModal.id} ",
                              style: TextStyle(
                                  fontSize: 30.0, fontWeight: FontWeight.w700),
                            ),
                            TextButton(
                                onPressed: () {
                                  DatabaseUtils.db.deleteData(
                                      id: userLoginModal.id!.toInt());

                                  getData();
                                },
                                child: Text("Delete")),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChangePassword(
                                                email: userLoginModal.email
                                                    .toString(),
                                              )));
                                },
                                child: Text("change")),
                            SizedBox(
                              height: 0,
                            ),
                            TextButton(
                              onPressed: () {

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpaDateScreen(id: userLoginModal.id!.toInt(),


                                    ),
                                  ),
                                );
                              },
                              child: phone == "null" &&
                                      address == "null" &&
                                      pinCode == "null" &&
                                      city == "null" &&
                                      gender == "null" &&
                                      photo == "null"
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text("Update"),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        CircleAvatar(
                                          radius: 2,
                                          backgroundColor: Colors.red,
                                        )
                                      ],
                                    )
                                  : Text("Update"),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 90,
                              width: 90,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: colorLightGrey,
                                borderRadius: BorderRadius.circular(70),
                              ),
                              child: photo == "null"
                                  ? Icon(
                                      Icons.person,
                                      size: 36,
                                    )
                                  : Image.file(
                                      File(photo),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "First name",
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: colorBlack,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${userLoginModal.fName.toString()} ",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Last Name",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: colorBlack,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${userLoginModal.lName.toString()} ",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Phone Number",
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: colorBlack,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  phone == "null"
                                      ? "-"
                                      : "+91 ${userLoginModal.phone.toString()} ",
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 14.0,
                              color: colorGrey,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${userLoginModal.email.toString()} ",
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Password",
                          style: TextStyle(
                              fontSize: 14.0,
                              color: colorGrey,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${userLoginModal.password.toString()} ",
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Address",
                          style: TextStyle(
                              fontSize: 14.0,
                              color: colorGrey,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          address == "null" &&
                                  city == "null" &&
                                  pinCode == "null"
                              ? "-"
                              : "${userLoginModal.address.toString()}, ${userLoginModal.city.toString()}, ${userLoginModal.pinCode.toString()} ",
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Gender",
                          style: TextStyle(
                              fontSize: 14.0,
                              color: colorGrey,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          gender == "null"
                              ? "-"
                              : "${userLoginModal.gender.toString()}",
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
