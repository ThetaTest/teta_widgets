// Flutter imports:
// ignore_for_file: public_member_api_docs

class FDelay {
  static Future action(final int delay) async {
    if (delay == 0) return;
    await Future<void>.delayed(Duration(milliseconds: delay));
  }

  static String toCode(final int delay) {
    if (delay == 0) return '';
    return '''
    await Future<void>.delayed(Duration(milliseconds: $delay));
    ''';
  }
}
