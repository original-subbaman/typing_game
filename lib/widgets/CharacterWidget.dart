import 'package:flutter/material.dart';

class CharacterWidget extends StatefulWidget {
  final String _line;

  CharacterWidget(this._line);

  @override
  _CharacterWidgetState createState() => _CharacterWidgetState();
}

class _CharacterWidgetState extends State<CharacterWidget> {
  int widgetBackground = 0;
  var characters = [];

  _createCharacterWidgets() {
    widget._line.runes.forEach((int rune) {
      var character = new String.fromCharCode(rune);
      characters.add(Text(
        character,
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ));
    });
  }


  @override
  void initState() {
    _createCharacterWidgets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: this.characters,
    );
  }
}
