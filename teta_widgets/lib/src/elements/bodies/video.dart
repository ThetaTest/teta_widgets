// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/video.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/packages.dart';
import 'package:teta_widgets/src/elements/widgets/video.dart';

/// GlobalType for Video widget
const _globalType = NType.video;

/// IntrinsicStates for Video widget
final videoIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.video,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: ['video', 'youtube', 'player'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.basic,
  maxChildren: 0,
  canHave: ChildrenEnum.none,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [pYoutubePlayerIframe],
);

/// Body for Video widget
class VideoBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.value: FTextTypeInput(),
    DBKeys.startAt: 0,
    DBKeys.showControls: false,
    DBKeys.isFullWidth: false,
    DBKeys.loopVideo: false,
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          title: 'Video Id',
          type: ControlType.value,
          key: DBKeys.value,
          value: attributes[DBKeys.value],
        ),
        FlagControlObject(
          title: 'Show Controls',
          key: DBKeys.showControls,
          value: attributes[DBKeys.showControls],
          description:
              'Indicates whether the video player controls are displayed.',
        ),
        FlagControlObject(
          title: 'Full Screen',
          key: DBKeys.isFullWidth,
          value: attributes[DBKeys.isFullWidth],
          description: null,
        ),
        FlagControlObject(
          title: 'Looped',
          key: DBKeys.loopVideo,
          value: attributes[DBKeys.loopVideo],
          description:
              'Enables or disables the player to play the initial video again and again.',
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
  }) =>
      WVideo(
        ValueKey(
          '''
            ${node.nid}
            $loop
            ${child ?? children}
            ${(attributes[DBKeys.value] as FTextTypeInput? ?? FTextTypeInput()).toJson()}
            ${attributes[DBKeys.startAt] as int? ?? 0}
            ${attributes[DBKeys.showControls] as bool? ?? false}
            ${attributes[DBKeys.isFullWidth] as bool? ?? false}
            ${attributes[DBKeys.loopVideo] as bool? ?? false}
            ''',
        ),
        node: node,
        value: attributes[DBKeys.value] as FTextTypeInput? ??
            FTextTypeInput(value: 'K18cpp_-gP8'),
        startAt: attributes[DBKeys.startAt] as int? ?? 0,
        showControls: attributes[DBKeys.showControls] as bool? ?? false,
        showFullScreen: attributes[DBKeys.isFullWidth] as bool? ?? false,
        forPlay: forPlay,
        loop: loop,
        params: params,
        states: states,
        loopVideo: attributes[DBKeys.loopVideo] as bool? ?? false,
        dataset: dataset,
      );

  @override
  String toCode(
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final List<CNode>? children,
    final int pageId,
    final int? loop,
  ) =>
      videoCodeTemplate(context, this, loop);
}
