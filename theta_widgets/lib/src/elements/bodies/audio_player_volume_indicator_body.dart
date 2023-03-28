// Flutter imports:
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:theta_models/src/models/variable.dart';
import 'package:theta_widgets/src/core/teta_widget/index.dart';
import 'package:theta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:theta_widgets/src/elements/code/templates/audio_player_volume_indicator_template.dart';
import 'package:theta_widgets/src/elements/controls/control_model.dart';
import 'package:theta_widgets/src/elements/controls/key_constants.dart';
import 'package:theta_widgets/src/elements/controls/type.dart';
import 'package:theta_widgets/src/elements/features/text_type_input.dart';
import 'package:theta_widgets/src/elements/intrinsic_states/class.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/categories.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/children_enum.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/enum.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';
import 'package:theta_widgets/src/elements/packages.dart';
import 'package:theta_widgets/src/elements/widgets/w_audio_player_volume_indicator.dart';

const _globalType = NType.audioPlayerVolumeIndicator;

/// Audio Player Instrinsic State
final audioPlayerVolumeIndicatorIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.audioplayerVolumeidicator,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: [
    NodeType.name(_globalType),
  ],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.advanced,
  maxChildren: 0,
  canHave: ChildrenEnum.none,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [pRxDart],
);

/// Set of funcs to use Align widget
/// ```dart
/// Align({
///   Key? key,
///   AlignmentGeometry alignment,
///   double? widthFactor,
///   double? heightFactor,
///   Widget? child
/// })
/// ```
class AudioPlayerVolumeIndicatorBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.value: FTextTypeInput(type: FTextTypeEnum.state),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.audioController,
          key: DBKeys.value,
          value: attributes[DBKeys.value] as FTextTypeInput,
          valueType: VariableType.audioController,
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WAudioPlayerVolumeIndicator(
        ValueKey(
          '''
          ${state.toKey}
            ${child ?? children}
          ${(attributes[DBKeys.value] as FTextTypeInput).toJson()}, 
        ''',
        ),
        state: state,
        controller: attributes[DBKeys.value] as FTextTypeInput,
        child: child,
      );

  @override
  Future<String> toCode(
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final List<CNode>? children,
    final int pageId,
    final int? loop,
  ) =>
      CS.defaultWidgets(
        context,
        node,
        pageId,
        AudioPlayerVolumeIndicatorTemplate.toCode(
          context: context,
          audioPlayerName:
              ((attributes[DBKeys.value] as FTextTypeInput).stateName ?? '')
                  .camelCase,
        ),
        loop ?? 0,
      );
}
