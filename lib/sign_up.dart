import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sign_up/text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _firstStreetAddress = TextEditingController();
  final TextEditingController _secondStreetAddress = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _zip = TextEditingController();

  final String _firstNameLabelText = "First Name";
  final String _lastNameLabelText = "Last Name";
  final String _firstStreetAddressLabelText = "Street Address 1";
  final String _secondStreetAddressLabelText = "Street Address 2";
  final String _stateLabelText = "State";
  final String _cityLabelText = "City";
  final String _zipLabelText = "Zip";

  bool _isValidFirstName = false;
  bool _isValidLastName = false;
  bool _isValidFirstStreetAddress = false;
  bool _isValidCity = false;
  bool _isValidState = false;
  bool _isValidZip = false;

  bool _isFormValid() {
    if (!_isValidFirstName) return false;
    if (!_isValidLastName) return false;
    if (!_isValidFirstStreetAddress) return false;
    if (!_isValidCity) return false;
    if (!_isValidState) return false;
    if (!_isValidZip) return false;
    return true;
  }

  void _changeValidationStateIfInputIsEmpty() {
    setState(() {
      _firstName.text.isEmpty
          ? _isValidFirstName = false
          : _isValidFirstName = true;
      _lastName.text.isEmpty
          ? _isValidLastName = false
          : _isValidLastName = true;
      _firstStreetAddress.text.isEmpty
          ? _isValidFirstStreetAddress = false
          : _isValidFirstStreetAddress = true;
      _city.text.isEmpty ? _isValidCity = false : _isValidCity = true;
      _state.text.isEmpty ? _isValidState = false : _isValidState = true;
      _zip.text.isEmpty ? _isValidZip = false : _isValidZip = true;
    });
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _firstStreetAddress.dispose();
    _secondStreetAddress.dispose();
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
          color: Colors.blue[50],
          child: Padding(
            padding: EdgeInsets.only(top: size.height / 20),
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 25),
                  child: const Text(
                    "Sign Up",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 45),
                  ),
                ),
                SignUpTextFields(
                  key: Key(_firstNameLabelText),
                  fieldController: _firstName,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  labelText: _firstNameLabelText,
                  isRequired: true,
                  icon: const Icon(Icons.person),
                ),
                SignUpTextFields(
                  key: Key(_lastNameLabelText),
                  fieldController: _lastName,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  labelText: _lastNameLabelText,
                  isRequired: true,
                  icon: const Icon(Icons.person_outline_rounded),
                ),
                SignUpTextFields(
                  fieldController: _firstStreetAddress,
                  keyboardType: TextInputType.streetAddress,
                  obscureText: false,
                  labelText: _firstStreetAddressLabelText,
                  isRequired: true,
                  icon: const Icon(Icons.house_outlined),
                ),
                SignUpTextFields(
                    fieldController: _secondStreetAddress,
                    keyboardType: TextInputType.streetAddress,
                    obscureText: false,
                    labelText: _secondStreetAddressLabelText,
                    isRequired: false,
                    icon: const Icon(Icons.house_rounded)),
                SignUpTextFields(
                    fieldController: _city,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    labelText: _cityLabelText,
                    isRequired: true,
                    icon: const Icon(Icons.location_city_outlined)),
                SignUpTextFields(
                    fieldController: _state,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    labelText: _stateLabelText,
                    isRequired: true,
                    icon: const Icon(Icons.location_on_outlined)),
                SignUpTextFields(
                    fieldController: _zip,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    labelText: _zipLabelText,
                    isRequired: true,
                    icon: const Icon(Icons.local_post_office_outlined)),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width / 5),
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          _changeValidationStateIfInputIsEmpty();

                          if (_isFormValid()) {
                            // ignore: avoid_print
                            print("Form is valid");
                          } else {
                            // ignore: avoid_print
                            print("Form not valid");
                          }
                        },
                        child: const Text("Sign Up"),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue))),
                  ),
                ),
                const SizedBox(
                  height: 185,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
