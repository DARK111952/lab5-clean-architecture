import 'dart:convert';

import '../../domain/entities/ad.dart';
import '../../domain/repositories/ad_repository.dart';

/// Альтернативна реалізація [AdRepository]: читає оголошення з JSON-рядка.
/// Заміна [InMemoryAdRepository] на цей клас не вимагає змін у use cases.
class JsonAdRepository implements AdRepository {
  JsonAdRepository(String source) {
    final data = jsonDecode(source) as Map<String, dynamic>;
    _categories = List<String>.from(data['categories'] as List);
    _ads = [
      for (final item in data['ads'] as List)
        Ad(
          id: item['id'] as int,
          title: item['title'] as String,
          price: item['price'] as int,
          category: item['category'] as String,
          time: item['time'] as String,
          iconKey: item['iconKey'] as String,
        ),
    ];
  }

  late final List<String> _categories;
  late final List<Ad> _ads;

  /// Приклад вмісту сховища (замість файлу, щоб працювало і у web).
  static const String sample = '''
{
  "categories": ["Електроніка", "Транспорт", "Дім"],
  "ads": [
    {"id": 1, "title": "iPhone 13, 128 GB", "price": 18500, "category": "Електроніка", "time": "5 хв тому", "iconKey": "phone"},
    {"id": 2, "title": "Велосипед гірський", "price": 7200, "category": "Транспорт", "time": "1 год тому", "iconKey": "bike"},
    {"id": 3, "title": "Диван двомісний", "price": 4900, "category": "Дім", "time": "2 год тому", "iconKey": "sofa"},
    {"id": 4, "title": "Ноутбук Lenovo", "price": 21000, "category": "Електроніка", "time": "Сьогодні", "iconKey": "laptop"},
    {"id": 5, "title": "Навушники Sony", "price": 2300, "category": "Електроніка", "time": "Вчора", "iconKey": "headphones"},
    {"id": 6, "title": "Книжкова шафа", "price": 3100, "category": "Дім", "time": "2 дні тому", "iconKey": "bookshelf"}
  ]
}
''';

  @override
  List<Ad> getAll() => _ads;

  @override
  List<String> getCategories() => _categories;
}
