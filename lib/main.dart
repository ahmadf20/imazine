import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:imazine/screens/home_screen.dart';
import 'package:imazine/utils/config.dart';

void main() => runApp(GetMaterialApp(home: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.grey[50], // navigation bar color
        systemNavigationBarDividerColor: Colors.black26,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent // status bar color
        ));

    return MaterialApp(
      title: 'Imazine App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      builder: (context, child) => ScrollConfiguration(
        behavior: MyScrollBehaviour(),
        child: child,
      ),
      home: HomeScreen(),
    );
  }
}
