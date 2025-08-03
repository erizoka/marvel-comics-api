import 'package:flutter/material.dart';
import 'package:marvel_comics/provider/server_error_controller.dart';
import 'package:marvel_comics/screens/splash_screen.dart';
import 'package:provider/provider.dart';

class ServerUnavailable extends StatelessWidget {
  const ServerUnavailable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ServerErrorController>(
      context,
      listen: false,
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                'assets/images/web-1.png',
                alignment: Alignment.topRight,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                'assets/images/web-2.png',
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomLeft,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(
                  'Ops.. Marvel server is currently unavailable',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Image.asset('assets/images/oh-no.png'),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text(
                  'App can only work with\n the marvel servers online!\nThank you for your patience!',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  controller.resetError();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SplashScreen()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) =>
                        Theme.of(context).colorScheme.secondary,
                  ),
                ),
                child: Text(
                  'Restart',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
