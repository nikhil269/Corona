import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {

 final String url = 'https://api.rootnet.in/covid19-in/contacts';
  List data;
  var a,b;

  Future<String> getNotification() async {
    var response = await http.get(Uri.encodeFull(url), headers: {"Accept": "application.json"});
    setState(() {
      try {
        var convert = json.decode(response.body);
        a = convert['data'];
        b = a['contacts'];
        data = b['regional'];
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
    this.getNotification();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
 appBar: AppBar(
       // backgroundColor: Colors.black87,
        title: Text(
            "Contact",
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
                                data[index]['loc'].toString(),
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              )),
                              Divider(),
                              Center(
                                  child: Text(
                                    data[index]['number'].toString(),
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
