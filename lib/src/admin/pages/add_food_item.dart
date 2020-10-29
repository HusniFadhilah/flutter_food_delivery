import 'package:flutter/material.dart';
import 'package:food_delivery/src/screens/main_screen.dart';
import '../../models/food_model.dart';
import '../../scoped_model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../widgets/button.dart';

class AddFoodItem extends StatefulWidget {
  @override
  _AddFoodItemState createState() => _AddFoodItemState();
}

class _AddFoodItemState extends State<AddFoodItem> {
  String name;
  String category;
  String description;
  String price;
  String discount;

  GlobalKey<FormState> _foodItemFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 16.0),
          // width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
          child: Form(
            key: _foodItemFormKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MainScreen()));
                  },
                  child: Icon(
                    Icons.home,
                    size: 30.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15.0),
                  width: MediaQuery.of(context).size.width,
                  height: 120.0,
                  decoration: BoxDecoration(
                    // color: Colors.black12,
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: AssetImage("assets/images/noimage.png"),
                    ),
                  ),
                ),
                _buildTextFormField("Food name"),
                _buildTextFormField("Category"),
                _buildTextFormField("Description", maxLine: 5),
                _buildTextFormField("Price"),
                _buildTextFormField("Discount"),
                SizedBox(
                  height: 70.0,
                ),
                ScopedModelDescendant(
                  builder:
                      (BuildContext context, Widget child, MainModel model) {
                    return GestureDetector(
                      onTap: () {
                        if (_foodItemFormKey.currentState.validate()) {
                          _foodItemFormKey.currentState.save();

                          final Food food = Food(
                            name: name,
                            category: category,
                            description: description,
                            price: double.parse(price),
                            discount: double.parse(discount),
                          );

                          model.addFood(food);
                        }
                      },
                      child: Button(
                        btnText: "Add Food Item",
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(String hint, {int maxLine = 1}) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "$hint",
      ),
      maxLines: maxLine,
      keyboardType: hint == "Price" || hint == "Discount"
          ? TextInputType.number
          : TextInputType.text,
      validator: (String value) {
        // String error
        var errorMsg;
        if (value.isEmpty && hint == "Food name") {
          errorMsg = "The food name is required";
        }
        if (value.isEmpty && hint == "Description") {
          errorMsg = "The description is required";
        }
        if (value.isEmpty && hint == "Category") {
          errorMsg = "The category is required";
        }

        if (value.isEmpty && hint == "Price") {
          errorMsg = "The price is required";
        }
        return errorMsg;
      },
      onChanged: (String value) {
        if (hint == "Food name") {
          name = value;
        }
        if (hint == "Category") {
          category = value;
        }
        if (hint == "Description") {
          description = value;
        }
        if (hint == "Price") {
          price = value;
        }
        if (hint == "Discount") {
          discount = value;
        }
      },
    );
  }
}
