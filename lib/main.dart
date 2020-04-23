import 'package:corona/pages/hospital.dart';
import 'package:corona/pages/recentNews.dart';
import 'package:corona/pages/notification.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'dart:async';
import 'package:corona/model/total.dart';
import 'package:corona/pages/contact.dart';
import 'package:corona/pages/dist.dart';
import 'package:corona/pages/header.dart';
import 'package:corona/pages/states.dart';
import 'package:corona/service/fetchTotal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:share/share.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => new ThemeData(
              primarySwatch: Colors.indigo,
              brightness: brightness,
            ),
        themedWidgetBuilder: (context, theme) {
          return new MaterialApp(
            title: 'Flutter Demo',
            theme: theme,
            home: Main(),
          );
        });
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int currentIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = 0;
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        hoverColor: Colors.yellow,
        hoverElevation: 15.0,
        tooltip: "Connected",
        onPressed: () {
          //   Navigator.of(context).pushNamed('/contact');
        },
        child: Icon(
          Icons.network_wifi,
          size: 30.0,
          color: Colors.black,
        ),
        backgroundColor: Colors.green[400],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        //   backgroundColor: Colors.white12,
        opacity: .2,
        currentIndex: currentIndex,
        onTap: changePage,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        fabLocation: BubbleBottomBarFabLocation.end, //new
        hasNotch: true, //new
        hasInk: true, //new, gives a cute ink effect
        inkColor: Colors.black12, //optional, uses theme color if not specified
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.dashboard,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.dashboard,
                color: Colors.red,
              ),
              title: Text("Home")),
          BubbleBottomBarItem(
              backgroundColor: Colors.deepPurple,
              icon: Icon(
                Icons.access_time,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.access_time,
                color: Colors.deepPurple,
              ),
              title: Text("Update")),
          BubbleBottomBarItem(
              backgroundColor: Colors.indigo,
              icon: Icon(
                Icons.local_hospital,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.local_hospital,
                color: Colors.indigo,
              ),
              title: Text("Hospital")),
          BubbleBottomBarItem(
              backgroundColor: Colors.green,
              icon: Icon(
                Icons.notifications_active,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.notifications_active,
                color: Colors.green,
              ),
              title: Text("Notification"))
        ],
      ),
      body: _getPage(currentIndex),
    );
  }
}

_getPage(int page) {
  switch (page) {
    case 0:
      return HomePage();
    case 1:
      return News();
    case 2:
      return Hospital();
    case 3:
      return Notifications();
    default:
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("This is the basket page"),
        ],
      );
  }
}

