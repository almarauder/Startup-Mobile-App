class DateParser {
  static final Map<String, int> _monthMap = {
    'Январь': 1,
    'Февраль': 2,
    'Март': 3,
    'Апрель': 4,
    'Май': 5,
    'Июнь': 6,
    'Июль': 7,
    'Август': 8,
    'Сентябрь': 9,
    'Октябрь': 10,
    'Ноябрь': 11,
    'Декабрь': 12,
  };

  static DateTime? parse(String dateStr) {
    try {
      final parts = dateStr.split(' ');
      if (parts.length != 3) return null;

      final day = int.parse(parts[0]);
      final month = _monthMap[parts[1]] ?? 1;
      final year = int.parse(parts[2]);

      return DateTime(year, month, day);
    } catch (e) {
      return null;
    }
  }
}
