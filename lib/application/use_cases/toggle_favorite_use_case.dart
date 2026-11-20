import '../../domain/repositories/favorites_repository.dart';

/// Use case «Додати/прибрати з обраного».
class ToggleFavoriteUseCase {
  const ToggleFavoriteUseCase(this._repository);

  final FavoritesRepository _repository;

  void call(int adId) {
    if (_repository.getAll().contains(adId)) {
      _repository.remove(adId);
    } else {
      _repository.add(adId);
    }
  }
}
