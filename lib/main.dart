import 'dart:io';
import 'package:corona/pages/hospitalbeds.dart';
import 'package:corona/pages/medicalclg.dart';
import 'package:corona/pages/sources.dart';
import 'package:corona/pages/supportproject.dart';
import 'package:corona/pages/supportpm.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
import 'package:corona/pages/world/countrywise.dart';
import 'package:corona/service/fetchTotal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:share/share.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:advanced_splashscreen/advanced_splashscreen.dart';

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
          return MaterialApp(
            theme: theme,
            home:
            AdvancedSplashScreen(
              appTitle: "Corona Live Tracking",
              child: Main(),
              seconds: 2,
              colorList: [
                Colors.white,
                Colors.white,
                Color(0xff9bcfff),
              ],
              appIcon: "assets/appicon.png",
            ),
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
        backgroundColor: Colors.white54,
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
//contact

  final String url1 = 'https://api.rootnet.in/covid19-in/contacts';
  var dataa;
  var main, main1;

  Future<String> getContact() async {
    var response = await http
        .get(Uri.encodeFull(url1), headers: {"Accept": "application.json"});
    setState(() {
      try {
        var convert = json.decode(response.body);
        main = convert['data'];
        main1 = main['contacts'];
        dataa = main1['primary'];
      } catch (e) {
        print(e);
      }
    });
    return "Success";
  }

  //contact

  //NO internet Dialog

  void _showDialog() {
    // dialog implementation
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("You are offline!", style: GoogleFonts.openSans()),
        content: Text("Please check your internet Connection",
            style: GoogleFonts.openSans()),
        actions: <Widget>[
          //  FlatButton(
          //     child: Text("Refresh"),
          //     onPressed: () {
          //       Navigator.pop(context);
          //     }),
          FlatButton(
              child: Text("Close", style: GoogleFonts.openSans()),
              onPressed: () {
                exit(0);
              })
        ],
      ),
    );
  }

  void _showUpdate() {
    // dialog implementation
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("OTA update is unavailable", style: GoogleFonts.openSans()),
        content: Text(
            "Please check www.download.nikhil.cf for newer update , We will push this feature in our next update \nThank You",
            style: GoogleFonts.openSans()),
        actions: <Widget>[
          //  FlatButton(
          //     child: Text("Refresh"),
          //     onPressed: () {
          //       Navigator.pop(context);
          //     }),
          FlatButton(
              child: Text("Close", style: GoogleFonts.openSans()),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }

  //No internet Dialog

  Future<Total> futureTotal;
  List data;
  var a, lu;
  var gj;
  final String url = 'https://api.covid19india.org/data.json';

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Are you sure?',
              style: GoogleFonts.openSans(),
            ),
            content: Text(
              'Do you want to exit an App',
              style: GoogleFonts.openSans(),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'No',
                  style: GoogleFonts.openSans(),
                ),
              ),
              FlatButton(
                onPressed: () => exit(0),
                /*Navigator.of(context).pop(true)*/
                child: Text(
                  'Yes',
                  style: GoogleFonts.openSans(),
                ),
              ),
            ],
          ),
        ) ??
        false;
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

  // String textValue = 'Hello World !';
  // FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     new FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    futureTotal = fetchTotal();
    this.getIndia();
    this.getContact();

    // Timer.run(() {
    //   try {
    //     InternetAddress.lookup('google.com').then((result) {
    //       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    //         print('connected');
    //       } else {
    //         _showDialog(); // show dialog
    //       }
    //     }).catchError((error) {
    //       _showDialog(); // show dialog
    //     });
    //   } on SocketException catch (_) {
    //     _showDialog();
    //     print('not connected'); // show dialog
    //   }
    // });

    // var android = new AndroidInitializationSettings('mipmap/ic_launcher');
    // var ios = new IOSInitializationSettings();
    // var platform = new InitializationSettings(android, ios);
    // flutterLocalNotificationsPlugin.initialize(platform);

    // firebaseMessaging.configure(
    //   onLaunch: (Map<String, dynamic> msg) {
    //     print(" onLaunch called ${(msg)}");
    //   },
    //   onResume: (Map<String, dynamic> msg) {
    //     print(" onResume called ${(msg)}");
    //   },
    //   onMessage: (Map<String, dynamic> msg) {
    //     showNotification(msg);
    //     print(" onMessage called ${(msg)}");
    //   },
    // );
    // firebaseMessaging.requestNotificationPermissions(
    //     const IosNotificationSettings(sound: true, alert: true, badge: true));
    // firebaseMessaging.onIosSettingsRegistered
    //     .listen((IosNotificationSettings setting) {
    //   print('IOS Setting Registed');
    // });
    // firebaseMessaging.getToken().then((token) {
    //   update(token);
    // });
  }

  // showNotification(Map<String, dynamic> msg) async {
  //   var android = new AndroidNotificationDetails(
  //     'sdffds dsffds',
  //     "CHANNLE NAME",
  //     "channelDescription",
  //   );
  //   var iOS = new IOSNotificationDetails();
  //   var platform = new NotificationDetails(android, iOS);
  //   await flutterLocalNotificationsPlugin.show(
  //       0, msg['notification']['title'], msg['notification']['body'], platform);
  // }

  // update(String token) {
  //   print(token);
  //   DatabaseReference databaseReference = new FirebaseDatabase().reference();
  //   databaseReference.child('fcm-token/${token}');
  //   textValue = token;
  //   setState(() {});
  // }

  // bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountEmail: InkWell(
                  onTap: () {
                    launch("https://www.instagram.com/nikhil.chaudhary269");
                  },
                  child: new Text("nchaudhary12155@gmail.com",
                      style: GoogleFonts.openSans(fontWeight: FontWeight.bold)),
                ),
                accountName: new Text("Corona Live Tracking",
                    style: GoogleFonts.openSans(fontWeight: FontWeight.bold)),
                currentAccountPicture: new CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.transparent,
                  backgroundImage: new AssetImage("assets/appicon.png"),
                ),
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                        image: new AssetImage("assets/drawer.jpeg"),
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
              ListTile(
                leading: Icon(
                  Icons.local_hospital,
                  size: 28,
                  color: Colors.red,
                ),
                title: Text('Hospitals and Beds',
                    style: GoogleFonts.openSans(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                onTap: () {
                  // This line code will close drawer programatically....
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HospitalBed()));
                },
              ),
              Divider(
                height: 2.0,
              ),
              ListTile(
                leading: Icon(
                  Icons.school,
                  size: 28,
                  color: Colors.teal,
                ),
                title: Text('Medical Collages',
                    style: GoogleFonts.openSans(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                onTap: () {
                  // This line code will close drawer programatically....
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MediClg()));
                },
              ),
              Divider(
                height: 2.0,
              ),
              ListTile(
                leading: Icon(
                  Icons.data_usage,
                  size: 28,
                  color: Colors.orange,
                ),
                title: Text('Sources',
                    style: GoogleFonts.openSans(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                onTap: () {
                  // This line code will close drawer programatically....
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Sources()));
                },
              ),
              Divider(
                height: 2.0,
              ),
              ListTile(
                leading: Icon(
                  Icons.attach_money,
                  size: 28,
                  color: Colors.pink,
                ),
                title: Text('Support PMCARE',
                    style: GoogleFonts.openSans(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                onTap: () {
                  // This line code will close drawer programatically....
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SupportPM()));
                },
              ),
              Divider(
                height: 2.0,
              ),
              ListTile(
                leading: Icon(
                  Icons.attach_money,
                  size: 28,
                  color: Colors.pink,
                ),
                title: Text('Support Project',
                    style: GoogleFonts.openSans(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                onTap: () {
                  // This line code will close drawer programatically....
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Support()));
                },
              ),
              Divider(
                height: 2.0,
              ),
              ListTile(
                leading: Icon(
                  Icons.feedback,
                  size: 28,
                  color: Colors.deepPurple,
                ),
                title: Text('Feedback',
                    style: GoogleFonts.openSans(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                onTap: () {
                  launch("https://forms.gle/48uBrhyQooqGULpG9");
                },
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
                  Share.share(
                      "I am using corona  live tracking! This app is awesome! You should try it to install: \n http://download.nikhil.cf/  \n હું કોરોના લાઇવ ટ્રેકિંગનો ઉપયોગ કરું છું! આ એપ્લિકેશન અદ્ભુત છે! તમારે તેને ઇન્સ્ટોલ કરવા માટે પ્રયાસ કરવો જોઈએ: \n http://download.nikhil.cf/",
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
                  color: Colors.yellow[700],
                ),
                title: Text(
                  'Dark Mode',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: changeBrightness,
              ),
              Divider(
                height: 2.0,
              ),
              ListTile(
                leading: Icon(
                  Icons.system_update,
                  size: 28,
                  color: Colors.black,
                ),
                title: Text(
                  'OTA update',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: _showUpdate,
              ),
              Divider(
                height: 2.0,
              ),
              ListTile(
                title: Center(
                    child: Text(
                  "Made In India ❤️",
                  style: GoogleFonts.openSans(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                )),
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
                    color: Colors.yellow[700],
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
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
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
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CountryWise()));
                      },
                      child: DashboardCard(
                          context,
                          "World Wide",
                          snapshot.data.cases.toString(),
                          snapshot.data.recovered.toString(),
                          snapshot.data.active.toString(),
                          snapshot.data.deaths.toString(),
                          snapshot.data.todayCases.toString(),
                          snapshot.data.todayDeaths.toString(),
                          "",
                          now.toString()),
                    );
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CountryWise()));
                      },
                      child: RoolingCard(context, "Country Wise")),
                  InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => States()));
                      },
                      child: RoolingCard(context, "State Wise")),
                  InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => States()));
                      },
                      child: RoolingCard(context, "District Wise (Gujarat)"))
                ],
              ),
            ),

