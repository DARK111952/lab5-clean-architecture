import 'package:flutter/material.dart';

import '../domain/entities/ad.dart';

/// Візуальне оформлення оголошення. Domain зберігає лише `iconKey`,
/// а іконка та колір — справа Presentation-шару.
class AdVisual {
  const AdVisual(this.icon, this.color);

  final IconData icon;
  final Color color;
}

const Map<String, AdVisual> _visuals = {
  'phone': AdVisual(Icons.phone_iphone, Color(0xFFD0BCFF)),
  'bike': AdVisual(Icons.pedal_bike, Color(0xFFB5E3C4)),
  'sofa': AdVisual(Icons.weekend, Color(0xFFFFD8A8)),
  'laptop': AdVisual(Icons.laptop_mac, Color(0xFFA8D8F0)),
  'headphones': AdVisual(Icons.headphones, Color(0xFFF5B7C5)),
  'bookshelf': AdVisual(Icons.menu_book, Color(0xFFE0E0A8)),
};

const AdVisual _fallback = AdVisual(Icons.sell, Color(0xFFE0E0E0));

AdVisual adVisualFor(Ad ad) => _visuals[ad.iconKey] ?? _fallback;
