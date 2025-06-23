import 'package:flutter/material.dart';
import 'package:marvel_comics/provider/favorites_provider.dart';
import 'package:marvel_comics/screens/home_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showBlackLogo = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        _showBlackLogo = true;
      });
    });

    Future.delayed(const Duration(seconds: 4), () async {
      final provider = Provider.of<FavoritesProvider>(context, listen: false);
      await provider.loadFavorites();

      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedOpacity(
            opacity: _showBlackLogo ? 0 : 1,
            duration: const Duration(seconds: 1),
            child: Image.asset(
              'assets/images/splash-screen-1.png',
              fit: BoxFit.fill,
            ),
          ),
          AnimatedOpacity(
            opacity: _showBlackLogo ? 1 : 0,
            duration: const Duration(seconds: 1),
            child: Image.asset(
              'assets/images/splash-screen-2.png',
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
