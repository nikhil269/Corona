import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  final String url = 'https://api.covid19india.org/updatelog/log.json';
  List data;

  _ago(timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }

  Future<String> getLog() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application.json"});
    setState(() {
      try {
        var convert = json.decode(response.body);
        data = convert.reversed.toList();
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
        title: Center(
          child: Text(
            "Recent News 📰",
            style: GoogleFonts.openSans(),
          ),
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
                                _ago(data[index]['timestamp']).toString(),
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              )),
                              Divider(),
                              Center(
                                  child: Text(
                                data[index]['update'].toString(),
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.normal),
                              )),
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

Widget Info() {
  return Container(
    child: Center(
      child: Card(
        child: Text("Data Not Found"),
      ),
    ),
  );
}
