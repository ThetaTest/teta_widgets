import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';

class TetaWidgetState {
  const TetaWidgetState({
    required this.node,
    required this.forPlay,
    required this.loop,
    required this.params,
    required this.states,
    required this.dataset,
  });

  final CNode node;
  final bool forPlay;
  final int? loop;
  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;
}
