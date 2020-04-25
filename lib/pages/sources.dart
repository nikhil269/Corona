import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Sources extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sources",
          style: GoogleFonts.openSans(),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              child: Center(
                  child: Text(
                "covid19india",
                style: GoogleFonts.openSans(
                    fontSize: 30.0, fontWeight: FontWeight.bold),
              )),
            ),
          ),
           Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              child: Center(
                  child: Text(
                "javieraviles/covidAPI",
                style: GoogleFonts.openSans(
                    fontSize: 30.0, fontWeight: FontWeight.bold),
              )),
            ),
          )
        ],
      ),
    );
  }
}
