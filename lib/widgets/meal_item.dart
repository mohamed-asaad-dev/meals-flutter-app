import 'package:flutter/material.dart';
import 'package:meals/screens/meal_details_screen.dart';
import 'package:meals/widgets/meal_item_traits.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/meals.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal});
  final Meal meal;

  String get formattedcomplexity {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get formattedAffordability {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  void onMealSelected(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) {
          return MealDetailsScreen(meal: meal);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(13),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          onMealSelected(context);
        },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: const Color.fromARGB(126, 0, 0, 0),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTraits(
                          icon: Icons.timer,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(width: 10),
                        MealItemTraits(
                          icon: Icons.work,
                          label: formattedcomplexity,
                        ),
                        const SizedBox(width: 10),
                        MealItemTraits(
                          icon: Icons.attach_money,
                          label: formattedAffordability,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
