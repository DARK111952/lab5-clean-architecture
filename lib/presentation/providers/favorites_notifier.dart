import 'package:flutter/foundation.dart';

import '../../application/use_cases/clear_favorites_use_case.dart';
import '../../application/use_cases/get_favorites_use_case.dart';
import '../../application/use_cases/toggle_favorite_use_case.dart';

/// Стан «Обране». Усі зміни виконують use cases, Notifier лише сповіщає UI.
class FavoritesNotifier extends ChangeNotifier {
  FavoritesNotifier({
    required GetFavoritesUseCase getFavorites,
    required ToggleFavoriteUseCase toggleFavorite,
    required ClearFavoritesUseCase clearFavorites,
  })  : _getFavorites = getFavorites,
        _toggleFavorite = toggleFavorite,
        _clearFavorites = clearFavorites;

  final GetFavoritesUseCase _getFavorites;
  final ToggleFavoriteUseCase _toggleFavorite;
  final ClearFavoritesUseCase _clearFavorites;

  Set<int> get ids => _getFavorites();
  int get count => ids.length;

  bool isFavorite(int id) => ids.contains(id);

  void toggle(int id) {
    _toggleFavorite(id);
    notifyListeners();
  }

  void clear() {
    if (ids.isEmpty) return;
    _clearFavorites();
    notifyListeners();
  }
}
