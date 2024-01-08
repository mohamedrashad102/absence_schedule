import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final darkTheme = ThemeData.dark().copyWith(
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0XFF202c33),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ),
  ),
  scaffoldBackgroundColor: const Color(0XFF111b21),
);
