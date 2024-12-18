import 'package:it/Pages/selectSubjectMaster.dart';
import 'package:it/Pages/professor_screen.dart';
import 'package:it/Pages/regScreen.dart';
import 'package:it/Pages/start_lecture.dart';
import 'package:it/Pages/welcom.dart';
import 'package:flutter/material.dart';
import 'Pages/loginScreen.dart';
import 'Pages/selectSubjectesStudent.dart';
import 'Pages/studentscreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale("ar", "AE")],
      locale: const Locale("ar", "AE"),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/Login': (context) => LoginPage(),
        '/Register': (context) => RegisterPage(),
        '/Master-Screen': (context) => MasterScreen(),
        '/Student-Screen': (context) => StudentScreen(),
        '/Start-Lecture': (context) => StartLecture(),
        '/Select-Subjectes-Student': (context) => selectSubjectesStudent(),
        '/Select-Subjectes-Master': (context) => selectSubjectesMaster(),
      },
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Arial',
      ),
    );
  }
}
