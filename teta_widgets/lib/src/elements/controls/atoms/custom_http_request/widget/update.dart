import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../actions/https_requests_custom_backend/update/action.dart';
import '../../../../actions/https_requests_custom_backend/update/params.dart';
import '../../../../features/text_type_input.dart';
import '../../../atoms/text.dart';
import '../../../http_params.dart';

class CustomHttpRequestUpdateControl extends StatefulWidget {
  const CustomHttpRequestUpdateControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TACustomHttpRequestUpdate action;
  final Function(TACustomHttpRequestUpdateParams params) onParamsChanged;

  @override
  State<CustomHttpRequestUpdateControl> createState() =>
      CustomHttpRequestUpdateControlState();
}

class CustomHttpRequestUpdateControlState
    extends State<CustomHttpRequestUpdateControl> {
  FTextTypeInput? url;
  FTextTypeInput? expectedStatusCode;
  List<MapElement>? parameters;
  List<MapElement>? headers;
  List<MapElement>? body;

  void updateParams() {
    widget.onParamsChanged(
      TACustomHttpRequestUpdateParams(
        url: url,
        customHttpRequestExpectedStatusCode: expectedStatusCode,
        parameters: parameters,
        headers: headers,
        body: body,
      ),
    );
  }

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
            value: widget.action.params.url ?? FTextTypeInput(),
            title: 'URL',
            callBack: (final value, final old) {
              url = value;
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
            valueType: VariableType.string,
            value: widget.action.params.customHttpRequestExpectedStatusCode ??
                FTextTypeInput(),
            title: 'Status Code',
            callBack: (final value, final old) {
              expectedStatusCode = value;
              updateParams();
            },
          ),
        ),
        HttpParamsControl(
          title: 'Add Params',
          list: widget.action.params.parameters ?? <MapElement>[],
          callBack: (final value, final old) {
            parameters = value;
            updateParams();
          },
        ),
        const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: TDetailLabel(
              r'Add Params. Example : www.example.com/users/?key=${value}',
            ),
          ),
        ),
        HttpParamsControl(
          title: 'Add Body Paramaters',
          list: widget.action.params.body ?? <MapElement>[],
          callBack: (final value, final old) {
            body = value;
            updateParams();
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
        const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: TDetailLabel(
              r'Add Params. Example : www.example.com/users/?key=${value}',
            ),
          ),
        ),
        HttpParamsControl(
          title: 'Add Headers',
          list: widget.action.params.headers ?? <MapElement>[],
          callBack: (final value, final old) {
            headers = value;
            updateParams();
          },
        ),
      ],
    );
  }
}
