import '../../domain/entities/ad.dart';
import '../../domain/repositories/ad_repository.dart';

/// Реалізація [AdRepository], що зберігає оголошення в пам'яті.
class InMemoryAdRepository implements AdRepository {
  const InMemoryAdRepository();

  static const List<String> _categories = ['Електроніка', 'Транспорт', 'Дім'];

  static const List<Ad> _ads = [
    Ad(id: 1, title: 'iPhone 13, 128 GB', price: 18500, category: 'Електроніка', time: '5 хв тому', iconKey: 'phone'),
    Ad(id: 2, title: 'Велосипед гірський', price: 7200, category: 'Транспорт', time: '1 год тому', iconKey: 'bike'),
    Ad(id: 3, title: 'Диван двомісний', price: 4900, category: 'Дім', time: '2 год тому', iconKey: 'sofa'),
    Ad(id: 4, title: 'Ноутбук Lenovo', price: 21000, category: 'Електроніка', time: 'Сьогодні', iconKey: 'laptop'),
    Ad(id: 5, title: 'Навушники Sony', price: 2300, category: 'Електроніка', time: 'Вчора', iconKey: 'headphones'),
    Ad(id: 6, title: 'Книжкова шафа', price: 3100, category: 'Дім', time: '2 дні тому', iconKey: 'bookshelf'),
  ];

  @override
  List<Ad> getAll() => _ads;

  @override
  List<String> getCategories() => _categories;
}
