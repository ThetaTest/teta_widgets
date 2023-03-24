import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../actions/api_calls/execute/action.dart';
import '../../../../actions/api_calls/execute/params.dart';
import '../../../../features/text_type_input.dart';
import '../../../atoms/text.dart';
import '../../../http_params.dart';
import 'apicalls_request.dart';

class ApiCallsExecuteControl extends StatefulWidget {
  const ApiCallsExecuteControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TAApiCallsExecute action;
  final Function(TAApiCallsExecuteParams params) onParamsChanged;

  @override
  State<ApiCallsExecuteControl> createState() => ApiCallsExecuteControlState();
}

class ApiCallsExecuteControlState extends State<ApiCallsExecuteControl> {
  String? requestName;
  Map<String, dynamic>? selectedRequest;
  FTextTypeInput? expectedStatusCode;
  FTextTypeInput? responseName;
  List<MapElement>? dynamicValue;

  void updateParams() {
    widget.onParamsChanged(
      TAApiCallsExecuteParams(
        apiCallsRequestName: requestName,
        apiCallsSelectedRequest: selectedRequest,
        customHttpRequestExpectedStatusCode: expectedStatusCode,
        apiCallsResponseName: responseName,
        apiCallsDynamicValue: dynamicValue,
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ApiCallsRequestControl(
          requestName: requestName ?? '',
          callBack: (final value, final old, final apiCallsSelectedRequest) {
            requestName = value;
            selectedRequest = apiCallsSelectedRequest;
            updateParams();
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
            title: 'Status Code',
            valueType: VariableType.string,
            value: expectedStatusCode ?? FTextTypeInput(),
            callBack: (final value, final old) {
              expectedStatusCode = value;
              updateParams();
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
            title: 'Response Name',
            valueType: VariableType.string,
            value: responseName ?? FTextTypeInput(),
            callBack: (final value, final old) {
              responseName = value;
              updateParams();
            },
          ),
        ),
        const Gap(Grid.small),
        HttpParamsControl(
          title: 'Add Dynamic Value',
          list: dynamicValue ?? <MapElement>[],
          callBack: (final value, final old) {
            dynamicValue = value;
            updateParams();
          },
        ),
      ],
    );
  }
}
