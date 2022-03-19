import 'package:flutter/material.dart';
import './constants.dart';

class SignUpTextFields extends StatelessWidget {
  const SignUpTextFields(
      {Key? key,
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
      required this.fieldStateListener,
      required this.isItValid})
      : super(key: key);

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
  final bool? fieldStateListener;
  final void Function(bool) isItValid;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: (size.width * 7.5) / 100),
      child: TextFormField(
        controller: fieldController,
        onChanged: (value) {
          if (value.trim() != "" || value.isNotEmpty) {
            isItValid(true);
          }
          if (value.trim() == "" ||
              value.isEmpty ||
              value.trim().isEmpty ||
              value.length <= 1) {
            isItValid(false);
          }
        },
        textAlign: TextAlign.start,
        style: kTextFieldStyle,
        cursorWidth: 3.0,
        obscureText: obscureText,
        textInputAction:
            textInputDone ? TextInputAction.done : TextInputAction.next,
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(requestNextFocus);
        },
        focusNode: thisFocusNode,
        autofocus: autoFocus,
        textAlignVertical: const TextAlignVertical(y: -0.25),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: !isRequired
                      ? kNotRequiredHintColor
                      : fieldStateListener ?? false
                          ? kValidColor
                          : kNotValidColor,
                  width: 2)),
          hintText: hintText,
          fillColor: Colors.white,
          hintStyle: kTextHintStyle,
          helperText: isRequired ? "Required*" : "(Optional)",
          prefixIcon: Icon(
            icon,
            color: const Color.fromARGB(255, 0, 0, 0),
            size: 35,
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 50),
          helperStyle: !isRequired
              ? kNotRequiredHintStyle
              : fieldStateListener ?? false
                  ? kRequiredValidHintStyle
                  : kRequiredNotValidHintStyle,
        ),
      ),
    );
  }
}
