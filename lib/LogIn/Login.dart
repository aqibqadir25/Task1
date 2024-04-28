import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:untitled/Registration/Registration.dart';
import '../Buttons/Buttons.dart';
import '../HomeScreen.dart';
import '../TextFields/TextFields.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});
  static const String id = 'LogIn';

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
   TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();
   String? errorMessage;

   Future<void> loginUser(String email, String password) async {
     try {
       final response = await post(
         Uri.parse("http://localhost:8080/login"),
         body: {'email': email, 'password': password},
       );
       if (response.statusCode == 200) {
         Navigator.popAndPushNamed(context, HomeScreen.id);
       } else {
         setState(() {
           errorMessage = "Invalid email or password. Please try again.";
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
                     '   Welcome! please Enter\n your email and password',
                     style: TextStyle(
                       fontSize: 30.0,
                       fontWeight: FontWeight.w900,
                     ),
                   ),
                 ),
               ),
             ],
           ),
           EmailTextField(
             controller: emailController,
             hintText: 'Enter your email address',
           ),
           PasswordTextField(
             controller: passwordController,
             hintText: 'Enter your password',
           ),
           const SizedBox(height: 10),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: CustomButton(
               text: 'LogIn',
               onPressed: () {
                 loginUser(
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
                 style: TextStyle(color: Colors.red),
               ),
             ),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               const Text(
                 "Do you want to create your account?",
                 style: TextStyle(decoration: TextDecoration.underline),
               ),
               TextButton(
                 onPressed: () {
                   Navigator.popAndPushNamed(context, Registration.id);
                 },
                 child: const Text("SignUp?"),
               ),
             ],
           ),
         ],
       ),
     );
   }
}
