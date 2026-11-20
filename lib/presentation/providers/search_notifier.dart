import 'package:flutter/material.dart';

import '../../application/use_cases/get_categories_use_case.dart';
import '../../application/use_cases/search_ads_use_case.dart';
import '../../domain/entities/ad.dart';
import '../../domain/entities/ad_filter.dart';

/// Стан пошуку та фільтрів (варіант 13, маркетплейс оголошень).
///
/// Presentation-шар не знає, звідки беруться дані: вибірку виконує
/// use case, а Notifier лише зберігає параметри фільтра та сповіщає UI.
class SearchNotifier extends ChangeNotifier {
  SearchNotifier({
    required SearchAdsUseCase searchAds,
    required GetCategoriesUseCase getCategories,
    this.minPrice = 0,
    required this.maxPrice,
  })  : _searchAds = searchAds,
        _categories = getCategories(),
        _price = RangeValues(minPrice, maxPrice);

  final SearchAdsUseCase _searchAds;
  final List<String> _categories;

  final double minPrice;
  final double maxPrice;

  String _query = '';
  String? _category;
  RangeValues _price;

  // ---- Геттери (тільки читання) ----
  String get query => _query;
  String? get category => _category;
  RangeValues get price => _price;
  List<String> get categories => _categories;

  bool get priceFilterActive => _price.start > minPrice || _price.end < maxPrice;

  bool get hasActiveFilters =>
      _query.isNotEmpty || _category != null || priceFilterActive;

  /// Оголошення, що відповідають пошуку, категорії та діапазону ціни.
  List<Ad> get filteredAds => _searchAds(
        AdFilter(
          query: _query,
          category: _category,
          minPrice: _price.start,
          maxPrice: _price.end,
        ),
      );

  // ---- Методи зміни стану ----
  void setQuery(String value) {
    final trimmed = value.trim();
    if (trimmed == _query) return;
    _query = trimmed;
    notifyListeners();
  }

  void setCategory(String? category) {
    if (category == _category) return;
    _category = category;
    notifyListeners();
  }

  void setPrice(RangeValues values) {
    if (values == _price) return;
    _price = values;
    notifyListeners();
  }

  void reset() {
    _query = '';
    _category = null;
    _price = RangeValues(minPrice, maxPrice);
    notifyListeners();
  }
}
