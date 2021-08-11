import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:thumbing/screens/typing_test_screen.dart';
import 'package:thumbing/utility/file_reader.dart';
import 'utility/constants.dart';
import 'widgets/circular_score_widget.dart';

void main() {
  runApp(MaterialApp(
    home: TypingTestScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

