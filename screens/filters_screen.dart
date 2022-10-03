import 'dart:ffi';

import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filter-screen';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;
  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    super.initState();
  }

  Widget _builSwitchTile(
      String title, String desc, bool currentVal, Function(bool) updateVal) {
    return SwitchListTile(
      title: Text(title),
      value: currentVal,
      subtitle: Text(desc),
      onChanged: updateVal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Filter Screen',
            style: Theme.of(context).textTheme.headline5,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  final filters = {
                    'gluten': _glutenFree,
                    'lactose': _lactoseFree,
                    'vegetarian': _vegetarian,
                    'vegan': _vegan,
                  };
                  widget.saveFilters(filters);
                },
                icon: Icon(Icons.save))
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
                child: ListView(
              children: <Widget>[
                _builSwitchTile(
                    'Gluten-Free', 'Only include gluten-free meal', _glutenFree,
                    (newVal) {
                  setState(() {
                    _glutenFree = newVal;
                  });
                }),
                _builSwitchTile('Lactose-Free',
                    'Only include lactose-free meal', _lactoseFree, (newVal) {
                  setState(() {
                    _lactoseFree = newVal;
                  });
                }),
                _builSwitchTile(
                    'Vegetarian', 'Only include vegetarian meal', _vegetarian,
                    (newVal) {
                  setState(() {
                    _vegetarian = newVal;
                  });
                }),
                _builSwitchTile('Vegan', 'Only include vegan meal', _vegan,
                    (newVal) {
                  setState(() {
                    _vegan = newVal;
                  });
                })
              ],
            ))
          ],
        ));
  }
}
