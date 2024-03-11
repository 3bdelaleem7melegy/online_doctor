import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MeetingControls extends StatelessWidget {
  final void Function() onToggleMicButtonPressed;
  final void Function() onToggleCameraButtonPressed;
  final void Function() onLeaveButtonPressed;

  const MeetingControls(
      {super.key,
        required this.onToggleMicButtonPressed,
        required this.onToggleCameraButtonPressed,
        required this.onLeaveButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(

            onPressed: onLeaveButtonPressed , child:  Text('Leave',style: GoogleFonts.lato(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    )),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black, backgroundColor: Colors.indigo[900], elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),),

        ElevatedButton(

            onPressed: onToggleMicButtonPressed, child:  Text('Toggle Mic',style: GoogleFonts.lato(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    )),
    style: ElevatedButton.styleFrom(
    foregroundColor: Colors.black, backgroundColor: Colors.indigo[900], elevation: 2,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(32.0),
    ),
    )),
        ElevatedButton(

            onPressed: onToggleCameraButtonPressed,
            child:  Text('Toggle Video',style: GoogleFonts.lato(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    )),
    style: ElevatedButton.styleFrom(
    foregroundColor: Colors.black, backgroundColor: Colors.indigo[900], elevation: 2,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(32.0),
    ),
    ),),
      ],
    );
  }
}