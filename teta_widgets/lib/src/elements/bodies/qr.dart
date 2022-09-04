// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/elements/code/templates/qr.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/packages.dart';
import 'package:teta_widgets/src/elements/widgets/qr.dart';

const _globalType = NType.qrCode;

/// Instrict State of Align
final qrIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.qrcode,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: [NodeType.name(_globalType), 'baseline', 'bottom'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.advanced,
  maxChildren: 0,
  canHave: ChildrenEnum.none,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [pQrFlutter],
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
class QRBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.value: FTextTypeInput(),
    DBKeys.image: FTextTypeInput(),
    DBKeys.flag: false,
    DBKeys.width: FSize(size: '250'),
    DBKeys.fill: FFill(
      levels: [
        FFillElement(
          color: 'ffffff',
          stop: 0,
        ),
      ],
    ),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          title: 'Content',
          type: ControlType.value,
          key: DBKeys.value,
          value: attributes[DBKeys.value],
        ),
        SizeControlObject(
          type: ControlType.size,
          key: DBKeys.width,
          title: 'Size',
          isWidth: true,
          value: attributes[DBKeys.width] as FSize,
        ),
        FillControlObject(
          title: 'Color',
          key: DBKeys.fill,
          value: attributes[DBKeys.fill] as FFill,
          isStyled: true,
          isImageEnabled: false,
          isNoneEnabled: false,
          isOnlySolid: true,
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
      WQR(
        ValueKey(
          '''
          ${node.nid}
          $loop
          ${child ?? children}
          ${(attributes[DBKeys.value] as FTextTypeInput).toJson()}
          ${(attributes[DBKeys.image] as FTextTypeInput).toJson()}
          ${attributes[DBKeys.flag] as bool}
          ${(attributes[DBKeys.width] as FSize).toJson()}
          ${(attributes[DBKeys.fill] as FFill).toJson()}
        ''',
        ),
        node: node,
        content: attributes[DBKeys.value] as FTextTypeInput,
        image: attributes[DBKeys.image] as FTextTypeInput,
        withImage: attributes[DBKeys.flag] as bool,
        size: attributes[DBKeys.width] as FSize,
        fill: attributes[DBKeys.fill] as FFill,
        forPlay: forPlay,
        loop: loop,
        params: params,
        states: states,
        dataset: dataset,
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
      qrCodeTemplate(context, this, child, loop);
}
