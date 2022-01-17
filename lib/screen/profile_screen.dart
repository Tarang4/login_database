import 'dart:io';

import 'package:flutter/material.dart';
import 'package:login_database/database/database_utils.dart';
import 'package:login_database/screen/update_screen.dart';
import 'package:login_database/user_modal.dart';
import 'package:login_database/widgets/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? photo;

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
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listModal.length,
              itemBuilder: (BuildContext context, int index) {
                UserLoginModal userLoginModal = listModal[index];

                return Card(
                  elevation: 6.5,
                  margin: EdgeInsets.only(bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            SizedBox(
                              height: 20,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UpaDateScreen(
                                                fName: userLoginModal.fName
                                                    .toString(),
                                                lName: userLoginModal.lName
                                                    .toString(),
                                                password: userLoginModal
                                                    .password
                                                    .toString(),
                                                eMail: userLoginModal.email
                                                    .toString(),
                                              )));
                                },
                                child: Text("Update")),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            InkWell(
                              child: photo != null && photo!.isNotEmpty
                                  ? Container(
                                      height: 90,
                                      width: 90,
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
                                      height: 90,
                                      width: 90,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(70),
                                          color: Colors.grey.withOpacity(0.5)),
                                      child: const Icon(
                                        Icons.person,
                                        size: 45,
                                      ),
                                    ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                const SizedBox(
                                  height: 15,
                                ),
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
