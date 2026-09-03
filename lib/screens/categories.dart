import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';
import "package:meals/models/category.dart";
import "package:meals/models/meal.dart";

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key , required this.onToggleFavorite});

  final void Function(Meal meal)? onToggleFavorite;

  void _selectCategory(BuildContext context, Category category) {
  final filteredMeals =  dummyMeals.where((meal) => meal.categories.contains(category.id)).toList();


    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(title: category.title, meals: filteredMeals , onToggleFavorite: onToggleFavorite,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            ),
          // Text("1" , style: TextStyle(color: Colors.white),),
          // Text("2" , style: TextStyle(color: Colors.white),),
          // Text("3" , style: TextStyle(color: Colors.white),),
          // Text("4" , style: TextStyle(color: Colors.white),),
          // Text("5" , style: TextStyle(color: Colors.white),),
          // Text("6" , style: TextStyle(color: Colors.white),),
        ],
    );
  }
}
