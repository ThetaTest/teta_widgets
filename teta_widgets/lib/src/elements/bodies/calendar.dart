// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/calendar.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/action.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/index.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/permissions.dart';
import 'package:teta_widgets/src/elements/features/border_radius.dart';
import 'package:teta_widgets/src/elements/features/dataset.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/margins.dart';
import 'package:teta_widgets/src/elements/features/shadow.dart';
import 'package:teta_widgets/src/elements/features/text_style.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/calendar.dart';

const _globalType = NType.calendar;

/// Instrict State of Calendar
final calendarIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.calendar,
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
  addChildLabels: ['Add Day Builder', 'Add Month Builder'],
  gestures: [
    ActionGesture.onMonthLoaded,
    ActionGesture.onDayPressed,
  ],
  permissions: [
    Permissions.calendar,
  ],
  packages: ['paged_vertical_calendar'],
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
class CalendarBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.datasetInput: FDataset(),
    DBKeys.action: FAction(),
    DBKeys.textStyle: FTextStyle(),
    DBKeys.textStyle2: FTextStyle(),
    DBKeys.margins: FMargins(),
    DBKeys.padding: FMargins(),
    DBKeys.borderRadius: FBorderRadius(),
    DBKeys.shadows: FShadow(),
    DBKeys.fill: FFill(type: FFillType.none),
    DBKeys.bgFill: FFill(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          title: 'Field to fetch events',
          type: ControlType.datasetType,
          key: DBKeys.datasetInput,
          value: attributes[DBKeys.datasetInput],
          flag: true,
        ),
        ControlObject(
          type: ControlType.action,
          key: DBKeys.action,
          value: attributes[DBKeys.action],
        ),
        ControlObject(
          title: 'Title Properties',
          type: ControlType.text,
          key: DBKeys.textStyle2,
          value: attributes[DBKeys.textStyle2],
        ),
        ControlObject(
          type: ControlType.text,
          key: DBKeys.textStyle,
          value: attributes[DBKeys.textStyle],
        ),
        ControlObject(
          type: ControlType.margins,
          key: DBKeys.margins,
          value: attributes[DBKeys.margins],
        ),
        ControlObject(
          type: ControlType.padding,
          key: DBKeys.padding,
          value: attributes[DBKeys.padding],
        ),
        FillControlObject(
          title: 'Background',
          key: DBKeys.fill,
          value: attributes[DBKeys.fill] as FFill,
          isImageEnabled: false,
          isNoneEnabled: true,
          isOnlySolid: false,
          isStyled: false,
        ),
        FillControlObject(
          title: 'Highlight Background',
          key: DBKeys.bgFill,
          value: attributes[DBKeys.bgFill] as FFill,
          isImageEnabled: false,
          isNoneEnabled: true,
          isOnlySolid: false,
          isStyled: false,
        ),
        ControlObject(
          type: ControlType.borderRadius,
          key: DBKeys.borderRadius,
          value: attributes[DBKeys.borderRadius],
        ),
        ControlObject(
          type: ControlType.shadows,
          key: DBKeys.shadows,
          value: attributes[DBKeys.shadows],
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
      WCalendar(
        ValueKey(
          '''
          ${node.nid}
          $loop
            ${child ?? children}
            ${(attributes[DBKeys.action] as FAction).toJson()}, 
            ${(attributes[DBKeys.datasetInput] as FDataset).toJson()}, 
            ${(attributes[DBKeys.textStyle] as FTextStyle).toJson()},
            ${(attributes[DBKeys.textStyle2] as FTextStyle).toJson()},
            ${(attributes[DBKeys.margins] as FMargins).toJson()},
            ${(attributes[DBKeys.padding] as FMargins).toJson()},
            ${(attributes[DBKeys.borderRadius] as FBorderRadius).toJson()},
            ${(attributes[DBKeys.shadows] as FShadow).toJson()},
            ${(attributes[DBKeys.fill] as FFill).toJson()},
            ${(attributes[DBKeys.bgFill] as FFill).toJson()},
            ''',
        ),
        node: node,
        children: children ?? <CNode>[],
        value: attributes[DBKeys.datasetInput] as FDataset,
        action: attributes[DBKeys.action] as FAction,
        textStyle: attributes[DBKeys.textStyle] as FTextStyle,
        textStyle2: attributes[DBKeys.textStyle2] as FTextStyle,
        margins: attributes[DBKeys.margins] as FMargins,
        padding: attributes[DBKeys.padding] as FMargins,
        borderRadius: attributes[DBKeys.borderRadius] as FBorderRadius,
        shadows: attributes[DBKeys.shadows] as FShadow,
        fill: attributes[DBKeys.fill] as FFill,
        fill2: attributes[DBKeys.bgFill] as FFill,
        forPlay: forPlay,
        loop: loop,
        params: params,
        states: states,
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
      calendarCodeTemplate(pageId, context, node, child, loop ?? 0);
}
