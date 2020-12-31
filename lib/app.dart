import 'package:flutter/material.dart';
import 'package:project1010/route_generator.dart';
// import 'screens/users/home.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project 1010',
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );

  }
}