//HomeeeeeeeePageeeeeeeeeeeeeeeeeeeeeeeeeee
//Homepage are staring from here Nikhil..........

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime now = DateTime.now();

  Future<Total> futureTotal;
  List data;
  var a, lu;
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
      try {
        var convert = json.decode(response.body);
        data = convert['statewise'];
        a = data[0];
        gj = data[3];
        lu = a['lastupdatedtime'];
      } catch (e) {
        print(e);
      }
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: new Text("nchaudhary12155@gmail.com"),
              accountName: new Text("Nikhil Chaudhary"),
              currentAccountPicture: new CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.transparent,
                backgroundImage: new NetworkImage(
                    "https://raw.githubusercontent.com/nikhil269/creart/master/assets/drawer.jpeg?token=AMCG7MTI7J7SXLOG65AFW5K6VLZDS"),
              ),
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      image: new NetworkImage(
                          "https://raw.githubusercontent.com/nikhil269/creart/master/assets/drawer.jpeg?token=AMCG7MTI7J7SXLOG65AFW5K6VLZDS"),
                      fit: BoxFit.fill)),
            ),
            ListTile(
              leading: Icon(
                Icons.contact_phone,
                size: 28,
                color: Colors.blue,
              ),
              title: Text('Helpline No',
                  style: GoogleFonts.openSans(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              onTap: () {
                // This line code will close drawer programatically....
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Contact()));
              },
            ),
            Divider(
              height: 2.0,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            Divider(
              height: 2.0,
            ),
            ListTile(
              leading: Icon(
                Icons.share,
                size: 28,
                color: Colors.blueGrey,
              ),
              title: Text(
                'Share',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                // This line code will close drawer programatically....
                final RenderBox box = context.findRenderObject();
                Share.share("www.nikhil.cf",
                    sharePositionOrigin:
                        box.localToGlobal(Offset.zero) & box.size);
              },
            ),
            Divider(
              height: 2.0,
            ),
            ListTile(
              leading: Icon(
                Icons.wb_sunny,
                size: 28,
                color: Colors.yellow,
              ),
              title: Text(
                'Dark Mode',
                style: TextStyle(fontSize: 18),
              ),
              onTap: changeBrightness,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        actions: <Widget>[
          InkWell(
              onTap: changeBrightness,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.wb_sunny,
                  color: Colors.yellow,
                  semanticLabel: "Dark Mode",
                ),
              )),
          // RaisedButton(
          //   color: Colors.transparent,
          //   onPressed: changeBrightness,
          //   child: const Icon(Icons.wb_sunny,color: Colors.yellow,),
          // ),
        ],
        //  backgroundColor: Colors.black87,
        title: Text(
          'Corona Live Count',
          style: GoogleFonts.openSans(),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Header(),
          (lu == null)
              ? Center(child: CupertinoActivityIndicator())
              : Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Contact()));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.47,
                          child: Card(
                            color: Colors.blue[200],
                            child: Center(
                                child: Text(
                              "Helpline No",
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            )),
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.47,
                        child: Card(
                          color: Colors.red[200],
                          child: Center(
                              child: Text(
                            "Last Update :\n" + lu,
                            style: GoogleFonts.openSans(
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      )
                    ],
                  ),
                ),
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
                      "",
                      now.toString());
                else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Center(child: CupertinoActivityIndicator());
              }),
          (a == null)
              ? Center(child: CupertinoActivityIndicator())
              : InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => States()));
                  },
                  child: DashboardCard(
                      context,
                      "India In",
                      a['confirmed'].toString(),
                      a['recovered'].toString(),
                      a['active'].toString(),
                      a['deaths'].toString(),
                      a['deltaconfirmed'].toString(),
                      a['deltadeaths'].toString(),
                      a['deltarecovered'].toString(),
                      a['lastupdatedtime'].toString()),
                ),
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
          (gj == null)
              ? Center(child: CupertinoActivityIndicator())
              : InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Dist()));
                  },
                  child: DashboardCard(
                      context,
                      gj['state'].toString(),
                      gj['confirmed'].toString(),
                      gj['recovered'].toString(),
                      gj['active'].toString(),
                      gj['deaths'].toString(),
                      gj['deltaconfirmed'].toString(),
                      gj['deltadeaths'].toString(),
                      gj['deltarecovered'].toString(),
                      gj['lastupdatedtime'].toString()),
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Dist()));
              },
              child: Card(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "Gujarat Districts",
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: MediaQuery.of(context).size.height / 8,
                            child: Image.network(
                                "https://pngimage.net/wp-content/uploads/2018/06/gujarat-map-png-1.png",
                                fit: BoxFit.cover)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => States()));
              },
              child: Card(
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "All States",
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: MediaQuery.of(context).size.height / 8,
                            child: Image.network(
                                "https://i.ya-webdesign.com/images/cartoon-home-png-5.png",
                                fit: BoxFit.cover)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }
}

Widget DashboardCard(BuildContext context, String title, text1, text2, text3,
    text4, text5, text6, text7, text8) {
  return Container(
    child: Card(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 7.0),
            child: Text(title + " " + "(" + text8 + ")",
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold, fontSize: 16.0)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
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
                ),
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
