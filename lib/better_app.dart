import 'package:find_better_app/home_page.dart';
import 'package:find_better_app/splash_page.dart';
import 'package:flutter/material.dart';

class BetterApp extends StatelessWidget {
  const BetterApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      routes: <String, WidgetBuilder>{
        "/": (context) => const SplashPage(),
        "/home": (context) => const HomePage(),
      },
      initialRoute: "/home",
    );
  }
}
