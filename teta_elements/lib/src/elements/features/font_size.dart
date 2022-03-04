// ignore_for_file: public_member_api_docs

class FFontSize {
  /// Constructor
  FFontSize({
    this.size = 16,
  });

  /// Value of [size] of [FFontSize]
  double size;

  /// Get current value of [size]
  double get get => size;

  /// Instantiates [FFontSize] from Json
  FFontSize fromJson(dynamic json) {
    try {
      return FFontSize(
        size: double.tryParse('$json') != null ? double.parse('$json') : 16,
      );
    } catch (e) {
      return this;
    }
  }

  /// Returns double to Json
  double toJson() => size;

  /// Returns double for code
  String toCode() => size.toString();
}
