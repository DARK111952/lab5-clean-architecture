# Правила залежностей

- `domain` не імпортує нічого, крім Dart SDK (жодного Flutter, жодних інших шарів).
- `application` імпортує лише `domain`.
- `infrastructure` імпортує лише `domain`.
- `presentation` імпортує `application`, `domain` та Flutter/Provider.
- Тільки `lib/injection.dart` знає про всі шари одночасно.
