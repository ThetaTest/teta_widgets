// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/elements/code/templates/audio_player_template.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/packages.dart';
import 'package:teta_widgets/src/elements/widgets/w_audio_player.dart';

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
    // DBKeys.audioPlayerCurrentDataset: FTextTypeInput(type: FTextTypeEnum.state),
    DBKeys.datasetInput: FDataset(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.audioController,
          key: DBKeys.value,
          value: attributes[DBKeys.value] as FTextTypeInput,
        ),
        // ControlObject(
        //   type: ControlType.audioPlayerCurrentDataset,
        //   key: DBKeys.audioPlayerCurrentDataset,
        //   value: attributes[DBKeys.audioPlayerCurrentDataset] as FTextTypeInput,
        // ),
        ControlObject(
          type: ControlType.datasetType,
          key: DBKeys.datasetInput,
          value: attributes[DBKeys.datasetInput] as FDataset,
          flag: true,
        ),
      ];

  @override
  Widget toWidget({
    required final List<VariableObject> params,
    required final List<VariableObject> states,
    required final List<DatasetObject> dataset,
    required final bool forPlay,
    required final CNode node,
    final int? loop,
    final CNode? child,
    final List<CNode>? children,
  }) {
    return WAudioPlayer(
      ValueKey(
        '''
          ${node.nid}
          $loop
            ${child ?? children}
          ${(attributes[DBKeys.value] as FTextTypeInput).get(params, states, dataset, forPlay, loop)}, 
        ''',
      ),
      controller: attributes[DBKeys.value] as FTextTypeInput,
      selectedDataset: attributes[DBKeys.datasetInput] as FDataset,
      node: node,
      child: child,
      forPlay: forPlay,
      loop: loop,
      params: params,
      states: states,
      dataset: dataset,
    );
  }

  @override
  String toCode(
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final List<CNode>? children,
    final int pageId,
    final int? loop,
  ) =>
      AudioPlayerTemplate.toCode(
        context: context,
        body: this,
        child: child,
        audioPlayerName:
            (attributes[DBKeys.value] as FTextTypeInput).stateName ?? '',
        songsDataSetToCode:
            (attributes[DBKeys.datasetInput] as FDataset).datasetName ?? '',
        urlKey:
            (attributes[DBKeys.datasetInput] as FDataset).datasetAttrName ?? '',
        currentSongDatasetName:
            node.name ?? node.intrinsicState.displayName ?? '',
      );
}
