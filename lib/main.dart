import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:warganetsoshum/main_screen/login_screen.dart';
import 'package:warganetsoshum/navigation_screen/organization_screen.dart';
import 'package:warganetsoshum/navigation_screen/plan_screen.dart';
import 'main_screen/home_screen.dart';
import 'navigation_screen/event_screen.dart';
import 'navigation_screen/daily_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LoginScreen());
}

class WarganetSoshum extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        DailyScreen.id: (context) => DailyScreen(),
        EventScreen.id: (context) => EventScreen(),
        OrganizationScreen.id: (context) => OrganizationScreen(),
        PlanScreen.id: (context) => PlanScreen()
      },
    );  
  }
} 