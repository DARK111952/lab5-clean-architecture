import 'package:flutter_test/flutter_test.dart';
import 'package:lab5_clean_architecture/application/use_cases/clear_favorites_use_case.dart';
import 'package:lab5_clean_architecture/application/use_cases/get_favorites_use_case.dart';
import 'package:lab5_clean_architecture/application/use_cases/toggle_favorite_use_case.dart';
import 'package:lab5_clean_architecture/application/use_cases/get_categories_use_case.dart';
import 'package:lab5_clean_architecture/application/use_cases/search_ads_use_case.dart';
import 'package:lab5_clean_architecture/domain/entities/ad.dart';
import 'package:lab5_clean_architecture/domain/entities/ad_filter.dart';
import 'package:lab5_clean_architecture/domain/repositories/ad_repository.dart';
import 'package:lab5_clean_architecture/domain/repositories/favorites_repository.dart';

/// Тестові реалізації інтерфейсів Domain: use cases працюють лише через
/// абстракції, тому їм не потрібен реальний Infrastructure-шар.
class _FakeAdRepository implements AdRepository {
  @override
  List<Ad> getAll() => const [
        Ad(id: 1, title: 'iPhone', price: 18500, category: 'Електроніка', time: '', iconKey: 'phone'),
        Ad(id: 2, title: 'Диван', price: 4900, category: 'Дім', time: '', iconKey: 'sofa'),
        Ad(id: 3, title: 'Шафа', price: 3100, category: 'Дім', time: '', iconKey: 'bookshelf'),
      ];

  @override
  List<String> getCategories() => const ['Електроніка', 'Дім'];
}

class _FakeFavoritesRepository implements FavoritesRepository {
  final Set<int> _ids = {};

  @override
  Set<int> getAll() => _ids;

  @override
  void add(int adId) => _ids.add(adId);

  @override
  void remove(int adId) => _ids.remove(adId);

  @override
  void clear() => _ids.clear();
}

void main() {
  group('SearchAdsUseCase', () {
    final search = SearchAdsUseCase(_FakeAdRepository());

    test('без обмежень повертає всі оголошення', () {
      const filter = AdFilter(minPrice: 0, maxPrice: 25000);
      expect(search(filter).length, 3);
    });

    test('фільтрує за категорією, запитом і ціною', () {
      expect(
        search(const AdFilter(category: 'Дім', minPrice: 0, maxPrice: 25000)).length,
        2,
      );
      expect(
        search(const AdFilter(query: 'ШАФА', minPrice: 0, maxPrice: 25000)).single.id,
        3,
      );
      expect(search(const AdFilter(minPrice: 0, maxPrice: 4000)).single.id, 3);
    });
  });

  test('GetCategoriesUseCase повертає категорії зі сховища', () {
    expect(GetCategoriesUseCase(_FakeAdRepository())(), ['Електроніка', 'Дім']);
  });

  test('ToggleFavoriteUseCase додає та прибирає оголошення з обраного', () {
    final repo = _FakeFavoritesRepository();
    final toggle = ToggleFavoriteUseCase(repo);
    final getFavorites = GetFavoritesUseCase(repo);

    toggle(2);
    expect(getFavorites(), {2});
    toggle(2);
    expect(getFavorites(), isEmpty);

    toggle(1);
    ClearFavoritesUseCase(repo)();
    expect(getFavorites(), isEmpty);
  });
}
