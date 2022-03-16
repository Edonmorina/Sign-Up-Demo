import 'package:flutter/material.dart';

class SignUpTextFields extends StatefulWidget {
  const SignUpTextFields(
      {Key? key,
      required this.fieldController,
      required this.keyboardType,
      required this.obscureText,
      required this.labelText,
      required this.isRequired,
      required this.icon})
      : super(key: key);

  final TextEditingController fieldController;
  final TextInputType keyboardType;
  final bool obscureText;
  final String labelText;
  final bool isRequired;
  final Icon icon;

  @override
  State<SignUpTextFields> createState() => _SignUpTextFieldsState();
}

class _SignUpTextFieldsState extends State<SignUpTextFields> {
  final kTextFieldStyle = const TextStyle(fontSize: 20, fontFamily: 'Roboto');

  bool _isFieldValid = false;
  bool get getIsFieldValid => _isFieldValid;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: size.width / 12),
      child: TextFormField(
        controller: widget.fieldController,
        onChanged: (value) {
          if (value.isNotEmpty && value.length < 2) {
            setState(() {
              _isFieldValid = true;
            });
          } else if (value.isEmpty) {
            setState(() {
              _isFieldValid = false;
            });
          }
        },
        textAlign: TextAlign.start,
        style: kTextFieldStyle,
        cursorWidth: 3.0,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          hintText: widget.labelText,
          helperText: widget.isRequired ? "Required*" : "(Optional)",
          prefixIcon: widget.icon,
          prefixIconColor: Colors.red,
          prefixIconConstraints: const BoxConstraints(minWidth: 50),
          helperStyle: !widget.isRequired
              ? const TextStyle(color: Colors.grey)
              : _isFieldValid
                  ? TextStyle(color: Colors.green[700])
                  : const TextStyle(color: Colors.red),
          labelStyle: kTextFieldStyle,
          floatingLabelStyle:
              const TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }
}
