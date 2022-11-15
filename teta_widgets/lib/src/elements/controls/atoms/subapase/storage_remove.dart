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

class SupabaseStorageRemoveControl extends StatelessWidget {
  const SupabaseStorageRemoveControl({
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
          value: action.dbFrom ?? FTextTypeInput(),
          page: page,
          title: 'Bucket ID',
          callBack: (final value, final old) {
            action.dbFrom = value;
            callback();
          },
        ),
        TextControl(
          valueType: VariableType.string,
          node: node,
          value: action.valueTextTypeInput ?? FTextTypeInput(),
          page: page,
          title: 'File path',
          callBack: (final value, final old) {
            action.valueTextTypeInput = value;
            callback();
          },
        ),
        const Gap(Grid.small),
        HttpParamsControl(
          node: node,
          page: page,
          title: 'Add Body Paramaters',
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
              r'Add Body Paramaters. Example : { "key" : "$value" , "key1" : "$value1"}',
            ),
          ),
        ),
        HttpParamsControl(
          node: node,
          page: page,
          title: 'Add Headers',
          list: action.customHttpRequestHeader ?? <MapElement>[],
          callBack: (final value, final old) {
            action.customHttpRequestHeader = value;
            callback();
          },
        ),
      ],
    );
  }
}
