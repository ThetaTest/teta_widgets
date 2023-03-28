class TetaActionLoop {
  const TetaActionLoop({
    required this.interval,
  });

  TetaActionLoop.fromJson(final Map<String, dynamic> json)
      : interval = json['interval'] as int;

  final int interval;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'interval': interval,
      };

  TetaActionLoop copyWith({final int? interval}) =>
      TetaActionLoop(interval: interval ?? this.interval);
}
