import 'package:theta_widgets/src/elements/index.dart';
import 'package:theta_models/theta_models.dart';

class TetaWidgetState {
  const TetaWidgetState({
    required this.node,
    required this.forPlay,
    required this.loop,
    required this.params,
    required this.states,
    required this.dataset,
    required this.pageId,
    required this.isPage,
    required this.colorStyles,
    required this.textStyles,
    this.isVertical = true,
  });

  /// The original CNode
  final CNode node;

  /// Are we in Play Mode?
  final bool forPlay;

  /// The optional position inside a loop
  /// Widgets can be instantiate inside ListView.builder and other list widgets
  /// [loop] indicates the index position inside them
  final int? loop;

  /// The params of Scaffold
  final List<VariableObject> params;

  /// The states of Scaffold
  final List<VariableObject> states;

  /// The dataset list created by other widgets inside the same page
  final List<DatasetObject> dataset;

  final int pageId;
  final bool isPage;
  final List<ColorStyleModel> colorStyles;
  final List<TextStyleModel> textStyles;

  final bool isVertical;

  TetaWidgetState copyWith({
    final CNode? node,
    final bool? forPlay,
    final int? loop,
    final List<VariableObject>? params,
    final List<VariableObject>? states,
    final List<DatasetObject>? dataset,
    final bool? isVertical,
    final int? pageId,
    final bool? isPage,
    final List<ColorStyleModel>? colorStyles,
    final List<TextStyleModel>? textStyles,
  }) {
    return TetaWidgetState(
      node: node ?? this.node,
      forPlay: forPlay ?? this.forPlay,
      loop: loop ?? this.loop,
      params: params ?? this.params,
      states: states ?? this.states,
      dataset: dataset ?? this.dataset,
      isVertical: isVertical ?? this.isVertical,
      pageId: pageId ?? this.pageId,
      isPage: isPage ?? this.isPage,
      colorStyles: colorStyles ?? this.colorStyles,
      textStyles: textStyles ?? this.textStyles,
    );
  }

  String get toKey => '''
${node.nid}
$loop
''';
}
