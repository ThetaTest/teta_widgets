// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
import 'package:teta_widgets/src/elements/controls/http_params.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class CustomHttpRequestDeleteControl extends StatelessWidget {
  const CustomHttpRequestDeleteControl({
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
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextControl(
            valueType: VariableType.string,
            node: node,
            value: action.customHttpRequestURL ?? FTextTypeInput(),
            page: page,
            title: 'URL',
            callBack: (final value, final old) {
              action.customHttpRequestURL = value;
              callback();
            },
          ),
        ),
        const Gap(Grid.small),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextControl(
            valueType: VariableType.string,
            node: node,
            value:
                action.customHttpRequestExpectedStatusCode ?? FTextTypeInput(),
            page: page,
            title: 'Status Code',
            callBack: (final value, final old) {
              action.customHttpRequestExpectedStatusCode = value;
              callback();
            },
          ),
        ),
        HttpParamsControl(
          node: node,
          page: page,
          title: 'Add Params',
          list: action.customHttpRequestList ?? <MapElement>[],
          callBack: (final value, final old) {
            action.customHttpRequestList = value;
            callback();
          },
        ),
        const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: TDetailLabel(
              'Add Params. Example : www.example.com/users/?key=\${value}',
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
