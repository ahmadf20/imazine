import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:imazine/screens/home_screen.dart';
import 'package:imazine/utils/config.dart';
import 'package:imazine/utils/theme_manager.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting("id_ID", null).then(
    (_) => runApp(
      GetMaterialApp(
        title: 'Imazine App',
        debugShowCheckedModeBanner: false,
        builder: (context, child) => ScrollConfiguration(
          behavior: MyScrollBehaviour(),
          child: child,
        ),
        theme: ThemeData.light().copyWith(
          primaryColor: Colors.amber,
          accentColor: Colors.grey,
        ),
        darkTheme: ThemeData.dark().copyWith(
          primaryColor: Colors.amber,
          accentColor: Colors.grey,
        ),
        themeMode: ThemeMode.system,
        // theme: ThemeData(
        //   cardColor: Colors.white,
        //   appBarTheme: AppBarTheme(
        //     color: Colors.white,
        //   ),
        //   canvasColor: Colors.white,
        //   primaryColor: Colors.amber,
        //   accentColor: Colors.grey[100],
        // ),
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initializeTheme() async {
    await getTheme();
  }

  @override
  void initState() {
    super.initState();
    initializeTheme();
  }

  @override
  Widget build(BuildContext context) {
    if (ThemeMode.system == ThemeMode.dark) globalTheme = GlobalTheme.dark;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //       systemNavigationBarColor: Colors.grey[50], // navigation bar color
    //       systemNavigationBarDividerColor: Colors.black26,
    //       systemNavigationBarIconBrightness: Brightness.dark,
    //       statusBarIconBrightness: Brightness.dark,
    //       statusBarColor: Colors.transparent // status bar color
    //       ),
    // );

    return HomeScreen();
  }
}
