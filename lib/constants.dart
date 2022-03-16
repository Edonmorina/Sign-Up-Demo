import 'package:flutter/material.dart';

const kNotValidColor = Color.fromARGB(255, 185, 41, 36);
const kValidColor = Color.fromARGB(255, 6, 199, 102);

const kTextFieldStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'Montserrat',
    fontSize: 20,
    letterSpacing: 2,
    fontWeight: FontWeight.w500);

const kNotRequiredHintStyle = TextStyle(
    color: Color.fromARGB(255, 168, 168, 168),
    fontFamily: 'Montserrat',
    fontSize: 15,
    fontWeight: FontWeight.bold,
    letterSpacing: 1);
const kRequiredValidHintStyle = TextStyle(
    color: kValidColor,
    fontFamily: 'Montserrat',
    fontSize: 15,
    fontWeight: FontWeight.bold,
    letterSpacing: 1);

const kRequiredNotValidHintStyle = TextStyle(
    color: kNotValidColor,
    fontFamily: 'Montserrat',
    fontSize: 15,
    fontWeight: FontWeight.bold,
    letterSpacing: 1);
