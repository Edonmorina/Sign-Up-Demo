import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sign_up/text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _validateFirstName = false;
  bool _validateLastName = false;
  bool _validateFirstStreetAdress = false;
  bool _validateCity = false;
  bool _validateState = false;
  bool _validateZip = false;

  bool isFormValid() {
    if (_validateFirstName &&
        _validateLastName &&
        _validateFirstStreetAdress &&
        _validateCity &&
        _validateState &&
        _validateZip) {
      return true;
    }
    return false;
  }

  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _firstStreetAdress = TextEditingController();
  final TextEditingController _secondStreetAdress = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _zip = TextEditingController();

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _firstStreetAdress.dispose();
    _secondStreetAdress.dispose();
    _city.dispose();
    _state.dispose();
    _zip.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: size.width,
          height: size.height,
          color: Colors.blue[50],
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width / 14),
            child: Stack(
              children: [
                Align(
                  alignment: const Alignment(0, -0.75),
                  child: SignUpTextFields(
                      fieldController: _firstName,
                      keyboardType: TextInputType.name,
                      obscureText: false,
                      labelText: "First Name"),
                ),
                Align(
                  alignment: const Alignment(0, -0.55),
                  child: SignUpTextFields(
                      fieldController: _lastName,
                      keyboardType: TextInputType.name,
                      obscureText: false,
                      labelText: "Last Name"),
                ),
                Align(
                  alignment: const Alignment(0, -0.35),
                  child: SignUpTextFields(
                      fieldController: _firstStreetAdress,
                      keyboardType: TextInputType.streetAddress,
                      obscureText: false,
                      labelText: "Street Address 1"),
                ),
                Align(
                  alignment: const Alignment(0, -0.15),
                  child: SignUpTextFields(
                      fieldController: _secondStreetAdress,
                      keyboardType: TextInputType.streetAddress,
                      obscureText: false,
                      labelText: "Street Address 2"),
                ),
                Align(
                  alignment: const Alignment(0, 0.05),
                  child: SignUpTextFields(
                      fieldController: _state,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      labelText: "State"),
                ),
                Align(
                  alignment: const Alignment(0, 0.25),
                  child: SignUpTextFields(
                      fieldController: _city,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      labelText: "City"),
                ),
                Align(
                  alignment: const Alignment(0, 0.45),
                  child: SignUpTextFields(
                      fieldController: _zip,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      labelText: "Zip"),
                ),
                Align(
                  alignment: const Alignment(0, 0.75),
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _firstName.text.isEmpty
                              ? _validateFirstName = true
                              : _validateFirstName = false;
                          _lastName.text.isEmpty
                              ? _validateLastName = true
                              : _validateLastName = false;
                          _firstStreetAdress.text.isEmpty
                              ? _validateFirstStreetAdress = true
                              : _validateFirstStreetAdress = false;
                          _city.text.isEmpty
                              ? _validateCity = true
                              : _validateCity = false;
                          _state.text.isEmpty
                              ? _validateState = true
                              : _validateState = false;
                          _zip.text.isEmpty
                              ? _validateZip = true
                              : _validateZip = false;
                        });

                        if (isFormValid()) {
                          // ignore: avoid_print
                          print("Form is valid");
                        } else {
                          // ignore: avoid_print
                          print("Form not valid");
                        }
                      },
                      child: const Text("Submit"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
