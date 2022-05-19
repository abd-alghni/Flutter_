import 'dart:async';

import 'package:flutter/material.dart';
import 'package:note_lab/Widgets/CustomText.dart';
import '../../Helpers/colors.dart';
import '../Home/Home.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), () async {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => Home()),
          (Route<dynamic> route) => false);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var _body = Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 15),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Center(
          child: Container(
            height: size.height * 0.65,
            width: size.width * 0.95,
            child: Image.asset(
              'assets/note.png',
              color: colors.primarycolor,
            ),
          ),
        ),
        Container(
            height: size.height * 0.17,
            width: size.width * 0.12,
            child: CustomText(
              title: "Note App",
            )),
      ]),
    );
    return Scaffold(
      body: _body,
    );
  }
}
