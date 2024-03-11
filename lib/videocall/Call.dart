// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Call extends StatelessWidget {
  const Call({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: EdgeInsets.only(top: 50),
        child: Column(

          children: [
        Container(
        child: Image.asset("assets/customer-service.jpg"),
    ),
    SizedBox(height: 10,),
    Container(

        height: 50,

        child: Center(
          child: ElevatedButton(
          onPressed: () => launch("tel:+0201068037451"),
          child: Text("Call me",style: GoogleFonts.lato(
    color: Colors.white,
    fontSize: 25,
    fontWeight: FontWeight.bold,
    ),),
    style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black, backgroundColor: Colors.indigo[900], elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
        ),

    ),
    ),
    ]
        ),
      ),
    );
  }
}
