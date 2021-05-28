import 'package:flutter/material.dart';
import 'package:warganetsoshum/navigation_screen/daily_screen.dart';
import 'package:warganetsoshum/navigation_screen/event_screen.dart';
import 'package:warganetsoshum/navigation_screen/organization_screen.dart';
import 'package:warganetsoshum/navigation_screen/plan_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Beranda',
            style: TextStyle(
              color: Colors.grey[100]
            )
          ),
          backgroundColor: Colors.grey[900],
        ),
        body: SafeArea(
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: Text('Harian'),
                    onPressed: () {
                      Navigator.pushNamed(context, DailyScreen.id);
                    },
                  ),
                  SizedBox(),
                  ElevatedButton(
                    child: Text('Rencana'),
                    onPressed: () {
                      Navigator.pushNamed(context, PlanScreen.id);
                    },
                  ),
                  SizedBox(),
                  ElevatedButton(
                    child: Text('Acara'),
                    onPressed: () {
                      Navigator.pushNamed(context, EventScreen.id);
                    },
                  ),
                  SizedBox(),
                  ElevatedButton(
                    child: Text('Organisasi'),
                    onPressed: () {
                      Navigator.pushNamed(context, OrganizationScreen.id);
                    },
                  ),
                ],
              )
            )
          )
        )
      )
    );
  }
}