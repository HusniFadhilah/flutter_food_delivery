import 'package:flutter/material.dart';
import 'package:food_delivery/src/models/food_model.dart';
import 'package:food_delivery/src/scoped_model/main_model.dart';
import 'package:food_delivery/src/widgets/food_item_card.dart';
import 'package:scoped_model/scoped_model.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 60.0),
        child: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
            model.fetchFoodsFromFirebase();
            List<Food> foodItem = model.foodItemFirebase;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "All Food Items",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  children: foodItem.map((Food foodItem) {
                    return FoodItemCard(foodItem.name, foodItem.description,
                        foodItem.price.toString());
                  }).toList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
