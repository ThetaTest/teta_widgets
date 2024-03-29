// Flutter imports:
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_models/src/models/variable.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/code/templates/audio_player_template.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/packages.dart';

const _globalType = NType.audioPlayer;

/// Audio Player Instrinsic State
final audioPlayerIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.audioPlayer,
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
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [pJustAudio],
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
class AudioPlayerBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.value: FTextTypeInput(type: FTextTypeEnum.state),
    DBKeys.datasetInput: FDataset(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          title: 'Audio controller',
          type: ControlType.audioController,
          key: DBKeys.value,
          value: attributes[DBKeys.value] as FTextTypeInput,
          valueType: VariableType.audioController,
        ),
        ControlObject(
          title: 'Dataset song url field',
          type: ControlType.datasetType,
          key: DBKeys.datasetInput,
          value: attributes[DBKeys.datasetInput] as FDataset,
          valueType: VariableType.string,
          flag: true,
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) {
    return WAudioPlayer(
      ValueKey(
        '''
          ${state.toKey}
          ${child ?? children}
          ${(attributes[DBKeys.value] as FTextTypeInput).toJson()}, 
        ''',
      ),
      state: state,
      controller: attributes[DBKeys.value] as FTextTypeInput,
      selectedDataset: attributes[DBKeys.datasetInput] as FDataset,
      child: child,
    );
  }

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
        AudioPlayerTemplate.toCode(
          context: context,
          body: this,
          child: child,
          audioPlayerName:
              ((attributes[DBKeys.value] as FTextTypeInput).stateName ?? '')
                  .camelCase,
          songsDataSetToCode:
              (attributes[DBKeys.datasetInput] as FDataset).datasetName ?? '',
          urlKey:
              (attributes[DBKeys.datasetInput] as FDataset).datasetAttrName ??
                  '',
          currentSongDatasetName: node.name ?? node.intrinsicState.displayName,
        ),
        loop ?? 0,
      );
}
