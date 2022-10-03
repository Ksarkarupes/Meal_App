// ignore_for_file: prefer_const_constructors

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import '/dummy_data.dart';
import '../main.dart';

class MealDealScreen extends StatelessWidget {
  static const routeName = '/meal-detail';
  final Function toogleName;
  final Function isfavourite;
  MealDealScreen(this.isfavourite, this.toogleName);
  Widget buildHeader(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as String;
    final selectedMeals =
        DUMMY_MEALS.firstWhere((meal) => meal.id == routeArgs);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            selectedMeals.title,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  selectedMeals.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              buildHeader(context, 'Ingredients'),
              buildContainer(
                ListView.builder(
                  itemBuilder: (ctx, index) => Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Text(selectedMeals.ingredients[index])),
                  ),
                  itemCount: selectedMeals.ingredients.length,
                ),
              ),
              buildHeader(context, 'Steps'),
              buildContainer(ListView.builder(
                itemBuilder: (ctx, index) => ListTile(
                  leading: CircleAvatar(
                    child: Text('# ${(index + 1)}'),
                  ),
                  title: Text(
                    selectedMeals.steps[index],
                  ),
                ),
                itemCount: selectedMeals.steps.length,
              )),
              Divider()
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            isfavourite(routeArgs) ? Icons.star : Icons.star_border,
          ),
          onPressed: () => toogleName(routeArgs),
        ));
  }
}
