import '../../domain/repositories/favorites_repository.dart';

/// Use case «Очистити обране».
class ClearFavoritesUseCase {
  const ClearFavoritesUseCase(this._repository);

  final FavoritesRepository _repository;

  void call() => _repository.clear();
}
