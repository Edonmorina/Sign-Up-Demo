import 'package:flutter/material.dart';
import './constants.dart';

class SignUpTextFields extends StatefulWidget {
  const SignUpTextFields({
    Key? key,
    required this.fieldController,
    required this.keyboardType,
    required this.obscureText,
    required this.hintText,
    required this.isRequired,
    required this.icon,
    this.textInputDone = false,
    this.autoFocus = false,
    required this.thisFocusNode,
    required this.requestNextFocus,
  }) : super(key: key);

  final TextEditingController fieldController;
  final TextInputType keyboardType;
  final bool obscureText;
  final String hintText;
  final bool isRequired;
  final IconData icon;
  final bool textInputDone;
  final FocusNode thisFocusNode;
  final FocusNode? requestNextFocus;
  final bool autoFocus;

  @override
  State<SignUpTextFields> createState() => _SignUpTextFieldsState();
}

class _SignUpTextFieldsState extends State<SignUpTextFields> {
  bool _isFieldValid = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: (size.width * 7.5) / 100),
      child: TextFormField(
        controller: widget.fieldController,
        onChanged: (value) {
          if (value.trim() != "" || value.isNotEmpty) {
            setState(() {
              _isFieldValid = true;
            });
          }
          if (value.trim() == "" || value.isEmpty) {
            setState(() {
              _isFieldValid = false;
            });
          }
        },
        textAlign: TextAlign.start,
        style: kTextFieldStyle,
        cursorWidth: 3.0,
        obscureText: widget.obscureText,
        textInputAction:
            widget.textInputDone ? TextInputAction.done : TextInputAction.next,
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(widget.requestNextFocus);
        },
        focusNode: widget.thisFocusNode,
        autofocus: widget.autoFocus,
        textAlignVertical: const TextAlignVertical(y: -0.25),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: !widget.isRequired
                      ? kNotRequiredHintColor
                      : _isFieldValid
                          ? kValidColor
                          : kNotValidColor,
                  width: 2)),
          hintText: widget.hintText,
          fillColor: Colors.white,
          hintStyle: kTextHintStyle,
          helperText: widget.isRequired ? "Required*" : "(Optional)",
          prefixIcon: Icon(
            widget.icon,
            color: const Color.fromARGB(255, 0, 0, 0),
            size: 35,
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 50),
          helperStyle: !widget.isRequired
              ? kNotRequiredHintStyle
              : _isFieldValid
                  ? kRequiredValidHintStyle
                  : kRequiredNotValidHintStyle,
        ),
      ),
    );
  }
}
