import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thumbing/screens/typing_test_screen.dart';
import 'package:thumbing/utility/constants.dart';

import '../model/test_settings.dart';
import '../utility/colors.dart';

class TestSetting extends StatefulWidget {
  static const String kTestSetting = "kTestSetting";

  @override
  State<TestSetting> createState() => _TestSettingState();
}

class _TestSettingState extends State<TestSetting> {
  int selectedLength = 30;
  int difficulty = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: kLightBlueAccent,
          ),
          title: Text(
            'TEST SETTINGS',
            style: GoogleFonts.lato(
                fontSize: 22.0,
                color: kLightBlueAccent,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView(
                    shrinkWrap: true,
                    children: [
                      SettingTitleText(
                        titleText: 'Set Length',
                      ),
                      RadioListTile(
                          value: 30,
                          activeColor: kFABColor,
                          title: RadioLabel(labelText: '30 sec'),
                          groupValue: selectedLength,
                          onChanged: (value) =>
                              setState(() => selectedLength = value as int)),
                      RadioListTile(
                          title: RadioLabel(
                            labelText: '1 min',
                          ),
                          value: 60,
                          activeColor: kFABColor,
                          groupValue: selectedLength,
                          onChanged: (value) =>
                              setState(() => selectedLength = value as int)),
                      RadioListTile(
                          title: RadioLabel(
                            labelText: '1 min 30 sec',
                          ),
                          value: 90,
                          activeColor: kFABColor,
                          groupValue: selectedLength,
                          onChanged: (value) =>
                              setState(() => selectedLength = value as int)),
                    ],
                  ),
                  ListView(
                    shrinkWrap: true,
                    children: [
                      SettingTitleText(titleText: 'Set Difficulty'),
                      RadioListTile(
                          title: RadioLabel(
                            labelText: 'Normal',
                          ),
                          value: kNormalTestDifficult,
                          groupValue: difficulty,
                          activeColor: kFABColor,
                          onChanged: (value) =>
                              setState(() => difficulty = value as int)),
                      RadioListTile(
                          value: kLorenIpsumTestDifficulty,
                          title: RadioLabel(
                            labelText: 'Loren Ipsum',
                          ),
                          groupValue: difficulty,
                          activeColor: kFABColor,
                          onChanged: (value) =>
                              setState(() => difficulty = value as int)),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) {
                    TestSettings currentSetting = TestSettings(difficulty: difficulty, testLength: selectedLength);
                    return TypingTestScreen(currentSetting);
                  }),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.lightBlue,
                minimumSize: Size(double.maxFinite, 48),
              ),
              child: Text(
                'START',
                style: GoogleFonts.lato(
                  fontSize: 25.0,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RadioLabel extends StatelessWidget {
  final String labelText;

  RadioLabel({required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Text(
      labelText,
      style: GoogleFonts.lato(
        fontWeight: FontWeight.w500,
        fontSize: 18.0,
      ),
    );
  }
}

class SettingTitleText extends StatelessWidget {
  final String titleText;

  SettingTitleText({
    required this.titleText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        titleText,
        textAlign: TextAlign.left,
        style: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 22.0,
              color: Colors.lightBlue,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
