import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thumbing/utility/constants.dart';
class CircularScoreWidget extends StatefulWidget {

  final int score;
  final String appendText;
  final Color color;
  const CircularScoreWidget({Key key, this.score, this.color, this.appendText}) : super(key: key);

  @override
  _CircularScoreWidgetState createState() => _CircularScoreWidgetState();
}

class _CircularScoreWidgetState extends State<CircularScoreWidget> with SingleTickerProviderStateMixin{

  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = IntTween(begin: 0, end: widget.score).animate(animationController);
    animationController.forward();
    animationController.addListener(() {
      setState(() {
      });
    });
    super.initState();

  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: kCardElevation,
      borderRadius: BorderRadius.circular(45.0),
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.color,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                animation.value.toString(),
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                widget.appendText,
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),),
    );
  }
}
