import '../../domain/repositories/favorites_repository.dart';

/// Use case «Отримати обрані оголошення».
class GetFavoritesUseCase {
  const GetFavoritesUseCase(this._repository);

  final FavoritesRepository _repository;

  Set<int> call() => Set.unmodifiable(_repository.getAll());
}

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

/// Use case «Очистити обране».
class ClearFavoritesUseCase {
  const ClearFavoritesUseCase(this._repository);

  final FavoritesRepository _repository;

  void call() => _repository.clear();
}
