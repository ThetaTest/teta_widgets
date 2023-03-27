import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
import 'package:teta_widgets/src/elements/controls/http_params.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../actions/cutom_http_request/delete/action.dart';
import '../../../../actions/cutom_http_request/delete/params.dart';
import '../../../../features/text_type_input.dart';
import '../../../atoms/text.dart';
import '../../../http_params.dart';

class CustomHttpRequestDeleteControl extends StatefulWidget {
  const CustomHttpRequestDeleteControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TACustomHttpRequestDelete action;
  final Function(TACustomHttpRequestDeleteParams params) onParamsChanged;

  @override
  State<CustomHttpRequestDeleteControl> createState() =>
      CustomHttpRequestDeleteControlState();
}

class CustomHttpRequestDeleteControlState
    extends State<CustomHttpRequestDeleteControl> {
  FTextTypeInput? url;
  FTextTypeInput? expectedStatusCode;
  List<MapElement>? parameters;
  List<MapElement>? headers;

  void updateParams() {
    widget.onParamsChanged(
      TACustomHttpRequestDeleteParams(
        url: url,
        expectedStatusCode: expectedStatusCode,
        parameters: parameters,
        headers: headers,
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
            value: widget.action.params.expectedStatusCode ?? FTextTypeInput(),
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
