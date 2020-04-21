import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Dist extends StatefulWidget {
  @override
  _DistState createState() => _DistState();
}

class _DistState extends State<Dist> {
  var data;
  var distict;
  var ah, an;
  final String dist = 'https://api.covid19india.org/state_district_wise.json';

  @override
  void initState() {
    super.initState();
    this.getDist();
  }

  Future<String> getDist() async {
    var response = await http
        .get(Uri.encodeFull(dist), headers: {"Accept": "application.json"});
    setState(() {
      setState(() {
        var convert = json.decode(response.body);
        data = convert['Gujarat'];
        distict = data['districtData'];
        ah = distict['Ahmadabad'];
        an = distict['Anand'];
      });

      return "Success";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          "Gujarat",
          style: GoogleFonts.openSans(),
        ),
      ),
      body: Container(
        child: (data == null)
            ? Center(child: CupertinoActivityIndicator())
            : ListView(
                children: <Widget>[
                  ListCard(
                      "Ahmedabad",
                      ah['active'].toString(),
                      ah['confirmed'].toString(),
                      ah['delta']['confirmed'].toString(),
                      ah['deceased'].toString(),
                      ah['delta']['deceased'].toString(),
                      ah['recovered'].toString(),
                      ah['delta']['recovered'].toString()),
                  ListCard(
                      "Anand",
                      an['active'].toString(),
                      an['confirmed'].toString(),
                      an['delta']['confirmed'].toString(),
                      an['deceased'].toString(),
                      an['delta']['deceased'].toString(),
                      an['recovered'].toString(),
                      an['delta']['recovered'].toString()),
                  ListCard(
                      "Aravalli",
                      distict['Aravalli']['active'].toString(),
                      distict['Aravalli']['confirmed'].toString(),
                      distict['Aravalli']['delta']['confirmed'].toString(),
                      distict['Aravalli']['deceased'].toString(),
                      distict['Aravalli']['delta']['deceased'].toString(),
                      distict['Aravalli']['recovered'].toString(),
                      distict['Aravalli']['delta']['recovered'].toString()),
                  ListCard(
                      "Banas Kantha",
                      distict['Banas Kantha']['active'].toString(),
                      distict['Banas Kantha']['confirmed'].toString(),
                      distict['Banas Kantha']['delta']['confirmed'].toString(),
                      distict['Banas Kantha']['deceased'].toString(),
                      distict['Banas Kantha']['delta']['deceased'].toString(),
                      distict['Banas Kantha']['recovered'].toString(),
                      distict['Banas Kantha']['delta']['recovered'].toString()),
                  ListCard(
                      "Bharuch",
                      distict['Bharuch']['active'].toString(),
                      distict['Bharuch']['confirmed'].toString(),
                      distict['Bharuch']['delta']['confirmed'].toString(),
                      distict['Bharuch']['deceased'].toString(),
                      distict['Bharuch']['delta']['deceased'].toString(),
                      distict['Bharuch']['recovered'].toString(),
                      distict['Bharuch']['delta']['recovered'].toString()),
                  ListCard(
                      "Bhavnagar",
                      distict['Bhavnagar']['active'].toString(),
                      distict['Bhavnagar']['confirmed'].toString(),
                      distict['Bhavnagar']['delta']['confirmed'].toString(),
                      distict['Bhavnagar']['deceased'].toString(),
                      distict['Bhavnagar']['delta']['deceased'].toString(),
                      distict['Bhavnagar']['recovered'].toString(),
                      distict['Bhavnagar']['delta']['recovered'].toString()),
                  ListCard(
                      "Botad",
                      distict['Botad']['active'].toString(),
                      distict['Botad']['confirmed'].toString(),
                      distict['Botad']['delta']['confirmed'].toString(),
                      distict['Botad']['deceased'].toString(),
                      distict['Botad']['delta']['deceased'].toString(),
                      distict['Botad']['recovered'].toString(),
                      distict['Botad']['delta']['recovered'].toString()),
                  ListCard(
                      "Chota Udaipur",
                      distict['Chota Udaipur']['active'].toString(),
                      distict['Chota Udaipur']['confirmed'].toString(),
                      distict['Chota Udaipur']['delta']['confirmed'].toString(),
                      distict['Chota Udaipur']['deceased'].toString(),
                      distict['Chota Udaipur']['delta']['deceased'].toString(),
                      distict['Chota Udaipur']['recovered'].toString(),
                      distict['Chota Udaipur']['delta']['recovered']
                          .toString()),
                  ListCard(
                      "Dahod",
                      distict['Dahod']['active'].toString(),
                      distict['Dahod']['confirmed'].toString(),
                      distict['Dahod']['delta']['confirmed'].toString(),
                      distict['Dahod']['deceased'].toString(),
                      distict['Dahod']['delta']['deceased'].toString(),
                      distict['Dahod']['recovered'].toString(),
                      distict['Dahod']['delta']['recovered'].toString()),
                  ListCard(
                      "Gandhinagar",
                      distict['Gandhinagar']['active'].toString(),
                      distict['Gandhinagar']['confirmed'].toString(),
                      distict['Gandhinagar']['delta']['confirmed'].toString(),
                      distict['Gandhinagar']['deceased'].toString(),
                      distict['Gandhinagar']['delta']['deceased'].toString(),
                      distict['Gandhinagar']['recovered'].toString(),
                      distict['Gandhinagar']['delta']['recovered'].toString()),
                  ListCard(
                      "Gir Somnath",
                      distict['Gir Somnath']['active'].toString(),
                      distict['Gir Somnath']['confirmed'].toString(),
                      distict['Gir Somnath']['delta']['confirmed'].toString(),
                      distict['Gir Somnath']['deceased'].toString(),
                      distict['Gir Somnath']['delta']['deceased'].toString(),
                      distict['Gir Somnath']['recovered'].toString(),
                      distict['Gir Somnath']['delta']['recovered'].toString()),
                  ListCard(
                      "Jamnagar",
                      distict['Jamnagar']['active'].toString(),
                      distict['Jamnagar']['confirmed'].toString(),
                      distict['Jamnagar']['delta']['confirmed'].toString(),
                      distict['Jamnagar']['deceased'].toString(),
                      distict['Jamnagar']['delta']['deceased'].toString(),
                      distict['Jamnagar']['recovered'].toString(),
                      distict['Jamnagar']['delta']['recovered'].toString()),
                  ListCard(
                      "Kachchh",
                      distict['Kachchh']['active'].toString(),
                      distict['Kachchh']['confirmed'].toString(),
                      distict['Kachchh']['delta']['confirmed'].toString(),
                      distict['Kachchh']['deceased'].toString(),
                      distict['Kachchh']['delta']['deceased'].toString(),
                      distict['Kachchh']['recovered'].toString(),
                      distict['Kachchh']['delta']['recovered'].toString()),
                  ListCard(
                      "Kheda",
                      distict['Kheda']['active'].toString(),
                      distict['Kheda']['confirmed'].toString(),
                      distict['Kheda']['delta']['confirmed'].toString(),
                      distict['Kheda']['deceased'].toString(),
                      distict['Kheda']['delta']['deceased'].toString(),
                      distict['Kheda']['recovered'].toString(),
                      distict['Kheda']['delta']['recovered'].toString()),
                  ListCard(
                      "Mahesana",
                      distict['Mahesana']['active'].toString(),
                      distict['Mahesana']['confirmed'].toString(),
                      distict['Mahesana']['delta']['confirmed'].toString(),
                      distict['Mahesana']['deceased'].toString(),
                      distict['Mahesana']['delta']['deceased'].toString(),
                      distict['Mahesana']['recovered'].toString(),
                      distict['Mahesana']['delta']['recovered'].toString()),
                  ListCard(
                      "Mahisagar",
                      distict['Mahisagar']['active'].toString(),
                      distict['Mahisagar']['confirmed'].toString(),
                      distict['Mahisagar']['delta']['confirmed'].toString(),
                      distict['Mahisagar']['deceased'].toString(),
                      distict['Mahisagar']['delta']['deceased'].toString(),
                      distict['Mahisagar']['recovered'].toString(),
                      distict['Mahisagar']['delta']['recovered'].toString()),
                  ListCard(
                      "Morbi",
                      distict['Morbi']['active'].toString(),
                      distict['Morbi']['confirmed'].toString(),
                      distict['Morbi']['delta']['confirmed'].toString(),
                      distict['Morbi']['deceased'].toString(),
                      distict['Morbi']['delta']['deceased'].toString(),
                      distict['Morbi']['recovered'].toString(),
                      distict['Morbi']['delta']['recovered'].toString()),
                  ListCard(
                      "Narmada",
                      distict['Narmada']['active'].toString(),
                      distict['Narmada']['confirmed'].toString(),
                      distict['Narmada']['delta']['confirmed'].toString(),
                      distict['Narmada']['deceased'].toString(),
                      distict['Narmada']['delta']['deceased'].toString(),
                      distict['Narmada']['recovered'].toString(),
                      distict['Narmada']['delta']['recovered'].toString()),
                  ListCard(
                      "Navsari",
                      distict['Navsari']['active'].toString(),
                      distict['Navsari']['confirmed'].toString(),
                      distict['Navsari']['delta']['confirmed'].toString(),
                      distict['Navsari']['deceased'].toString(),
                      distict['Navsari']['delta']['deceased'].toString(),
                      distict['Navsari']['recovered'].toString(),
                      distict['Navsari']['delta']['recovered'].toString()),
                  ListCard(
                      "Panch Mahals",
                      distict['Panch Mahals']['active'].toString(),
                      distict['Panch Mahals']['confirmed'].toString(),
                      distict['Panch Mahals']['delta']['confirmed'].toString(),
                      distict['Panch Mahals']['deceased'].toString(),
                      distict['Panch Mahals']['delta']['deceased'].toString(),
                      distict['Panch Mahals']['recovered'].toString(),
                      distict['Panch Mahals']['delta']['recovered'].toString()),
                  ListCard(
                      "Patan",
                      distict['Patan']['active'].toString(),
                      distict['Patan']['confirmed'].toString(),
                      distict['Patan']['delta']['confirmed'].toString(),
                      distict['Patan']['deceased'].toString(),
                      distict['Patan']['delta']['deceased'].toString(),
                      distict['Patan']['recovered'].toString(),
                      distict['Patan']['delta']['recovered'].toString()),
                  ListCard(
                      "Porbandar",
                      distict['Porbandar']['active'].toString(),
                      distict['Porbandar']['confirmed'].toString(),
                      distict['Porbandar']['delta']['confirmed'].toString(),
                      distict['Porbandar']['deceased'].toString(),
                      distict['Porbandar']['delta']['deceased'].toString(),
                      distict['Porbandar']['recovered'].toString(),
                      distict['Porbandar']['delta']['recovered'].toString()),




                       ListCard(
                      "Rajkot",
                      distict['Rajkot']['active'].toString(),
                      distict['Rajkot']['confirmed'].toString(),
                      distict['Rajkot']['delta']['confirmed'].toString(),
                      distict['Rajkot']['deceased'].toString(),
                      distict['Rajkot']['delta']['deceased'].toString(),
                      distict['Rajkot']['recovered'].toString(),
                      distict['Rajkot']['delta']['recovered'].toString()),
                       ListCard(
                      "Sabar Kantha",
                      distict['Sabar Kantha']['active'].toString(),
                      distict['Sabar Kantha']['confirmed'].toString(),
                      distict['Sabar Kantha']['delta']['confirmed'].toString(),
                      distict['Sabar Kantha']['deceased'].toString(),
                      distict['Sabar Kantha']['delta']['deceased'].toString(),
                      distict['Sabar Kantha']['recovered'].toString(),
                      distict['Sabar Kantha']['delta']['recovered'].toString()),
                       ListCard(
                      "Surat",
                      distict['Surat']['active'].toString(),
                      distict['Surat']['confirmed'].toString(),
                      distict['Surat']['delta']['confirmed'].toString(),
                      distict['Surat']['deceased'].toString(),
                      distict['Surat']['delta']['deceased'].toString(),
                      distict['Surat']['recovered'].toString(),
                      distict['Surat']['delta']['recovered'].toString()),




                      ListCard(
                      "Tapi",
                      distict['Tapi']['active'].toString(),
                      distict['Tapi']['confirmed'].toString(),
                      distict['Tapi']['delta']['confirmed'].toString(),
                      distict['Tapi']['deceased'].toString(),
                      distict['Tapi']['delta']['deceased'].toString(),
                      distict['Tapi']['recovered'].toString(),
                      distict['Tapi']['delta']['recovered'].toString()),
                      ListCard(
                      "Vadodara",
                      distict['Vadodara']['active'].toString(),
                      distict['Vadodara']['confirmed'].toString(),
                      distict['Vadodara']['delta']['confirmed'].toString(),
                      distict['Vadodara']['deceased'].toString(),
                      distict['Vadodara']['delta']['deceased'].toString(),
                      distict['Vadodara']['recovered'].toString(),
                      distict['Vadodara']['delta']['recovered'].toString()),
                      ListCard(
                      "Valsad",
                      distict['Valsad']['active'].toString(),
                      distict['Valsad']['confirmed'].toString(),
                      distict['Valsad']['delta']['confirmed'].toString(),
                      distict['Valsad']['deceased'].toString(),
                      distict['Valsad']['delta']['deceased'].toString(),
                      distict['Valsad']['recovered'].toString(),
                      distict['Valsad']['delta']['recovered'].toString()),
                ],



              ),
      ),
    );
  }
}

Widget ListCard(String state, text1, text2, text3, text4, text5, text6, text7) {
  return InkWell(
    onTap: () {},
    child: Card(
      child: Column(
        children: <Widget>[
          Center(
              child: Text(
            state,
            style: GoogleFonts.openSans(
                fontSize: 16.0, fontWeight: FontWeight.bold),
          )),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Active \n  " + text1 + "\n",
                  style: GoogleFonts.openSans(color: Colors.red),
                ),
                Text(
                  "Confirmed \n  " + text2 + "\n [+" + text3 + "]",
                  style: GoogleFonts.openSans(color: Colors.green),
                ),
                Text(
                  "Deceased \n" + text4 + "\n [+" + text5 + "]",
                  style: GoogleFonts.openSans(color: Colors.blue),
                ),
                Text(
                  "Recovered \n" + text6 + "\n [+" + text7 + "]",
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
