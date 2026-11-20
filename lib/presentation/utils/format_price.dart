/// Форматує ціну з пропуском між розрядами: 18500 -> «₴ 18 500».
String formatPrice(num value) {
  final digits = value.round().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(' ');
    buffer.write(digits[i]);
  }
  return '₴ $buffer';
}
