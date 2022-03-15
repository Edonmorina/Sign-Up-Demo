import 'package:flutter/material.dart';

class SignUpTextFields extends StatelessWidget {
  const SignUpTextFields(
      {Key? key,
      required this.fieldController,
      required this.keyboardType,
      required this.obscureText,
      required this.labelText})
      : super(key: key);

  final TextEditingController fieldController;
  final TextInputType keyboardType;
  final bool obscureText;
  final String labelText;

  final kTextFieldStyle = const TextStyle(fontSize: 20, fontFamily: 'Roboto');

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      style: kTextFieldStyle,
      cursorWidth: 3.0,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        labelText: labelText,
        labelStyle: kTextFieldStyle,
        floatingLabelStyle: const TextStyle(color: Colors.black, fontSize: 20),
      ),
    );
  }
}
