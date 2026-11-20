import '../../domain/repositories/favorites_repository.dart';

/// Реалізація [FavoritesRepository], що тримає обране в пам'яті.
class InMemoryFavoritesRepository implements FavoritesRepository {
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
