import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class CountryWise extends StatefulWidget {
  @override
  _CountryWiseState createState() => _CountryWiseState();
}

class _CountryWiseState extends State<CountryWise> {
  List data;
  var a;
  final String url = 'https://coronavirus-19-api.herokuapp.com/countries';

  @override
  void initState() {
    super.initState();
    this.getCountry();
  }

  Future<String> getCountry() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application.json"});
    setState(() {
      setState(() {
        var convert = json.decode(response.body);
        data = convert;
        print(data);
      });

      return "Success";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CountryWise",
          style: GoogleFonts.openSans(),
        ),
      ),
      body: Container(
        child: (data == null)
            ? Center(child: CupertinoActivityIndicator())
            : ListView.builder(
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
                                data[index]['country'],
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.bold),
                              )),
                              Divider(),

                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      "Confirmed \n  " +
                                          data[index]['cases'].toString() +
                                          "\n  [+" +
                                          data[index]['todayCases'].toString() +
                                          "]",
                                      style: GoogleFonts.openSans(
                                          color: Colors.red),
                                    ),
                                    Text(
                                      "Recovered \n  " +
                                          data[index]['recovered'].toString() +
                                          "\n",
                                      style: GoogleFonts.openSans(
                                          color: Colors.green),
                                    ),
                                    Text(
                                      "Active \n" +
                                          data[index]['active'].toString() +
                                          "\n",
                                      style: GoogleFonts.openSans(
                                          color: Colors.blue),
                                    ),
                                    Text(
                                      "Deaths \n" +
                                          data[index]['deaths'].toString() +
                                          "\n [+" +
                                          data[index]['deaths'].toString() +
                                          "]",
                                      style: GoogleFonts.openSans(
                                          color: Colors.orange),
                                    ),
                                       Text(
                                      "Critical \n" +
                                          data[index]['critical'].toString() +
                                          "\n",
                                      style: GoogleFonts.openSans(
                                          color: Colors.deepOrangeAccent),
                                    ),
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
