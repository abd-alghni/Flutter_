import 'package:flutter/material.dart';
import 'package:note_lab/Helpers/colors.dart';
import 'package:note_lab/Helpers/data.dart';
import 'package:note_lab/Views/Splash/SplashSrceen.dart';
import 'Views/Welcome/Welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Widget? homeview =
      await data.getData('welcome') != '' ? SplashScreen() : Welcome();
  runApp(MyApp(homeview));
}

class MyApp extends StatelessWidget {
  Widget? homeview;
  MyApp(this.homeview);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primaryColor: colors.primarycolor,
      ),
      home: homeview,
    );
  }
}
