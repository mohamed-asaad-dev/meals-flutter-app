//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

enum Filter { glutenFree, lactoseFree, vegan, vegeterian }

class FavoritesNotifier extends StateNotifier<Map<Filter, bool>> {
  FavoritesNotifier()
    : super({
        Filter.glutenFree: false,
        Filter.lactoseFree: false,
        Filter.vegan: false,
        Filter.vegeterian: false,
      });

  void setFilters(Map<Filter, bool> newFilters) {
    state = newFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filtersProvider =
    StateNotifierProvider<FavoritesNotifier, Map<Filter, bool>>(
      (ref) => FavoritesNotifier(),
    );
