/// Конфігурація застосунку. Єдине місце, де задаються налаштування,
/// спільні для шарів (використовується лише в composition root).
class AppConfig {
  const AppConfig._();

  static const String appName = 'Marketplace';

  /// Спосіб зберігання даних: `memory` (Dart-колекція) або `json` (JSON-рядок).
  static const String storage = 'memory';

  /// Верхня межа фільтра ціни (за вимогою замовника — до 30 000).
  /// Найдорожче оголошення в тестових даних — 21 000, тому межа з запасом.
  static const double maxPrice = 30000;
}
