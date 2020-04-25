import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class States extends StatefulWidget {
  @override
  _StatesState createState() => _StatesState();
}

class _StatesState extends State<States> {
  List data;
  var a;
  final String url = 'https://api.covid19india.org/data.json';

  @override
  void initState() {
    super.initState();
    this.getState();
  }

  Future<String> getState() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application.json"});
    setState(() {
      setState(() {
        var convert = json.decode(response.body);
        data = convert['statewise'];
      });

      return "Success";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
     //   backgroundColor: Colors.black87,
        title: Text(
          "State ",
          style: GoogleFonts.openSans(),
        ),
      ),
      body: Container(
        child: (data == null)? Center(child: CupertinoActivityIndicator()) :ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 5.0,
                          ),
                          Center(
                              child: Text(
                            data[index]['state'],
                            style: GoogleFonts.openSans(
                                fontWeight: FontWeight.bold),
                          )),
                          Divider(),

                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  "Confirmed \n  " +
                                      data[index]['confirmed'] +
                                      "\n  [+" +
                                      data[index]['deltaconfirmed'] +
                                      "]",
                                  style:
                                      GoogleFonts.openSans(color: Colors.red),
                                ),
                                Text(
                                  "Recovered \n  " +
                                      data[index]['recovered'] +
                                      "\n [+" +
                                      data[index]['deltarecovered'] +
                                      "]",
                                  style:
                                      GoogleFonts.openSans(color: Colors.green),
                                ),
                                Text(
                                  "Active \n" + data[index]['active'] + "\n",
                                  style:
                                      GoogleFonts.openSans(color: Colors.blue),
                                ),
                                Text(
                                  "Deaths \n" +
                                      data[index]['deaths'] +
                                      "\n [+" +
                                      data[index]['deltadeaths'] +
                                      "]",
                                  style: GoogleFonts.openSans(
                                      color: Colors.orange),
                                )
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 7.0,
                          ),

                          // Card(
                          //   child: Text(data[index]['state']),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
