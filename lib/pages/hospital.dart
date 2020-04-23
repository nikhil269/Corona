import 'package:corona/pages/hospitalbeds.dart';
import 'package:corona/pages/medicalclg.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Hospital extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       // backgroundColor: Colors.black87,
        title: Center(
          child: Text(
            "Hospitals & beds",
            style: GoogleFonts.openSans(),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HospitalBed()));
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 2.5,
              child: Card(
                elevation: 5.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Center(
                      child: Text(
                        "Hospitals & beds",
                        style: GoogleFonts.openSans(
                            fontSize: 30.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height / 4,
                        child:
                            Image.asset("assets/bed.jpg", fit: BoxFit.cover)),
                    SizedBox(
                      height: 10.0,
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MediClg()));
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 2.5,
              child: Card(
                elevation: 5.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Center(
                      child: Text(
                        "MedicalColleges",
                        style: GoogleFonts.openSans(
                            fontSize: 30.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height / 4,
                        child: Image.asset("assets/doctor.png",
                            fit: BoxFit.cover)),
                    SizedBox(
                      height: 10.0,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
