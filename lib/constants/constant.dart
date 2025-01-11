import 'package:flutter/material.dart';

const kTextDescriptionAuth = TextStyle(
  fontSize: 16,
  height: 1.6,
  color: Color.fromARGB(255, 111, 111, 111),
  fontWeight: FontWeight.w600,
  fontFamily: "Roboto",
);

const kTextEventProfile =
    TextStyle(color: Colors.black, height: 1.6, fontFamily: "Inter");

const kTextEditProfile = TextStyle(
    fontSize: 17,
    fontFamily: "Inter",
    fontWeight: FontWeight.bold,
    color: Colors.blue);

const kStyleInputEditProfile = InputDecoration(
  hintText: 'Username',
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Color.fromARGB(255, 212, 212, 212)),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Color.fromARGB(255, 212, 212, 212)),
  ),
  border: UnderlineInputBorder(
    borderSide: BorderSide(color: Color.fromARGB(255, 212, 212, 212)),
  ),
);

const kTextStyleTitleAccSetting = TextStyle(
    fontFamily: "Inter",
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.grey);
