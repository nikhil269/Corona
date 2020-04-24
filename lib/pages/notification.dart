import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final String url = 'https://api.rootnet.in/covid19-in/notifications';
  List data;
  var a;

  Future<String> getNotification() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application.json"});
    setState(() {
      try {
        var convert = json.decode(response.body);
        a = convert['data'];
        data = a['notifications'];
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
        //  backgroundColor: Colors.black87,
        title: Center(
          child: Text(
            "Notification (Tap to Download)",
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
                        child: GestureDetector(
                          onTap: () {
                            launch(data[index]['link'].toString());
                          },
                          child: Card(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 5.0,
                                ),
                                Center(
                                    child: Text(
                                  data[index]['title'].toString(),
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                )),
                                // Divider(),
                                // Center(
                                //     child: GestureDetector(
                                //   onTap: () {
                                //     launch(data[index]['link'].toString());
                                //   },
                                //   child: Text(
                                //     data[index]['link'].toString(),
                                //     style: GoogleFonts.openSans(
                                //         fontWeight: FontWeight.normal,color: Colors.grey[800]),
                                //   ),
                                // )),
                              ],
                            ),
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
