import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import '../models/food_model.dart';

class FoodModel extends Model {
  List<Food> _foods = [];

  List<Food> _foodItemFirebase = [];

  List<Food> get food {
    return List.from(_foods);
  }

  List<Food> get foodItemFirebase {
    return List.from(_foodItemFirebase);
  }

  void addFood(Food food) async {
    // _foods.add(food);
    final Map<String, dynamic> foodData = {
      "name": food.name,
      "description": food.description,
      "category": food.category,
      "price": food.price,
      "discount": food.discount,
    };
    final http.Response response = await http.post(
        "https://food-app-8ec39.firebaseio.com/foods.json",
        body: json.encode(foodData));
    final Map<String, dynamic> responseData = json.decode(response.body);

    Food foodWithID = Food(
      id: responseData["name"],
      name: food.name,
      description: food.description,
      category: food.category,
      discount: food.discount,
      price: food.price,
    );

    _foods.add(foodWithID);
  }

  void fetchFoods() {
    http
        .get("http://192.168.1.10/flutter_food_app/api/foods/getfoods.php")
        .then((http.Response response) {
      final List fetchedData = json.decode(response.body);
      final List<Food> fetchedFoodItems = [];
      fetchedData.forEach((data) {
        Food food = Food(
          id: data["id_food"],
          category: data["id_category"],
          name: data["name"],
          discount: double.parse(data["discount"]),
          imagePath: data["imagePath"],
          price: double.parse(data["price"]),
          ratings: double.parse(data["ratings"]),
        );

        fetchedFoodItems.add(food);
      });

      _foods = fetchedFoodItems;
    });
  }

  void fetchFoodsFromFirebase() {
    http
        .get("https://food-app-8ec39.firebaseio.com/foods.json")
        .then((http.Response response) {
      final Map<String, dynamic> fetchedData = json.decode(response.body);
      final List<Food> foodItems = [];
      fetchedData.forEach((String id, dynamic foodData) {
        Food foodItem = Food(
          id: id,
          category: foodData["category"],
          name: foodData["name"],
          discount: foodData["discount"],
          // imagePath: data["imagePath"],
          description: foodData["description"],
          price: foodData["price"],
          // ratings: double.parse(foodData["ratings"]),
        );

        foodItems.add(foodItem);
      });

      _foodItemFirebase = foodItems;
    });
  }
}
