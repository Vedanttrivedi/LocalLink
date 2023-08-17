import 'package:flutter/material.dart';

final formFieldStyle = InputDecoration(
  labelStyle: TextStyle(
    color: Colors.black,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.blueAccent,
      width: 1.0,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.blueAccent,
      width: 2.0,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  ),
);
