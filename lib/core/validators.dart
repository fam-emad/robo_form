/// كل قواعد الفاليديشن في مكان واحد. كل دالة بترجع رسالة الخطأ أو null لو تمام.
/// بتتبعت لـ AppTextField في بارامتر `rule`، والقيمة جاية مقصوصة (trim) ومش فاضية.
class Validators {
  Validators._();

  static String? _twoNames(String v) =>
      v.split(RegExp(r'\s+')).length < 2 ? 'Enter at least two names' : null;

  static String? arabicName(String v) {
    if (!RegExp(r'^[\u0600-\u06FF\s]+$').hasMatch(v)) {
      return 'Use Arabic letters only';
    }
    return _twoNames(v);
  }

  static String? englishName(String v) {
    if (!RegExp(r"^[A-Za-z\s.'-]+$").hasMatch(v)) {
      return 'Use English letters only';
    }
    return _twoNames(v);
  }

  static String? nationalId(String v) {
    if (!RegExp(r'^\d+$').hasMatch(v)) return 'Digits only';
    if (v.length != 14) return 'Must be exactly 14 digits (${v.length} entered)';
    return null;
  }

  static String? digitsOnly(String v) =>
      RegExp(r'^\d+$').hasMatch(v) ? null : 'Digits only';

  static String? address(String v) =>
      v.length < 5 ? 'Address is too short' : null;

  static String? egyptianPhone(String v) =>
      RegExp(r'^01[0125]\d{8}$').hasMatch(v)
          ? null
          : 'Enter a valid Egyptian mobile (e.g. 01012345678)';

  static String? email(String v) =>
      RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$').hasMatch(v)
          ? null
          : 'Enter a valid email address (e.g. you@example.com)';

  static String? discord(String v) =>
      RegExp(r'^[a-z0-9_.]{2,32}$').hasMatch(v)
          ? null
          : 'Lowercase letters, numbers, _ and . only (2–32 chars)';

  static String? linkedin(String v) => RegExp(
              r'^(https?://)?(www\.)?linkedin\.com/(in|company)/[\w\-%]+/?$')
          .hasMatch(v)
      ? null
      : 'Enter a valid LinkedIn URL';

  static String? minLength(String v, [int n = 2]) =>
      v.length < n ? 'Too short' : null;
}
