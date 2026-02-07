import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';

import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/main_drawer.dart';

import '../providers/favorites_provider.dart';
import '../providers/filters_provider.dart';

final Map<Filter, bool> kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegeterian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int currentIndex = 0;
  String title = 'Pick Category';
  //final List<Meal> _favoriteMeals = [];
  void onToggleSelected(String title) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
  }

  // void _toggleFavoriteSelected(Meal meal) {
  //   bool isFavorite = _favoriteMeals.contains(meal);
  //   if (isFavorite) {
  //     setState(() {
  //       _favoriteMeals.remove(meal);
  //       onToggleSelected('Item is removed from favorites');
  //     });
  //   } else if (!isFavorite) {
  //     setState(() {
  //       _favoriteMeals.add(meal);
  //       onToggleSelected('Item is Added to favorites');
  //     });
  //   }
  // }

  void _selectedIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void onSelectedDrawerItem(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      Navigator.push<Map<Filter, bool>>(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const FiltersScreen();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedFilters = ref.watch(filtersProvider);
    final availableMeals = dummyMeals.where((meal) {
      if (selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      } else if (selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      } else if (selectedFilters[Filter.vegeterian]! && !meal.isVegetarian) {
        return false;
      } else if (selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget content = CategoriesScreen(selectedMeals: availableMeals);
    if (currentIndex == 1) {
      content = MealsScreen(meals: ref.watch(favoriteMealsProvider));
      title = 'Favorites';
    } else {
      content = CategoriesScreen(selectedMeals: availableMeals);
      title = 'Pick Category';
    }
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawer: MainDrawer(onSelectedScreen: onSelectedDrawerItem),
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedIndex,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
