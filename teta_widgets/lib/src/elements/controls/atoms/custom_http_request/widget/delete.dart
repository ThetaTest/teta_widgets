import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
import 'package:teta_widgets/src/elements/controls/http_params.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../actions/cutom_http_request/delete/action.dart';
import '../../../../actions/cutom_http_request/delete/params.dart';
import '../../../../features/text_type_input.dart';

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
  String? responseState;

  void updateParams() {
    widget.onParamsChanged(
      TACustomHttpRequestDeleteParams(
        url: url,
        expectedStatusCode: expectedStatusCode,
        parameters: parameters,
        headers: headers,
        responseState: responseState,
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    final pageLoaded = context.read<PageCubit>().state as PageLoaded;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TParagraph('Response JSON State'),
        const Gap(Grid.small),
        descriptionControlWidget(
          description: 'The state where the JSON response will be stored',
          control: CDropdown(
            value: pageLoaded.page.defaultStates
                    .where((final element) => element.type == VariableType.json)
                    .map((final e) => e.name)
                    .toList()
                    .contains(widget.action.params.responseState)
                ? widget.action.params.responseState
                : null,
            items: pageLoaded.page.defaultStates
                .where((final element) => element.type == VariableType.json)
                .map((final e) => e.name)
                .toList(),
            onChange: (final newValue) {
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
