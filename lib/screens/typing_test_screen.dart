import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thumbing/utility/constants.dart';
import 'package:thumbing/widgets/circular_score_widget.dart';
import 'package:thumbing/utility/file_reader.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:thumbing/utility/wpm_calculator.dart';

class TypingTestScreen extends StatefulWidget {
  @override
  _TypingTestScreenState createState() => _TypingTestScreenState();
}

class _TypingTestScreenState extends State<TypingTestScreen> with TickerProviderStateMixin {

  FocusNode inputFocusNode;
  List<String> listOfUntypedStrings = [];
  List<String> listOfTypedStrings = [];

  int seconds = 20;
  int allTypedEntriesCount = 0;
  int uncorrectedErrorCount = 0;
  int correctlyTypedEntries = 0;

  AnimationController _animationController;
  CountdownController _countdownController;
  var _textEditingController;
  bool isPlay = true;
  bool isButtonDisabled = true;

  @override
  void initState() {
    _getText();
    _initControllers();
    inputFocusNode = FocusNode();
    inputFocusNode.addListener(() {
      if (!inputFocusNode.hasFocus && seconds != 0) {
        FocusScope.of(context).requestFocus(inputFocusNode);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    inputFocusNode.dispose();
    super.dispose();
  }

  _getText() async {
    String textData = await FileReader().getFileData();
    setState(() {
      listOfUntypedStrings = LineSplitter().convert(textData);
    });
  }

  _initControllers(){
    _textEditingController = TextEditingController();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _countdownController =
    new CountdownController(autoStart: false);
  }

  _setIconButtonColor(){
    return isButtonDisabled? Colors.grey[500] : Colors.white;
  }

  _calculateTypingStat(String userTyped, String orgString) {
    for (var i = 0; i < orgString.length; i++) {
      if (i >= userTyped.length) return;
      if (userTyped.substring(i, i + 1) == orgString.substring(i, i + 1)) {
        correctlyTypedEntries++;
      } else {
        uncorrectedErrorCount++;
      }
    }
  }

  _resetList(){
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

  _createAlertDialog({int acc, int wpm}) {
    return AlertDialog(
      backgroundColor: Colors.lightBlueAccent.shade100,
      title: Text(
        'Your Score',
        style: GoogleFonts.lato(
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontSize: 28,
        ),
        textAlign: TextAlign.center,
      ),
      content: Container(
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          CircularScoreWidget(score: wpm, appendText: 'WPM',color: Colors.blueAccent,),
          SizedBox(width: 30,),
          CircularScoreWidget(score: acc, appendText: 'Acc', color: Colors.deepPurpleAccent,),
        ]),
      ),
      actions: [
        TextButton(
          child: Text('Re-Take',
              style: kAlertDialogTextButtonStyle),
        ),
        TextButton(
          child: Text('Done',
              style: kAlertDialogTextButtonStyle),
        )
      ],
      elevation: 24.0,
    );
  }

  int _calculateWPM(){
    WPMCalculator wpmCalculator = WPMCalculator(
      uncorrectedErrors: uncorrectedErrorCount,
      correctlyTypedEntries: correctlyTypedEntries,
      allTypedEntries: allTypedEntriesCount,
      minutes: seconds/60,
    );

    return wpmCalculator.getNetWPM().round();
  }

  int _calculateAccuracy(){
    WPMCalculator wpmCalculator = WPMCalculator(
      uncorrectedErrors: uncorrectedErrorCount,
      correctlyTypedEntries: correctlyTypedEntries,
      allTypedEntries: allTypedEntriesCount,
      minutes: seconds/60,
    );
    return wpmCalculator.getAccuracy().round();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      seconds: seconds,
                      build: (_, double time) => Text('Time: $time',
                          style: GoogleFonts.lato(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                      onFinished: (){
                        FocusScope.of(context).unfocus();
                        showDialog(
                          context: context,
                          builder: (_) => Theme.of(context).platform == TargetPlatform.iOS
                              ? _createCupertinoDialog()
                              : _createAlertDialog(
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
                          : Icon(Icons.play_arrow, color: _setIconButtonColor()),
                      iconSize: 25,
                      onPressed: isButtonDisabled? null : () {
                        setState(() {
                          if (isPlay) {
                            _countdownController.onPause();
                          }else{
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
                      onPressed: isButtonDisabled? null : () {
                        setState(() {
                          _countdownController.restart();
                          _countdownController.pause();

                          isPlay = false;
                          isButtonDisabled = true;

                          _resetList();
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
                            allTypedEntriesCount += value.length;
                            _calculateTypingStat(value, listOfUntypedStrings[0]);
                            listOfTypedStrings.add(listOfUntypedStrings.removeAt(0));
                            print(allTypedEntriesCount);
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
    );
  }


}
