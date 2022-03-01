import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_database/screen/main_screen.dart';
import 'package:login_database/screen/profile_screen.dart';
import 'package:login_database/widgets/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

String? finalEmail;

class SpleshScreen extends StatefulWidget {
  const SpleshScreen({Key? key}) : super(key: key);

  @override
  _SpleshScreenState createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getValidationData().whenComplete(() async {
      Timer(Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => finalEmail == null
                ? LoginScreen()
                : ProfileScreen()));
      });
    });
  }

  Future getValidationData() async {
    final SharedPreferences prefe = await SharedPreferences.getInstance();
    var obtained = prefe.getString('email');
    setState(() {
      finalEmail = obtained;
    });
    print(finalEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.black,
          child: Center(
              child: Icon(Icons.wb_sunny,size: 100,color: colorWhite,)),
        ));
  }
}
