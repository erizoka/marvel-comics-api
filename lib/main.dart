import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:marvel_comics/provider/favorites_provider.dart';
import 'package:marvel_comics/screens/splash_screen.dart';
import 'package:provider/provider.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    ChangeNotifierProvider(
      create: (_) => FavoritesProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontFamily: 'PlusJakartaSans',
    );
    return MaterialApp(
      title: 'Marvel Comics',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          primary: Colors.black,
          secondary: Color.fromRGBO(237, 29, 36, 1),
          tertiary: const Color.fromARGB(255, 248, 244, 244),
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
      home: const SplashScreen(),
    );
  }
}
