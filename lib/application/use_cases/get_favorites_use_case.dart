import '../../domain/repositories/favorites_repository.dart';

/// Use case «Отримати обрані оголошення».
class GetFavoritesUseCase {
  const GetFavoritesUseCase(this._repository);

  final FavoritesRepository _repository;

  Set<int> call() => Set.unmodifiable(_repository.getAll());
}
