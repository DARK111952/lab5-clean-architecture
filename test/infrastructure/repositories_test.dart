import 'package:flutter_test/flutter_test.dart';
import 'package:lab5_clean_architecture/domain/repositories/ad_repository.dart';
import 'package:lab5_clean_architecture/infrastructure/repositories/in_memory_ad_repository.dart';
import 'package:lab5_clean_architecture/infrastructure/repositories/in_memory_favorites_repository.dart';
import 'package:lab5_clean_architecture/infrastructure/repositories/json_ad_repository.dart';

void main() {
  test('обидві реалізації AdRepository віддають однакові дані', () {
    final List<AdRepository> repos = [
      const InMemoryAdRepository(),
      JsonAdRepository(JsonAdRepository.sample),
    ];
    for (final repo in repos) {
      expect(repo.getAll().length, 6);
      expect(repo.getCategories(), ['Електроніка', 'Транспорт', 'Дім']);
    }
    expect(
      const InMemoryAdRepository().getAll().map((a) => a.title),
      JsonAdRepository(JsonAdRepository.sample).getAll().map((a) => a.title),
    );
  });

  test('InMemoryFavoritesRepository додає, прибирає та очищає', () {
    final repo = InMemoryFavoritesRepository();
    repo.add(1);
    repo.add(2);
    repo.remove(1);
    expect(repo.getAll(), {2});
    repo.clear();
    expect(repo.getAll(), isEmpty);
  });
}
