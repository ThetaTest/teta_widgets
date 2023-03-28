// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:theta_models/src/models/variable.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/templates/calendarv2.dart';
import 'package:teta_widgets/src/elements/constants_export.dart';
// Project imports:
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
import 'package:teta_widgets/src/elements/nodes/suggestion.dart';
import 'package:teta_widgets/src/elements/packages.dart';
import 'package:teta_widgets/src/elements/widgets/calendarv2.dart';

import '../index.dart';

const _globalType = NType.calendarV2;

/// Instrict State of CalendarV2
final calendarV2IntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.calendar,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: [NodeType.name(_globalType), 'baseline', 'bottom', 'calendar'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.advanced,
  maxChildren: 0,
  canHave: ChildrenEnum.none,
  addChildLabels: [
    // 'Add Day Builder', 'Add Month Builder'
  ],
  gestures: [
    // ActionGesture.onMonthLoaded,
    ActionGesture.onDayPressed,
  ],
  permissions: [
    Permissions.calendar,
  ],
  packages: [pTableCalendar, pIntl],
  suggestionsTitle: 'Why use CalendarV2 in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use CalendarV2 in Teta?',
      description: 'Test',
      linkToOpen:
          'https://docs.teta.so/teta-docs/widget/advanced-widgets/calendarv2',
    )
  ],
);

class CalenderV2Body extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.datasetInput: FDataset(),
    DBKeys.action: NodeGestureActions.empty(),
    DBKeys.dropdownItem: 'month',
    DBKeys.textStyle: FTextStyle(),
    DBKeys.textStyle2: FTextStyle(),
    DBKeys.fill: FFill(type: FFillType.none),
    DBKeys.bgFill: FFill(type: FFillType.none),
    DBKeys.borderRadius: FBorderRadius(),
    DBKeys.borderRadiusTwo: FBorderRadius(),
    DBKeys.shadows: FShadow(),
    DBKeys.fill2: FFill(),
    DBKeys.fill3: FFill(),
    DBKeys.selectedItemName: FTextTypeInput(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          title: 'Field to fetch events',
          type: ControlType.datasetType,
          key: DBKeys.datasetInput,
          value: attributes[DBKeys.datasetInput],
          flag: true,
          valueType: VariableType.string,
        ),
        ControlObject(
          title: 'Clicked Event List',
          type: ControlType.value,
          key: DBKeys.selectedItemName,
          value: attributes[DBKeys.selectedItemName],
          valueType: VariableType.string,
        ),
        ControlObject(
          title: 'Calendar View',
          type: ControlType.dropdownControl,
          list: [
            'month',
            'twoWeeks',
            'week',
          ],
          key: DBKeys.dropdownItem,
          value: attributes[DBKeys.dropdownItem],
          valueType: VariableType.string,
        ),
        ControlObject(
          title: 'Title Properties',
          type: ControlType.text,
          key: DBKeys.textStyle,
          value: attributes[DBKeys.textStyle],
          valueType: VariableType.string,
        ),
        ControlObject(
          title: 'Text Properties',
          type: ControlType.text,
          key: DBKeys.textStyle2,
          value: attributes[DBKeys.textStyle2],
          valueType: VariableType.string,
        ),
        FillControlObject(
          title: 'Selected Box',
          key: DBKeys.fill,
          value: attributes[DBKeys.fill] as FFill,
          isImageEnabled: false,
          isNoneEnabled: true,
          isOnlySolid: false,
          isStyled: false,
        ),
        FillControlObject(
          title: 'Unselected Box',
          key: DBKeys.bgFill,
          value: attributes[DBKeys.bgFill] as FFill,
          isImageEnabled: false,
          isNoneEnabled: true,
          isOnlySolid: false,
          isStyled: false,
        ),
        ControlObject(
          title: 'Box Border Radius',
          type: ControlType.borderRadius,
          key: DBKeys.borderRadius,
          value: attributes[DBKeys.borderRadius],
          valueType: VariableType.double,
        ),
        ControlObject(
          type: ControlType.shadows,
          key: DBKeys.shadows,
          value: attributes[DBKeys.shadows],
          valueType: VariableType.string,
        ),
        FillControlObject(
          title: 'Icon Color',
          key: DBKeys.fill2,
          value: attributes[DBKeys.fill2] as FFill,
          isImageEnabled: false,
          isNoneEnabled: false,
          isOnlySolid: true,
          isStyled: false,
        ),
        FillControlObject(
          title: 'Dot Color',
          key: DBKeys.fill3,
          value: attributes[DBKeys.fill3] as FFill,
          isImageEnabled: false,
          isNoneEnabled: true,
          isOnlySolid: false,
          isStyled: false,
        ),
        ControlObject(
          title: 'Dot Border Radius',
          type: ControlType.borderRadius,
          key: DBKeys.borderRadiusTwo,
          value: attributes[DBKeys.borderRadiusTwo],
          valueType: VariableType.double,
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WCalendarV2(
        ValueKey(
          '''
          ${state.toKey}
          ${child ?? children}
          ${(attributes[DBKeys.action] as NodeGestureActions).toJson()},
          ${(attributes[DBKeys.datasetInput] as FDataset).toJson()},
          ${(attributes[DBKeys.selectedItemName] as FTextTypeInput).toJson()}
          ${(attributes[DBKeys.selectedItemName] as FTextTypeInput).getStateValue(state.states)}
          ${attributes[DBKeys.dropdownItem] as String},
          ${(attributes[DBKeys.textStyle] as FTextStyle).toJson()},
          ${(attributes[DBKeys.textStyle2] as FTextStyle).toJson()},
          ${(attributes[DBKeys.fill] as FFill).toJson()},
          ${(attributes[DBKeys.bgFill] as FFill).toJson()},
          ${(attributes[DBKeys.borderRadius] as FBorderRadius).toJson()},
          ${(attributes[DBKeys.shadows] as FShadow).toJson()},
          ${(attributes[DBKeys.fill2] as FFill).toJson()},
          ${(attributes[DBKeys.fill3] as FFill).toJson()},
          ${(attributes[DBKeys.borderRadiusTwo] as FBorderRadius).toJson()},
          ''',
        ),
        state: state,
        children: children ?? <CNode>[],
        action: attributes[DBKeys.action] as NodeGestureActions,
        calendarEvents: attributes[DBKeys.datasetInput] as FDataset,
        selectedItemName: attributes[DBKeys.selectedItemName] as FTextTypeInput,
        calendarView: attributes[DBKeys.dropdownItem] as String,
        textStyle: attributes[DBKeys.textStyle] as FTextStyle,
        textStyle2: attributes[DBKeys.textStyle2] as FTextStyle,
        selectedFill: attributes[DBKeys.fill] as FFill,
        unselectedFill: attributes[DBKeys.bgFill] as FFill,
        borderRadius: attributes[DBKeys.borderRadius] as FBorderRadius,
        shadows: attributes[DBKeys.shadows] as FShadow,
        iconFill: attributes[DBKeys.fill2] as FFill,
        dotFill: attributes[DBKeys.fill3] as FFill,
        dotBorderRadius: attributes[DBKeys.borderRadiusTwo] as FBorderRadius,
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
      CalendarV2CodeTemplate.toCode(
        pageId,
        context,
        node,
        loop ?? 0,
      );
}
