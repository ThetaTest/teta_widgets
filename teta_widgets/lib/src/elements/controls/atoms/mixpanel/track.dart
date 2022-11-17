// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
import 'package:teta_widgets/src/elements/controls/http_params.dart';
import 'package:teta_widgets/src/elements/features/actions/element.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class MixPanelTrack extends StatelessWidget {
  const MixPanelTrack({
    required this.prj,
    required this.page,
    required this.node,
    required this.action,
    required this.callback,
    final Key? key,
  }) : super(key: key);

  final ProjectObject prj;
  final PageObject page;
  final CNode node;
  final FActionElement action;
  final Function() callback;

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextControl(
          valueType: VariableType.string,
          node: node,
          value: action.valueTextTypeInput ?? FTextTypeInput(),
          page: page,
          title: 'Event name',
          callBack: (final value, final old) {
            action.valueTextTypeInput = value;
            callback();
          },
        ),
        const Gap(Grid.small),
        HttpParamsControl(
          node: node,
          page: page,
          title: 'Event Properties',
          list: action.customHttpRequestBody ?? <MapElement>[],
          callBack: (final value, final old) {
            action.customHttpRequestBody = value;
            callback();
          },
        ),
        const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: TDetailLabel(
              r'Add Event Properties. Example : { "key" : "$value" , "key1" : "$value1"}',
            ),
          ),
        ),
      ],
    );
  }
}