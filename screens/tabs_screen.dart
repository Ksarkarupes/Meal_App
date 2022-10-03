// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import '/screens/categories_screen.dart';
import '/screens/favourite_screen.dart';
import '../widgets/main_drawer.dart';

class TabScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;
  TabScreen(this.favouriteMeals);
  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>> _pages;
  int selectedPageIndex = 0;
  @override
  void initState() {
    _pages = [
      {'pages': CategoriesScreen(), 'title': 'Categories'},
      {'pages': FavouriteScreen(widget.favouriteMeals), 'title': 'Favourites'},
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[selectedPageIndex]['title'] as String,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      drawer: MainDrawer(),
      body: _pages[selectedPageIndex]['pages'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.category),
              label: 'Categories'),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }
}
