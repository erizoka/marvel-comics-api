import 'package:flutter/material.dart';
import 'package:marvel_comics/screens/characters/characters_list_screen.dart';
import 'package:marvel_comics/screens/comics/comics_list_screen.dart';
import 'package:marvel_comics/screens/favorite_screen.dart';
import 'package:marvel_comics/screens/multi_carousels_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (_index) {
      case 0:
        child = MultiCarouselsScreen();
        break;
      case 1:
        child = CharactersListScreen();
        break;
      case 2:
        child = ComicsListScreen();
        break;
      case 3:
        child = FavoriteScreen();
        break;
      default:
        child = MultiCarouselsScreen();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Image.asset('assets/images/Marvel-Logo.png', scale: 2),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SizedBox.expand(child: child),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (newIndex) => setState(() => _index = newIndex),
        currentIndex: _index,
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedFontSize: 17,
        selectedIconTheme: IconThemeData(size: 35),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Characters',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_sharp),
            label: 'Comics',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
