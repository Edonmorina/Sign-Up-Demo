import 'package:flutter/material.dart';
import 'package:sign_up/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'constants.dart';
import 'package:provider/provider.dart';
import 'package:sign_up/providers/sign_up_text_field_states.dart';

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

  late final FocusNode _focusFirstName;
  late final FocusNode _focusLastName;
  late final FocusNode _focusDatePicker;
  late final FocusNode _focusStreetAddress1;
  late final FocusNode _focusStreetAddress2;
  late final FocusNode _focusCity;
  late final FocusNode _focusState;
  late final FocusNode _focusZip;
  late final FocusNode _focusScreen;

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

  bool _dataIsGettingSend = false;

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

    Future<DocumentReference<Object?>> _addUser() {
      // Add Users to [Firestore] (Firebase database)
      return users.add({
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

    bool _isValidFirstName =
        context.watch<SignUpTextFieldStates>().isFirstNameValid;
    bool _isValidLastName =
        context.watch<SignUpTextFieldStates>().isLastNameValid;
    bool _isValidDate = context.watch<SignUpTextFieldStates>().isDateValid;
    bool _isValidFirstStreetAddress =
        context.watch<SignUpTextFieldStates>().isFirstStreetAddressValid;
    bool _isValidCity = context.watch<SignUpTextFieldStates>().isCityValid;
    bool _isValidState = context.watch<SignUpTextFieldStates>().isStateValid;
    bool _isValidZip = context.watch<SignUpTextFieldStates>().isZipValid;

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
      _firstName.text.length <= 1
          ? context.read<SignUpTextFieldStates>().setIsFirstNameValidTo(false)
          : context.read<SignUpTextFieldStates>().setIsFirstNameValidTo(true);
      _lastName.text.length <= 1
          ? context.read<SignUpTextFieldStates>().setIsLastNameValidTo(false)
          : context.read<SignUpTextFieldStates>().setIsLastNameValidTo(true);
      _firstStreetAddress.text.length <= 1
          ? context
              .read<SignUpTextFieldStates>()
              .setIsFirstStreetAddressValidTo(false)
          : context
              .read<SignUpTextFieldStates>()
              .setIsFirstStreetAddressValidTo(true);
      _city.text.length <= 1
          ? context.read<SignUpTextFieldStates>().setIsCityValid(false)
          : context.read<SignUpTextFieldStates>().setIsCityValid(true);
      _state.text.length <= 1
          ? context.read<SignUpTextFieldStates>().setIsStateValid(false)
          : context.read<SignUpTextFieldStates>().setIsStateValid(true);
      _zip.text.length <= 1
          ? context.read<SignUpTextFieldStates>().setIsZipValid(false)
          : context.read<SignUpTextFieldStates>().setIsZipValid(true);
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
      });
      context.read<SignUpTextFieldStates>().resetAllFields();
    }

    void _redirectScopeIfFieldIsInvalidOnSubmission() {
      if (!_isValidFirstName) {
        Scrollable.ensureVisible(_firstNameKey.currentContext ?? context,
            duration: const Duration(milliseconds: 750));
        FocusScope.of(context).requestFocus(_focusFirstName);
      } else if (!_isValidLastName) {
        Scrollable.ensureVisible(_lastNameKey.currentContext ?? context,
            duration: const Duration(milliseconds: 750));
        FocusScope.of(context).requestFocus(_focusLastName);
      } else if (!_isValidDate) {
        Scrollable.ensureVisible(_dateKey.currentContext ?? context,
            duration: const Duration(milliseconds: 750));
        FocusScope.of(context).requestFocus(_focusDatePicker);
      } else if (!_isValidFirstStreetAddress) {
        Scrollable.ensureVisible(
            _firstStreetAddressKey.currentContext ?? context,
            duration: const Duration(milliseconds: 750));
        FocusScope.of(context).requestFocus(_focusStreetAddress1);
      } else if (!_isValidCity) {
        Scrollable.ensureVisible(_cityKey.currentContext ?? context,
            duration: const Duration(milliseconds: 750));
        FocusScope.of(context).requestFocus(_focusCity);
      } else if (!_isValidState) {
        Scrollable.ensureVisible(_stateKey.currentContext ?? context,
            duration: const Duration(milliseconds: 750));
        FocusScope.of(context).requestFocus(_focusState);
      } else if (!_isValidZip) {
        Scrollable.ensureVisible(_zipKey.currentContext ?? context,
            duration: const Duration(milliseconds: 750));
        FocusScope.of(context).requestFocus(_focusZip);
      }
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(_focusScreen);
      },
      child: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg.png'), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: const Color.fromARGB(34, 136, 136, 136),
          body: SizedBox(
            width: size.width,
            height: size.height,
            child: Padding(
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
                          color: Colors.white,
                          fontSize: 45,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
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
                      icon: Icons.person_outline_rounded,
                      thisFocusNode: _focusFirstName,
                      requestNextFocus: _focusLastName,
                      autoFocus: true,
                      fieldStateListener: _isValidFirstName,
                      isItValid: (bool bool) => {
                        context
                            .read<SignUpTextFieldStates>()
                            .setIsFirstNameValidTo(bool)
                      },
                    ),
                    SignUpTextFields(
                      key: _lastNameKey,
                      fieldController: _lastName,
                      keyboardType: TextInputType.name,
                      obscureText: false,
                      hintText: _lastNamHintText,
                      isRequired: true,
                      icon: Icons.person,
                      thisFocusNode: _focusLastName,
                      requestNextFocus: _focusDatePicker,
                      fieldStateListener: _isValidLastName,
                      isItValid: (bool bool) => {
                        context
                            .read<SignUpTextFieldStates>()
                            .setIsLastNameValidTo(bool)
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width / 12),
                      child: DateTimePicker(
                        key: _dateKey,
                        initialValue: _selectedDate,
                        firstDate: DateTime(1930),
                        lastDate: DateTime(2023),
                        dateLabelText: "Date",
                        fieldLabelText: "Date",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17.5,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 3),
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(_focusStreetAddress1);
                        },
                        decoration: InputDecoration(
                            hintText: "Birth Date",
                            hintStyle: kTextHintStyle,
                            prefixIcon: const Icon(Icons.date_range_outlined,
                                color: Colors.black, size: 35),
                            helperText: "Required*",
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: _isValidDate
                                        ? kValidColor
                                        : kNotValidColor,
                                    width: 2)),
                            helperStyle: _isValidDate
                                ? kRequiredValidHintStyle
                                : kRequiredNotValidHintStyle),
                        onChanged: (val) => {
                          _selectedDate = val,
                          if (val.isNotEmpty && val != "")
                            context
                                .read<SignUpTextFieldStates>()
                                .setIsDateValidTo(true)
                          else if (val.isEmpty || val == "")
                            context
                                .read<SignUpTextFieldStates>()
                                .setIsDateValidTo(false)
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
                      icon: Icons.house_outlined,
                      thisFocusNode: _focusStreetAddress1,
                      requestNextFocus: _focusStreetAddress2,
                      fieldStateListener: _isValidFirstStreetAddress,
                      isItValid: (bool bool) => {
                        context
                            .read<SignUpTextFieldStates>()
                            .setIsFirstStreetAddressValidTo(bool)
                      },
                    ),
                    SignUpTextFields(
                      key: _secondStreetAddressKey,
                      fieldController: _secondStreetAddress,
                      keyboardType: TextInputType.streetAddress,
                      obscureText: false,
                      hintText: _secondStreetAddresHintText,
                      isRequired: false,
                      icon: Icons.house_rounded,
                      thisFocusNode: _focusStreetAddress2,
                      requestNextFocus: _focusCity,
                      fieldStateListener: null,
                      isItValid: (bool bool) => {},
                    ),
                    SignUpTextFields(
                      key: _cityKey,
                      fieldController: _city,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      hintText: _cityHintText,
                      isRequired: true,
                      icon: Icons.location_city_outlined,
                      thisFocusNode: _focusCity,
                      requestNextFocus: _focusState,
                      fieldStateListener: _isValidCity,
                      isItValid: (bool bool) => {
                        context
                            .read<SignUpTextFieldStates>()
                            .setIsCityValid(bool)
                      },
                    ),
                    SignUpTextFields(
                      key: _stateKey,
                      fieldController: _state,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      hintText: _stateHintText,
                      isRequired: true,
                      icon: Icons.location_on_outlined,
                      thisFocusNode: _focusState,
                      requestNextFocus: _focusZip,
                      fieldStateListener: _isValidState,
                      isItValid: (bool bool) => {
                        context
                            .read<SignUpTextFieldStates>()
                            .setIsStateValid(bool)
                      },
                    ),
                    SignUpTextFields(
                      key: _zipKey,
                      fieldController: _zip,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      hintText: _zipHintText,
                      isRequired: true,
                      icon: Icons.local_post_office_outlined,
                      textInputDone: true,
                      thisFocusNode: _focusZip,
                      requestNextFocus: _focusScreen,
                      fieldStateListener: _isValidZip,
                      isItValid: (bool bool) => {
                        context
                            .read<SignUpTextFieldStates>()
                            .setIsZipValid(bool)
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width / 5),
                      child: SizedBox(
                        height: 55,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            _changeValidationStateIfInputIsEmpty();

                            if (_isFormValid()) {
                              setState(() {
                                _dataIsGettingSend = true;
                              });
                              await _addUser();
                              _clearTextFieldsAndResetValidation();
                            } else {
                              _redirectScopeIfFieldIsInvalidOnSubmission();
                            }

                            setState(() {
                              _dataIsGettingSend = false;
                            });
                          },
                          child: _dataIsGettingSend
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3.5,
                                )
                              : const Text("Sign Up"),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
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
        ),
      ),
    );
  }
}
