import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab5_clean_architecture/application/use_cases/get_categories_use_case.dart';
import 'package:lab5_clean_architecture/application/use_cases/search_ads_use_case.dart';
import 'package:lab5_clean_architecture/injection.dart';
import 'package:lab5_clean_architecture/infrastructure/repositories/in_memory_ad_repository.dart';
import 'package:lab5_clean_architecture/presentation/providers/search_notifier.dart';
import 'package:lab5_clean_architecture/presentation/widgets/ad_card.dart';

void main() {
  group('SearchNotifier', () {
    test('фільтрує за категорією та ціною і повідомляє слухачів', () {
      const repository = InMemoryAdRepository();
      final search = SearchNotifier(
        searchAds: SearchAdsUseCase(repository),
        getCategories: GetCategoriesUseCase(repository),
        maxPrice: 25000,
      );
      var notified = 0;
      search.addListener(() => notified++);

      expect(search.filteredAds.length, 6);

      search.setCategory('Дім');
      expect(search.filteredAds.length, 2);

      search.setCategory(null);
      search.setPrice(const RangeValues(0, 5000));
      expect(search.filteredAds.length, 3);

      search.reset();
      expect(search.filteredAds.length, 6);
      expect(search.hasActiveFilters, isFalse);
      expect(notified, 4);
    });
  });

  group('UI', () {
    testWidgets('пошук фільтрує список оголошень', (tester) async {
      tester.view.physicalSize = const Size(400, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(buildApp());

      expect(find.text('Ноутбук Lenovo'), findsOneWidget);
      expect(find.text('iPhone 13, 128 GB'), findsOneWidget);
      expect(find.text('Знайдено оголошень: 6'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'iphone');
      await tester.pump();

      expect(find.text('iPhone 13, 128 GB'), findsOneWidget);
      expect(find.text('Ноутбук Lenovo'), findsNothing);
      expect(find.text('Знайдено оголошень: 1'), findsOneWidget);
    });

    testWidgets('обране оновлює бейдж в AppBar', (tester) async {
      tester.view.physicalSize = const Size(400, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(buildApp());

      await tester.tap(find.descendant(
        of: find.byType(AdCard).first,
        matching: find.byIcon(Icons.favorite_border),
      ));
      await tester.pump();

      expect(find.text('1'), findsOneWidget);
    });
  });
}
