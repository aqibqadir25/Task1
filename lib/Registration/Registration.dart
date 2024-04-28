import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:untitled/LogIn/Login.dart';
import '../Buttons/Buttons.dart';
import '../TextFields/TextFields.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});
  static const String id = 'Registration';
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? errorMessage;

  Future<void> registerUser(String email, String password) async {
    try {
      final response = await post(
        Uri.parse("http://localhost:8080/login"),
        body: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        Navigator.popAndPushNamed(context, LogIn.id);
      } else {
        setState(() {
          errorMessage = "Registration failed. Please try again.";
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = "Error occurred: $error";
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Text(
                    'Registration',
                    style: TextStyle(
                      fontSize: 38.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ],
          ),
          EmailTextField(
              controller: emailController,
              hintText: 'Enter your email address'),
          PasswordTextField(
              controller: passwordController, hintText: 'Enter your password'),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              text: 'Register User',
              onPressed: () {
                registerUser(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                );
              },
            ),
          ),
          if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                errorMessage!,
                style:const  TextStyle(color: Colors.red),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account?",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, LogIn.id);
                },
                child: Text("SignIn"),
              )
            ],
          ),
        ],
      ),
    );
  }
}