//CONTACTSSSSSSSSSSSSSSSSSSSSSSSS

            SizedBox(
              height: 5.0,
            ),
            (dataa == null)
                ? CupertinoActivityIndicator()
                : Container(
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Text(
                              "Primary Contact",
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold, fontSize: 22.0),
                            ),
                          ),
                          Divider(),
                          Center(
                            child: Text(
                              "Number 📱: " + dataa['number'].toString(),
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Number TollFree ☎️: " +
                                  dataa['number-tollfree'].toString(),
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Email 📧: " + dataa['email'].toString(),
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  launch("https://wa.me/919013353535?text=Hi");
                                },
                                child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    child: Image.network(
                                        "https://www.searchpng.com/wp-content/uploads/2018/12/Splash-Whatsapp-Icon-Png-715x715.png",
                                        fit: BoxFit.contain)),
                              ),
                              InkWell(
                                onTap: () {
                                  launch(dataa['twitter'].toString());
                                },
                                child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    child: Image.network(
                                        "https://pngimg.com/uploads/twitter/twitter_PNG9.png",
                                        fit: BoxFit.contain)),
                              ),
                              InkWell(
                                onTap: () {
                                  launch(dataa['facebook'].toString());
                                },
                                child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    child: Image.network(
                                        "https://cdn.iconscout.com/icon/free/png-512/facebook-logo-2019-1597680-1350125.png",
                                        fit: BoxFit.contain)),
                              ),
                              InkWell(
                                onTap: () {
                                  launch("https://t.me/MyGovCoronaNewsdesk");
                                },
                                child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    child: Image.network(
                                        "https://pngimg.com/uploads/telegram/telegram_PNG34.png",
                                        fit: BoxFit.contain)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
          ],
        ),
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

Widget RoolingCard(BuildContext context, String title) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.08,
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              Icons.graphic_eq,
              color: Colors.red,
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              title,
              style: GoogleFonts.openSans(
                  fontSize: 20.0, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    ),
  );
}
