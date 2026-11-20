import '../entities/ad.dart';

/// Контракт джерела оголошень. Оголошується в Domain, реалізується
/// в Infrastructure (інверсія залежностей).
abstract interface class AdRepository {
  List<Ad> getAll();

  List<String> getCategories();
}
