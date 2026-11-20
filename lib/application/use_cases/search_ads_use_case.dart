import '../../domain/entities/ad.dart';
import '../../domain/entities/ad_filter.dart';
import '../../domain/repositories/ad_repository.dart';

/// Use case «Знайти оголошення за фільтром».
/// Залежить лише від абстракції [AdRepository], а не від конкретного сховища.
class SearchAdsUseCase {
  const SearchAdsUseCase(this._repository);

  final AdRepository _repository;

  List<Ad> call(AdFilter filter) {
    return List.unmodifiable(_repository.getAll().where(filter.matches));
  }
}
