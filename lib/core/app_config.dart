/// Конфігурація застосунку. Єдине місце, де задаються налаштування,
/// спільні для шарів (використовується лише в composition root).
class AppConfig {
  const AppConfig._();

  static const String appName = 'Marketplace';

  /// Спосіб зберігання даних: `memory` (Dart-колекція) або `json` (JSON-рядок).
  static const String storage = 'memory';

  /// Верхня межа фільтра ціни: найдорожче оголошення в тестових даних — 21 000.
  static const double maxPrice = 22000;
}
