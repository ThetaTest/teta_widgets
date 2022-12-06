// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/controls/atoms/apicalls_request.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
import 'package:teta_widgets/src/elements/controls/http_params.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class ApiCallsControl extends StatelessWidget {
  const ApiCallsControl({
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
        ApiCallsRequestControl(
          node: node,
          //TODO request name must be unique! kasapiniz
          requestName: action.apiCallsRequestName ?? '',
          callBack: (final value, final old, final apiCallsSelectedRequest) {
            action.apiCallsRequestName = value;
            action.apiCallsSelectedRequest = apiCallsSelectedRequest;
            callback();
          },
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
            value: action.apiCallsResponseName ?? FTextTypeInput(),
            page: page,
            title: 'Response Name',
            callBack: (final value, final old) {
              action.apiCallsResponseName = value;
              callback();
            },
          ),
        ),
        const Gap(Grid.small),
        HttpParamsControl(
          node: node,
          page: page,
          title: 'Add Dynamic Value',
          list: action.apiCallsDynamicValue ?? <MapElement>[],
          callBack: (final value, final old) {
            action.apiCallsDynamicValue = value;
            callback();
          },
        ),
      ],
    );
  }
}
