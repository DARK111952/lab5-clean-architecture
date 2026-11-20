import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'application/use_cases/clear_favorites_use_case.dart';
import 'application/use_cases/get_categories_use_case.dart';
import 'application/use_cases/get_favorites_use_case.dart';
import 'application/use_cases/search_ads_use_case.dart';
import 'application/use_cases/toggle_favorite_use_case.dart';
import 'core/app_config.dart';
import 'domain/repositories/ad_repository.dart';
import 'domain/repositories/favorites_repository.dart';
import 'infrastructure/repositories/in_memory_ad_repository.dart';
import 'infrastructure/repositories/in_memory_favorites_repository.dart';
import 'infrastructure/repositories/json_ad_repository.dart';
import 'presentation/app.dart';
import 'presentation/providers/favorites_notifier.dart';
import 'presentation/providers/search_notifier.dart';

/// Composition root: єдине місце, де шари збираються докупи (Dependency
/// Injection). Конкретні репозиторії створюються тут і передаються у use cases
/// через конструктор; решта коду бачить лише інтерфейси Domain.
///
/// Параметри дозволяють підставити інше сховище (наприклад, у тестах).
Widget buildApp({
  AdRepository? adRepository,
  FavoritesRepository? favoritesRepository,
}) {
  final ads = adRepository ?? _createAdRepository();
  final favorites = favoritesRepository ?? InMemoryFavoritesRepository();

  final searchAds = SearchAdsUseCase(ads);
  final getCategories = GetCategoriesUseCase(ads);
  final getFavorites = GetFavoritesUseCase(favorites);
  final toggleFavorite = ToggleFavoriteUseCase(favorites);
  final clearFavorites = ClearFavoritesUseCase(favorites);

  return MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => SearchNotifier(
          searchAds: searchAds,
          getCategories: getCategories,
          maxPrice: AppConfig.maxPrice,
        ),
      ),
      ChangeNotifierProvider(
        create: (_) => FavoritesNotifier(
          getFavorites: getFavorites,
          toggleFavorite: toggleFavorite,
          clearFavorites: clearFavorites,
        ),
      ),
    ],
    child: const MyApp(),
  );
}

/// Вибір реалізації сховища за налаштуванням [AppConfig.storage].
AdRepository _createAdRepository() {
  if (AppConfig.storage == 'json') {
    return JsonAdRepository(JsonAdRepository.sample);
  }
  return const InMemoryAdRepository();
}
