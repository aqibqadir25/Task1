import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller; // Add controller here

  const PasswordTextField({
    Key? key,
    required this.hintText,
    required this.controller, // Add this line
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller, // Use controller here
        onChanged: (value) {
          // Do something with the user input.
        },
        keyboardType: TextInputType.visiblePassword,
        maxLength: 12,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Color(0xFFAFACA5)),
          counterText: "",
          suffixIcon: Icon(
            Icons.remove_red_eye,
            color: Colors.black,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller; // Add controller here

  const EmailTextField({
    Key? key,
    required this.hintText,
    required this.controller, // Add this line
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller, // Use controller here
        onChanged: (value) {
          // Do something with the user input.
        },
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Color(0xFFAFACA5)),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
    );
  }
}
