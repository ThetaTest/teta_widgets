// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_models/src/models/variable.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/barcode.dart';

const _globalType = NType.barcode;

/// Instrict State of Align
final barcodeIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.barcode,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: [NodeType.name(_globalType), 'qrcode', 'code'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.unclassified,
  maxChildren: 0,
  canHave: ChildrenEnum.none,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [],
);

class BarcodeBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.value: FTextTypeInput(),
    DBKeys.image: FTextTypeInput(),
    DBKeys.width: FSize(size: '200'),
    DBKeys.height: FSize(size: '200'),
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
          title: 'Data',
          type: ControlType.value,
          key: DBKeys.value,
          value: attributes[DBKeys.value],
          valueType: VariableType.string,
        ),
        ControlObject(
          type: ControlType.barcode,
          key: DBKeys.image,
          value: attributes[DBKeys.image],
          valueType: VariableType.string,
        ),
        SizesControlObject(
          keys: const [
            DBKeys.width,
            DBKeys.height,
          ],
          values: [
            attributes[DBKeys.width] as FSize,
            attributes[DBKeys.height] as FSize,
          ],
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
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WBarcode(
        ValueKey(
          '''
          ${state.toKey}
          ${child ?? children}
          ${(attributes[DBKeys.value] as FTextTypeInput).toJson()}
          ${(attributes[DBKeys.image] as FTextTypeInput).toJson()}
          ${(attributes[DBKeys.width] as FSize).toJson()}
          ${(attributes[DBKeys.height] as FSize).toJson()}
          ${(attributes[DBKeys.fill] as FFill).toJson()}
        ''',
        ),
        state: state,
        child: child,
        data: attributes[DBKeys.value] as FTextTypeInput,
        barcodeType: attributes[DBKeys.image] as FTextTypeInput,
        width: attributes[DBKeys.width] as FSize,
        height: attributes[DBKeys.height] as FSize,
        fill: attributes[DBKeys.fill] as FFill,
      );

  //! TODO
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
        Future.value(''),
        loop ?? 0,
      );
}
