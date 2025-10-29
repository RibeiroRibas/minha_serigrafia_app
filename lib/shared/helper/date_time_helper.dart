// dart
DateTime parseBrazilianDate(String date) {
  final parts = date.split('/');
  if (parts.length != 3) {
    throw FormatException('Invalid date format, expected dd/MM/yyyy', date);
  }

  final day = int.tryParse(parts[0]);
  final month = int.tryParse(parts[1]);
  final year = int.tryParse(parts[2]);

  if (day == null || month == null || year == null) {
    throw FormatException('Invalid numeric values in date', date);
  }

  return DateTime(year, month, day);
}

DateTime? tryParseBrazilianDate(String? date) {
  if (date == null) return null;
  final trimmed = date.trim();
  if (trimmed.isEmpty) return null;
  try {
    return parseBrazilianDate(trimmed);
  } catch (_) {
    return null;
  }
}
