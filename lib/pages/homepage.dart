import 'dart:async';
import 'package:corona/model/total.dart';
import 'package:corona/pages/states.dart';
import 'package:corona/service/fetchTotal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(HomePage());

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Total> futureTotal;
  List data;
  var a;
  var gj;
  final String url = 'https://api.covid19india.org/data.json';

  @override
  void initState() {
    super.initState();
    futureTotal = fetchTotal();
    this.getIndia();
  }

  Future<String> getIndia() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application.json"});
    setState(() {
      setState(() {
        var convert = json.decode(response.body);
        data = convert['statewise'];
        a = data[0];
        gj = data[3];
      });

      return "Success";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text(
          'Corona Live Count',
          style: GoogleFonts.openSans(),
        ),
      ),
      body: ListView(
        children: <Widget>[
          FutureBuilder<Total>(
              future: futureTotal,
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return DashboardCard(
                      context,
                      "World Wide",
                      snapshot.data.cases.toString(),
                      snapshot.data.recovered.toString(),
                      snapshot.data.active.toString(),
                      snapshot.data.deaths.toString(),
                      snapshot.data.todayCases.toString(),
                      snapshot.data.todayDeaths.toString(),
                      "");
                else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CupertinoActivityIndicator();
              }),

          DashboardCard(
              context,
              "India In",
              a['confirmed'].toString(),
              a['recovered'].toString(),
              a['active'].toString(),
              a['deaths'].toString(),
              a['deltaconfirmed'].toString(),
              a['deltadeaths'].toString(),
              a['deltarecovered'].toString()),

          Divider(),

          Container(
            height: MediaQuery.of(context).size.height * 0.03,
            child: Center(
              child: Text(
                "StateWise",
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
          ),

          Divider(),

          DashboardCard(
              context,
              gj['state'].toString(),
              gj['confirmed'].toString(),
              gj['recovered'].toString(),
              gj['active'].toString(),
              gj['deaths'].toString(),
              gj['deltaconfirmed'].toString(),
              gj['deltadeaths'].toString(),
              gj['deltarecovered'].toString()),

          OutlineButton(
              borderSide: BorderSide(color: Colors.indigo),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => States()));
              },
              child: Text(
                "Show more States",
                style: GoogleFonts.openSans(color: Colors.indigo),
              ))

          // Container(
          //             child: ListView.builder(
          //       itemCount: data == null ? 0 : data.length,
          //       itemBuilder: (BuildContext context, int index) {
          //         print(data);
          //         return Container(
          //           child: Center(
          //             child: Column(
          //               children: <Widget>[
          //                 Card(
          //                   child: Text(data[index]['total']),
          //                 )
          //               ],
          //             ),
          //           ),
          //         );
          //       }),
          // )
        ],
      ),
    );
  }
}

Widget DashboardCard(BuildContext context, String title, text1, text2, text3,
    text4, text5, text6, text7) {
  return Container(
    height: MediaQuery.of(context).size.height / 7.0,
    child: Card(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 7.0),
            child: Text(title,
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold, fontSize: 16.0)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Confirmed \n  " + text1 + "\n  [+" + text5 + "]",
                  style: GoogleFonts.openSans(color: Colors.red),
                ),
                Text(
                  "Recovered \n  " + text2 + "\n [+" + text7 + "]",
                  style: GoogleFonts.openSans(color: Colors.green),
                ),
                Text(
                  "Active \n" + text3 + "\n",
                  style: GoogleFonts.openSans(color: Colors.blue),
                ),
                Text(
                  "Deaths \n" + text4 + "\n [+" + text6 + "]",
                  style: GoogleFonts.openSans(color: Colors.orange),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 5), child: Text("Loading")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
