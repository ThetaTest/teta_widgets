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
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

class ApiCallsControl extends StatelessWidget {
  const ApiCallsControl({
    required this.action,
    required this.callback,
    final Key? key,
  }) : super(key: key);

  final FActionElement action;
  final Function(FActionElement, FActionElement) callback;

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ApiCallsRequestControl(
          //TODO request name must be unique! kasapiniz
          requestName: action.apiCallsRequestName ?? '',
          callBack: (final value, final old, final apiCallsSelectedRequest) {
            final oldAction= action;
            action.apiCallsRequestName = value;
            action.apiCallsSelectedRequest = apiCallsSelectedRequest;
            callback(action,oldAction);
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
            ignoreDeviceTypeValue: true,
            valueType: VariableType.string,
            value:
                action.customHttpRequestExpectedStatusCode ?? FTextTypeInput(),
            title: 'Status Code',
            callBack: (final value, final old) {
          final oldAction = action;
              action.customHttpRequestExpectedStatusCode = value;
              callback(action,oldAction);
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
            ignoreDeviceTypeValue: true,
            valueType: VariableType.string,
            value: action.apiCallsResponseName ?? FTextTypeInput(),
            title: 'Response Name',
            callBack: (final value, final old) {
          final oldAction = action;
              action.apiCallsResponseName = value;
              callback(action,oldAction);
            },
          ),
        ),
        const Gap(Grid.small),
        HttpParamsControl(
          title: 'Add Dynamic Value',
          list: action.apiCallsDynamicValue ?? <MapElement>[],
          callBack: (final value, final old) {
          final oldAction = action;
            action.apiCallsDynamicValue = value;
            callback(action,oldAction);
          },
        ),
      ],
    );
  }
}
