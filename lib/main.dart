import 'package:corona/pages/contact.dart';
import 'package:corona/pages/homepage.dart';
import 'package:corona/pages/hospital.dart';
import 'package:corona/pages/recentNews.dart';
import 'package:corona/pages/notification.dart';
import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

void main() {
  runApp(Main());
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
    return MaterialApp(
      title: 'Corona',
      theme: ThemeData(brightness: Brightness.light),
      home: Scaffold(
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
          inkColor:
              Colors.black12, //optional, uses theme color if not specified
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
      ),
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
