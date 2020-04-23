import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HospitalBed extends StatefulWidget {
  @override
  _HospitalBedState createState() => _HospitalBedState();
}

class _HospitalBedState extends State<HospitalBed> {

 final String url =
      'https://api.rootnet.in/covid19-in/hospitals/beds';
  var data;
  List list;

  Future<String> getLog() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application.json"});
    setState(() {
      try {
        var convert = json.decode(response.body);
        data = convert['data'];
        list = data['regional'];
        print(list);
      } catch (e) {
        print(e);
      }
    });
    return "Success";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getLog();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
 appBar: AppBar(
      //  backgroundColor: Colors.black87,
        title: Text(
          "Hospitals & beds",
          style: GoogleFonts.openSans(),
        ),
      ),
      body: Container(
        child: (list == null)
            ? Center(child: CupertinoActivityIndicator())
            : ListView.builder(
                itemCount: list == null ? 0 : list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 5.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  "STATE : " + list[index]['state'].toString(),
                                  style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                                ),
                                 Text(
                                  "RURAL HOSPITALS : " + list[index]['ruralHospitals'].toString(),
                                  style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange),
                                ),
                                 Text(
                                  "RURAL BEDS : " + list[index]['ruralBeds'].toString(),
                                  style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                                ),
                                 Text(
                                  "URBAN HOSPITALS : " + list[index]['urbanHospitals'].toString(),
                                  style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                                ),
                                 Text(
                                  "URBAN BEDS : " + list[index]['urbanBeds'].toString(),
                                  style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                                ),
                                 Text(
                                  "TOTAL HOSPITALS : " + list[index]['totalHospitals'].toString(),
                                  style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pink),
                                ),
                                 Text(
                                  "TOTAL BEDS : " + list[index]['totalBeds'].toString(),
                                  style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown),
                                ),
                                 Text(
                                  "UPDATE ON : " + list[index]['asOn'].toString(),
                                  style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.cyan),
                                ),
                              ],
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}
