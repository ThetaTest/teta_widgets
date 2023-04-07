import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';
import 'package:teta_widgets/teta_widgets.dart';

import '../../../../actions/cutom_http_request/update/action.dart';
import '../../../../actions/cutom_http_request/update/params.dart';
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
  String? responseState;

  @override
  void initState() {
    super.initState();
    url = widget.action.params.url;
    expectedStatusCode = widget.action.params.expectedStatusCode;
    parameters = widget.action.params.parameters;
    headers = widget.action.params.headers;
    body = widget.action.params.body;
    responseState = widget.action.params.responseState;
  }

  void updateParams() {
    setState(() {
      widget.onParamsChanged(
        TACustomHttpRequestUpdateParams(
          url: url,
          expectedStatusCode: expectedStatusCode,
          parameters: parameters,
          headers: headers,
          body: body,
          responseState: responseState,
        ),
      );
    });
  }

  @override
  Widget build(final BuildContext context) {
    final pageLoaded = context.read<PageCubit>().state as PageLoaded;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TParagraph('JSON Response State'),
        const Gap(Grid.small),
        descriptionControlWidget(
          description: 'The state where the JSON response will be stored',
          control: CDropdown(
            value: pageLoaded.page.defaultStates
                    .where((e) => e.type == VariableType.json)
                    .map((e) => e.name)
                    .toList()
                    .contains(widget.action.params.responseState)
                ? widget.action.params.responseState
                : null,
            items: pageLoaded.page.defaultStates
                .where((e) => e.type == VariableType.json)
                .map((e) => e.name)
                .toList(),
            onChange: (newValue) {
              if (newValue == null) return;
              responseState = newValue;
              updateParams();
            },
          ),
        ),
        const Gap(Grid.medium),
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
            value: widget.action.params.expectedStatusCode ??
                FTextTypeInput(value: '200'),
            title: 'Expected tatus Code',
            callBack: (final value, final old) {
              expectedStatusCode = value;
              updateParams();
            },
          ),
        ),
        // Query Params
        HttpParamsControl(
          title: 'Add Query Params',
          list: widget.action.params.parameters ?? <MapElement>[],
          callBack: (value, old) {
            parameters = value;
            updateParams();
          },
        ),
        // Body
        HttpParamsControl(
          title: 'Add Body Paramaters',
          list: widget.action.params.body ?? <MapElement>[],
          callBack: (value, old) {
            body = value;
            updateParams();
          },
        ),
        // Headers
        HttpParamsControl(
          title: 'Add Headers',
          list: widget.action.params.headers ?? <MapElement>[],
          callBack: (value, old) {
            headers = value;
            updateParams();
          },
        ),
      ],
    );
  }
}
