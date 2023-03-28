// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:theta_models/src/models/variable.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/video.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/teta_open_classes/lib/src/nodes/categories.dart';
import 'package:teta_widgets/teta_open_classes/lib/src/nodes/children_enum.dart';
import 'package:teta_widgets/teta_open_classes/lib/src/nodes/enum.dart';
import 'package:teta_widgets/teta_open_classes/lib/src/nodes/node.dart';
import 'package:teta_widgets/teta_open_classes/lib/src/nodes/node_body.dart';
import 'package:teta_widgets/teta_open_classes/lib/src/nodes/suggestion.dart';
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
  suggestionsTitle: 'Why use Video in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use Video in Teta?',
      description: 'Test',
      linkToOpen: 'https://docs.teta.so/teta-docs/widget/basic-widgets/video',
    )
  ],
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
          valueType: VariableType.string,
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
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WVideo(
        ValueKey(
          '''
            ${state.toKey}
            ${child ?? children}
            ${(attributes[DBKeys.value] as FTextTypeInput? ?? FTextTypeInput()).toJson()}
            ${attributes[DBKeys.startAt] as int? ?? 0}
            ${attributes[DBKeys.showControls] as bool? ?? false}
            ${attributes[DBKeys.isFullWidth] as bool? ?? false}
            ${attributes[DBKeys.loopVideo] as bool? ?? false}
            ''',
        ),
        state: state,
        value: attributes[DBKeys.value] as FTextTypeInput? ??
            FTextTypeInput(value: 'K18cpp_-gP8'),
        startAt: attributes[DBKeys.startAt] as int? ?? 0,
        showControls: attributes[DBKeys.showControls] as bool? ?? false,
        showFullScreen: attributes[DBKeys.isFullWidth] as bool? ?? false,
        loopVideo: attributes[DBKeys.loopVideo] as bool? ?? false,
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
        VideoCodeTemplate.toCode(context, this, loop),
        loop ?? 0,
      );
}
