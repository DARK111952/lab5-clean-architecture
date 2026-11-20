import 'ad.dart';

/// Параметри пошуку оголошень (value object).
class AdFilter {
  const AdFilter({
    this.query = '',
    this.category,
    required this.minPrice,
    required this.maxPrice,
  }) : assert(minPrice <= maxPrice, 'minPrice не може перевищувати maxPrice');

  final String query;
  final String? category;
  final double minPrice;
  final double maxPrice;

  /// Бізнес-правило: чи підходить оголошення під цей фільтр.
  bool matches(Ad ad) {
    final q = query.toLowerCase();
    final matchesQuery = q.isEmpty || ad.title.toLowerCase().contains(q);
    final matchesCategory = category == null || ad.category == category;
    final matchesPrice = ad.price >= minPrice && ad.price <= maxPrice;
    return matchesQuery && matchesCategory && matchesPrice;
  }
}
