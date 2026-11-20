/// Сутність «Оголошення». Чистий Dart: жодних залежностей від Flutter,
/// бази даних чи UI.
class Ad {
  const Ad({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.time,
    required this.iconKey,
  });

  final int id;
  final String title;
  final int price;
  final String category;
  final String time;

  /// Ключ ілюстрації оголошення. Як саме він малюється (іконка, колір),
  /// вирішує шар Presentation.
  final String iconKey;
}
