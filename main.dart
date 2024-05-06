import 'package:flutter/material.dart';
import 'package:untitled/HomeScreen.dart';
import 'package:untitled/LogIn/Login.dart';
import 'package:untitled/Registration/Registration.dart';

void main() {
  runApp(const Task());
}

class Task extends StatelessWidget {
  const Task({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Registration.id,//routing.
      routes: {
        Registration.id:(context)=>Registration(),
        LogIn.id:(context)=>LogIn(),
        HomeScreen.id:(context)=>HomeScreen()

      },
    );
  }
}
