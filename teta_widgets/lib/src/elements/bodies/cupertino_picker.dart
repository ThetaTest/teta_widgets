// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';

// Project imports:
import 'package:teta_widgets/src/elements/code/templates/cupertino_picker.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/action.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/cupertino_picker.dart';

const _globalType = NType.cupertinoPicker;

/// Instrict State of Cupertino Picker
final cupertinoPickerIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.cupertinoPicker,
  nodeVideo: null,
  nodeDescription: '''''',
  advicedChildren: [
    NodeType.name(NType.container),
    NodeType.name(NType.image),
  ],
  blockedTypes: [],
  synonymous: [
    'cupertino picker',
    'picker',
    'date',
    'cupertino',
  ],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.input,
  maxChildren: null,
  canHave: ChildrenEnum.children,
  addChildLabels: [],
  gestures: [
    ActionGesture.onChange,
  ],
);

/// Cupertino Picker's body
class CupertinoPickerBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.action: FAction(),
    DBKeys.flag: false,
    DBKeys.height: FSize(size: '44'),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.action,
          key: DBKeys.action,
          value: attributes[DBKeys.action],
        ),
        FlagControlObject(
          title: 'Looping',
          key: DBKeys.flag,
          value: attributes[DBKeys.flag],
          description: '',
        ),
        SizeControlObject(
          type: ControlType.size,
          key: DBKeys.height,
          title: 'Item Extent',
          isWidth: false,
          value: attributes[DBKeys.height] as FSize,
        ),
      ];

  @override
  Widget toWidget({
    required List<VariableObject> params,
    required List<VariableObject> states,
    required List<DatasetObject> dataset,
    required bool forPlay,
    required CNode node,
    int? loop,
    CNode? child,
    List<CNode>? children,
  }) =>
      WCupertinoPicker(
        ValueKey(
          '''
      ${node.nid}
      $loop
      ${child ?? children}
      ${attributes[DBKeys.flag] as bool}
      ${(attributes[DBKeys.height] as FSize).toJson()}
      ${(attributes[DBKeys.action] as FAction).toJson()}
      ''',
        ),
        node: node,
        children: children ?? <CNode>[],
        flag: attributes[DBKeys.flag] as bool,
        height: attributes[DBKeys.height] as FSize,
        forPlay: forPlay,
        loop: loop,
        action: attributes[DBKeys.action] as FAction,
        params: params,
        states: states,
        dataset: dataset,
      );

  @override
  String toCode(
    BuildContext context,
    CNode node,
    CNode? child,
    List<CNode>? children,
    int pageId,
    int? loop,
  ) =>
      cupertinoPickerCodeTemplate(context, this, node, children ?? []);
}
