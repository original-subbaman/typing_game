import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:thumbing/model/test_settings.dart';
import 'package:thumbing/screens/home_screen.dart';
import 'package:thumbing/utility/constants.dart';
import 'package:thumbing/utility/words_generator.dart';
import 'package:thumbing/widgets/circular_score_widget.dart';
import 'package:thumbing/utility/file_reader.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:thumbing/utility/wpm_calculator.dart';

class TypingTestScreen extends StatefulWidget {
  static const kTypingScreenRoute = 'typing_screen';
  TestSettings gameSetting;
  TypingTestScreen([this.gameSetting]);
  @override
  _TypingTestScreenState createState() => _TypingTestScreenState();
}

class _TypingTestScreenState extends State<TypingTestScreen>
    with TickerProviderStateMixin {
  FocusNode inputFocusNode;
  List<String> listOfUntypedStrings = [];
  List<String> listOfTypedStrings = [];

  int testLength = 0;
  int allTypedEntriesCount = 0;
  int uncorrectedErrorCount = 0;
  int correctlyTypedEntries = 0;
  int testDifficulty = 1;

  AnimationController _animationController;
  CountdownController _countdownController;
  var _textEditingController;
  bool isPlay = true;
  bool isButtonDisabled = true;

  @override
  void initState() {
    _setGameParameters();
    _getText();
    _initControllers();
    inputFocusNode = FocusNode();
    inputFocusNode.addListener(() {
      if (!inputFocusNode.hasFocus && testLength != 0) {
        FocusScope.of(context).requestFocus(inputFocusNode);
      }
    });

    super.initState();
  }

  _setGameParameters(){
    testLength = widget.gameSetting.testLength;
    testDifficulty = widget.gameSetting.difficulty;
  }

  _getText() async {
    RandomWordsGenerator wordsGenerator = RandomWordsGenerator();

    if(testDifficulty == kNormalTestDifficult){
      listOfUntypedStrings = wordsGenerator
          .generateRandomStrings(wordsGenerator.generateRandomWords());
    }else if(testDifficulty == kLorenIpsumTestDifficulty){
      listOfUntypedStrings = wordsGenerator
          .generateRandomStrings(wordsGenerator.generateLorenIpsum());
    }
  }

  _initControllers() {
    _textEditingController = TextEditingController();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _countdownController = new CountdownController(autoStart: false);
  }

  _setIconButtonColor() {
    return isButtonDisabled ? Colors.grey[500] : Colors.white;
  }

  ///Looping through characters typed by the player(var userTyped) and the original string (var original String)
  ///and checking character for character if the strings match. For each character that matches at the correct pos.
  ///increase correctlyTypedEntries by 1 and for every incorrectly typed character increase uncorrectedErrorCount by 1.
  _calculateTypingStat(String userTyped, String originalString) {
    for (var i = 0; i < originalString.length; i++) {
      if (i >= userTyped.length) return;
      if (userTyped.substring(i, i + 1) == originalString.substring(i, i + 1)) {
        correctlyTypedEntries++;
      } else {
        uncorrectedErrorCount++;
      }
    }
  }

  _pauseTest() {
    _countdownController.pause();
  }

  _resumeTest() {
    _countdownController.resume();
  }

  _resetTypingTest() {
    _countdownController.restart();
    _countdownController.pause();

    _textEditingController.clear();

    isPlay = false;
    isButtonDisabled = true;

    _resetList();
  }

  _resetList() {
    listOfUntypedStrings.insertAll(0, listOfTypedStrings);
    listOfTypedStrings.clear();
  }

  _createCupertinoDialog() {
    return CupertinoAlertDialog(
      title: Text('Well Done!'),
      content: Column(children: [
        Text('WPM: 87'),
        Text('Accuracy: 98%'),
      ]),
      actions: [
        CupertinoDialogAction(
          child: Text('Done'),
        )
      ],
    );
  }

  _createTestScoreAlertDialog({int acc, int wpm}) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple,
      title: Text(
        'Your Test Score',
        style: GoogleFonts.lato(
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontSize: 28,
        ),
        textAlign: TextAlign.center,
      ),
      content: Container(
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          CircularScoreWidget(
            score: wpm,
            appendText: 'WPM',
            color: Colors.blueAccent,
          ),
          SizedBox(
            width: 30,
          ),
          CircularScoreWidget(
            score: acc,
            appendText: 'Acc',
            color: Colors.blueAccent,
          ),
        ]),
      ),
      actions: [
        TextButton(
          child: Text('Re-Take', style: kAlertDialogTextButtonStyle),
          onPressed: () {
            _resetTypingTest();
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text('Done', style: kAlertDialogTextButtonStyle),
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        )
      ],
      elevation: 24.0,
    );
  }

  Future<bool> _showWarning() async => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Do you want to exit the test?'),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, false), child: Text('No')),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, true), child: Text('Yes'))
            ],
          ));

  int _calculateWPM() {
    WPMCalculator wpmCalculator = WPMCalculator(
      uncorrectedErrors: uncorrectedErrorCount,
      correctlyTypedEntries: correctlyTypedEntries,
      allTypedEntries: allTypedEntriesCount,
      minutes: testLength / 60,
    );

    return wpmCalculator.getNetWPM().round();
  }

  int _calculateAccuracy() {
    WPMCalculator wpmCalculator = WPMCalculator(
      uncorrectedErrors: uncorrectedErrorCount,
      correctlyTypedEntries: correctlyTypedEntries,
      allTypedEntries: allTypedEntriesCount,
      minutes: testLength / 60,
    );
    return wpmCalculator.getAccuracy().round();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _pauseTest();
        final shouldPop = await _showWarning();
        if(!shouldPop){
          _resumeTest();
        }
        return shouldPop ?? false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Time, pause/play button, reset button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Countdown(
                        seconds: testLength,
                        build: (_, double time) => Text('Time: $time',
                            style: GoogleFonts.lato(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                        onFinished: () {
                          FocusScope.of(context).unfocus();
                          showDialog(
                            context: context,
                            builder: (_) =>
                                Theme.of(context).platform == TargetPlatform.iOS
                                    ? _createCupertinoDialog()
                                    : _createTestScoreAlertDialog(
                                        acc: _calculateAccuracy(),
                                        wpm: _calculateWPM(),
                                      ),
                            barrierDismissible: false,
                          );
                        },
                        controller: _countdownController,
                      ),
                      //Play/Pause Button
                      IconButton(
                        icon: isPlay
                            ? Icon(Icons.pause, color: _setIconButtonColor())
                            : Icon(Icons.play_arrow,
                                color: _setIconButtonColor()),
                        iconSize: 25,
                        onPressed: isButtonDisabled
                            ? null
                            : () {
                                setState(() {
                                  if (isPlay) {
                                    _countdownController.onPause();
                                  } else {
                                    _countdownController.onResume();
                                  }

                                  isPlay = !isPlay;
                                });
                              },
                      ),
                      //Refresh Button
                      IconButton(
                        icon: Icon(
                          Icons.refresh,
                          color: _setIconButtonColor(),
                        ),
                        iconSize: 25,
                        onPressed: isButtonDisabled
                            ? null
                            : () {
                                setState(() {
                                  _resetTypingTest();
                                });
                              },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 250,
                            child: ListView.builder(
                              itemCount: listOfUntypedStrings.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              reverse: true,
                              itemBuilder: (_, index) {
                                return Text(
                                  listOfUntypedStrings[index],
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inconsolata(
                                    fontSize: index == 0 ? 22 : 18,
                                    color: index == 0
                                        ? Colors.white
                                        : Colors.white60.withOpacity(0.2),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            onChanged: (value) {
                              if (_countdownController.isCompleted == false) {
                                _countdownController.start();
                                setState(() {
                                  isButtonDisabled = false;
                                });
                              }
                            },
                            enableSuggestions: false,
                            autocorrect: false,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              fontSize: 22,
                              color: Colors.white,
                            ),
                            autofocus: true,
                            decoration: InputDecoration.collapsed(
                                hintText: 'Start typing here',
                                hintStyle: GoogleFonts.lato(
                                  fontSize: 22,
                                  color: Colors.white70,
                                )),
                            focusNode: inputFocusNode,
                            cursorHeight: 25,
                            showCursor: true,
                            cursorWidth: 5,
                            cursorColor: Colors.grey,
                            controller: _textEditingController,
                            onSubmitted: (value) {
                              if (value.isEmpty) return;
                              allTypedEntriesCount += value.length;
                              _calculateTypingStat(
                                  value, listOfUntypedStrings[0]);
                              listOfTypedStrings
                                  .add(listOfUntypedStrings.removeAt(0));
                              _textEditingController.clear();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    inputFocusNode.dispose();
    super.dispose();
  }
}
