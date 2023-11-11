import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurple.shade800,
      elevation: 0.0,
      title: Text(
        'My Profile',
        style: GoogleFonts.lato(
            fontSize: 22.0, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
