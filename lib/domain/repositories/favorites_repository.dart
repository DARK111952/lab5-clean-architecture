/// Контракт сховища «Обране».
abstract interface class FavoritesRepository {
  Set<int> getAll();

  void add(int adId);

  void remove(int adId);

  void clear();
}
