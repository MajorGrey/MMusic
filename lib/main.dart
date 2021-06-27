import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:MusicApp/pages/welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MMusic',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
        ),
        primarySwatch: Colors.green,
        accentColor: Colors.green,
        canvasColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        highlightColor: Colors.green,
      ),
      home: WelcomeScreen(),
    );
  }
}
