import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


final kWPMChartTile = 'Y - WPM, X - Days';
final kAccuracyChartTile = 'Y - Accuracy, X - Days';

//Colors
final kVeryDarkPurple = const Color.fromRGBO(81, 45, 168, 1.0);


final kAlertDialogTextButtonStyle = GoogleFonts.lato(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold
);

final kCardTextStyle = GoogleFonts.lato(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 20,
);

final kRankUpIcon = Icon(
  Icons.arrow_circle_up_rounded,
  color: Colors.green,
  size: 30,
);

final kRankDownIcon = Icon(
  Icons.arrow_circle_down_rounded,
  color: Colors.red,
  size: 30,
);

final kCircleAvatar = CircleAvatar(
  radius: 25,
  backgroundColor: Colors.lightBlueAccent,
  child: Icon(
    Icons.perm_identity,
    color: Colors.white,
  )
);

void showSnackBar({String msg, BuildContext context}){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg))
  );
}

void dismissKeyboard(){
  FocusManager.instance.primaryFocus?.unfocus();
}
