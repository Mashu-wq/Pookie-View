import 'package:flutter/material.dart';
import 'package:pookieview/constant/colors.dart';
import 'package:pookieview/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,

        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: const AppBarTheme(
            backgroundColor: primaryColor,
            //foregroundColor: Colors.black,
            elevation: 0),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
