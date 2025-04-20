import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Image.asset('assets/images/Marvel-Logo.png', scale: 2),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      // body: CarouselSlider(items: items, options: options),
    );
  }
}
