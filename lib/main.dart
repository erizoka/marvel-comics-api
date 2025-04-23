import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:marvel_comics/screens/home_screen.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 25);
    return MaterialApp(
      title: 'Marvel Comics API',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          primary: Colors.black,
          secondary: Color.fromRGBO(237, 29, 36, 1),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        textTheme: TextTheme(
          titleLarge: textStyle,
          titleMedium: textStyle,
          labelLarge: textStyle,
          labelMedium: textStyle,
          headlineLarge: textStyle,
          headlineMedium: textStyle,
          bodyLarge: textStyle,
          bodyMedium: textStyle,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Color.fromRGBO(237, 29, 36, 1),
          unselectedItemColor: Colors.white,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
