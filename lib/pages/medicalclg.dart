import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MediClg extends StatefulWidget {
  @override
  _MediClgState createState() => _MediClgState();
}

class _MediClgState extends State<MediClg> {
  final String url =
      'https://api.rootnet.in/covid19-in/hospitals/medical-colleges';
  var data;
  List list;

  Future<String> getLog() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application.json"});
    setState(() {
      try {
        var convert = json.decode(response.body);
        data = convert['data'];
        list = data['medicalColleges'];
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
        backgroundColor: Colors.black87,
        title: Text(
          "Medical Colleges",
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
                                  "NAME : " + list[index]['name'].toString(),
                                  style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange),
                                ),
                                 Text(
                                  "CITY : " + list[index]['city'].toString(),
                                  style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                                ),
                                 Text(
                                  "OWNERSHIP : " + list[index]['ownership'].toString(),
                                  style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                                ),
                                 Text(
                                  "ADMISSION CAPACITY : " + list[index]['admissionCapacity'].toString(),
                                  style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                                ),
                                 Text(
                                  "HOSPITAL BEDS : " + list[index]['hospitalBeds'].toString(),
                                  style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pink),
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
