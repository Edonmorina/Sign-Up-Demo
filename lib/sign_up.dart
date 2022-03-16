import 'package:flutter/material.dart';
import 'package:sign_up/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter_svg/svg.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  void initState() {
    _focusFirstName = FocusNode();
    _focusLastName = FocusNode();
    _focusStreetAddress1 = FocusNode();
    _focusStreetAddress2 = FocusNode();
    _focusCity = FocusNode();
    _focusState = FocusNode();
    _focusZip = FocusNode();
    _focusScreen = FocusNode();
    _focusDatePicker = FocusNode();
    super.initState();
  }

  late FocusNode _focusFirstName;
  late FocusNode _focusLastName;
  late FocusNode _focusDatePicker;
  late FocusNode _focusStreetAddress1;
  late FocusNode _focusStreetAddress2;
  late FocusNode _focusCity;
  late FocusNode _focusState;
  late FocusNode _focusZip;
  late FocusNode _focusScreen;

  final GlobalKey _firstNameKey = GlobalKey();
  final GlobalKey _lastNameKey = GlobalKey();
  final GlobalKey _dateKey = GlobalKey();
  final GlobalKey _firstStreetAddressKey = GlobalKey();
  final GlobalKey _secondStreetAddressKey = GlobalKey();
  final GlobalKey _cityKey = GlobalKey();
  final GlobalKey _stateKey = GlobalKey();
  final GlobalKey _zipKey = GlobalKey();

  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _firstStreetAddress = TextEditingController();
  final TextEditingController _secondStreetAddress = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _zip = TextEditingController();

  final String _firstNamHintText = "First Name";
  final String _lastNamHintText = "Last Name";
  final String _firstStreetAddresHintText = "Street Address 1";
  final String _secondStreetAddresHintText = "Street Address 2";
  final String _stateHintText = "State";
  final String _cityHintText = "City";
  final String _zipHintText = "Zip";

  String _selectedDate = "";

  bool _isValidFirstName = false;
  bool _isValidLastName = false;
  bool _isValidDate = false;
  bool _isValidFirstStreetAddress = false;
  bool _isValidCity = false;
  bool _isValidState = false;
  bool _isValidZip = false;

  bool _isFormValid() {
    if (!_isValidFirstName) return false;
    if (!_isValidLastName) return false;
    if (!_isValidDate) return false;
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

  // Dispose Functions
  void _disposeTextEditingControllers() {
    _firstName.dispose();
    _lastName.dispose();
    _firstStreetAddress.dispose();
    _secondStreetAddress.dispose();
    _city.dispose();
    _state.dispose();
    _zip.dispose();
  }

  void _disposeFocusNodes() {
    _focusFirstName.dispose();
    _focusLastName.dispose();
    _focusStreetAddress1.dispose();
    _focusStreetAddress2.dispose();
    _focusCity.dispose();
    _focusState.dispose();
    _focusZip.dispose();
    _focusScreen.dispose();
    _focusDatePicker.dispose();
  }

  @override
  void dispose() {
    _disposeTextEditingControllers();
    _disposeFocusNodes();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CollectionReference users = FirebaseFirestore.instance.collection("users");

    void _addUser() {
      // Add Users to [Firestore] (Firebase database)
      users.add({
        'firstName': _firstName.text,
        'lastName': _lastName.text,
        'birthDate': _selectedDate,
        'firstStreetAddress': _firstStreetAddress.text,
        'secondStreetAddress': _secondStreetAddress.text,
        'city': _city.text,
        'state': _state.text,
        'zip': _zip.text
      });
    }

    void _clearTextFieldsAndResetValidation() {
      setState(() {
        _firstName.text = "";
        _lastName.text = "";
        _selectedDate = "";
        _firstStreetAddress.text = "";
        _secondStreetAddress.text = "";
        _city.text = "";
        _state.text = "";
        _zip.text = "";

        _isValidFirstName = false;
        _isValidLastName = false;
        _isValidDate = false;
        _isValidFirstStreetAddress = false;
        _isValidCity = false;
        _isValidState = false;
        _isValidZip = false;
      });
    }

    void _redirectScopeIfFieldIsInvalidOnSubmission() {
      if (!_isValidFirstName) {
        Scrollable.ensureVisible(_firstNameKey.currentContext ?? context);
        FocusScope.of(context).requestFocus(_focusFirstName);
      } else if (!_isValidLastName) {
        Scrollable.ensureVisible(_lastNameKey.currentContext ?? context);
        FocusScope.of(context).requestFocus(_focusLastName);
      } else if (!_isValidDate) {
        Scrollable.ensureVisible(_dateKey.currentContext ?? context);
        FocusScope.of(context).requestFocus(_focusDatePicker);
      } else if (!_isValidFirstStreetAddress) {
        Scrollable.ensureVisible(
            _firstStreetAddressKey.currentContext ?? context);
        FocusScope.of(context).requestFocus(_focusStreetAddress1);
      } else if (!_isValidCity) {
        Scrollable.ensureVisible(_cityKey.currentContext ?? context);
        FocusScope.of(context).requestFocus(_focusCity);
      } else if (!_isValidState) {
        Scrollable.ensureVisible(_stateKey.currentContext ?? context);
        FocusScope.of(context).requestFocus(_focusState);
      } else if (!_isValidZip) {
        Scrollable.ensureVisible(_zipKey.currentContext ?? context);
        FocusScope.of(context).requestFocus(_focusZip);
      }
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(_focusScreen);
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: size.height / 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 50),
                  child: const Text(
                    "Sign Up",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 45,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 5,
                    ),
                  ),
                ),
                SignUpTextFields(
                  key: _firstNameKey,
                  fieldController: _firstName,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  hintText: _firstNamHintText,
                  isRequired: true,
                  icon: const Icon(Icons.person),
                  thisFocusNode: _focusFirstName,
                  requestNextFocus: _focusLastName,
                  autoFocus: true,
                ),
                SignUpTextFields(
                  key: _lastNameKey,
                  fieldController: _lastName,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  hintText: _lastNamHintText,
                  isRequired: true,
                  icon: const Icon(Icons.person_outline_rounded),
                  thisFocusNode: _focusLastName,
                  requestNextFocus: _focusDatePicker,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  padding: EdgeInsets.symmetric(horizontal: size.width / 12),
                  child: DateTimePicker(
                    key: _dateKey,
                    initialValue: _selectedDate,
                    firstDate: DateTime(1930),
                    lastDate: DateTime(2023),
                    dateLabelText: "Birth date",
                    textAlign: TextAlign.start,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_focusStreetAddress1);
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.date_range_outlined),
                        helperText: "Required*",
                        helperStyle: _isValidDate
                            ? TextStyle(color: Colors.green[700])
                            : const TextStyle(color: Colors.red)),
                    onChanged: (val) => {
                      _selectedDate = val,
                      if (val.isNotEmpty && val != "")
                        {_isValidDate = true}
                      else if (val.isEmpty || val == "")
                        {_isValidDate = false}
                    },
                  ),
                ),
                SignUpTextFields(
                  key: _firstStreetAddressKey,
                  fieldController: _firstStreetAddress,
                  keyboardType: TextInputType.streetAddress,
                  obscureText: false,
                  hintText: _firstStreetAddresHintText,
                  isRequired: true,
                  icon: const Icon(Icons.house_outlined),
                  thisFocusNode: _focusStreetAddress1,
                  requestNextFocus: _focusStreetAddress2,
                ),
                SignUpTextFields(
                  key: _secondStreetAddressKey,
                  fieldController: _secondStreetAddress,
                  keyboardType: TextInputType.streetAddress,
                  obscureText: false,
                  hintText: _secondStreetAddresHintText,
                  isRequired: false,
                  icon: const Icon(Icons.house_rounded),
                  thisFocusNode: _focusStreetAddress2,
                  requestNextFocus: _focusCity,
                ),
                SignUpTextFields(
                  key: _cityKey,
                  fieldController: _city,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  hintText: _cityHintText,
                  isRequired: true,
                  icon: const Icon(Icons.location_city_outlined),
                  thisFocusNode: _focusCity,
                  requestNextFocus: _focusState,
                ),
                SignUpTextFields(
                  key: _stateKey,
                  fieldController: _state,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  hintText: _stateHintText,
                  isRequired: true,
                  icon: const Icon(Icons.location_on_outlined),
                  thisFocusNode: _focusState,
                  requestNextFocus: _focusZip,
                ),
                SignUpTextFields(
                  key: _zipKey,
                  fieldController: _zip,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  hintText: _zipHintText,
                  isRequired: true,
                  icon: const Icon(Icons.local_post_office_outlined),
                  textInputDone: true,
                  thisFocusNode: _focusZip,
                  requestNextFocus: null,
                ),
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
                            _addUser();
                            _clearTextFieldsAndResetValidation();
                          } else {
                            _redirectScopeIfFieldIsInvalidOnSubmission();
                          }
                        },
                        child: const Text("Sign Up"),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.black))),
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
