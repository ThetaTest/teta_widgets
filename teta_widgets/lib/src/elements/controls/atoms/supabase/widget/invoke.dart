import 'package:flutter/material.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../actions/supabase/function_invoke/action.dart';
import '../../../../actions/supabase/function_invoke/params.dart';
import '../../../../features/text_type_input.dart';
import '../../../atoms/text.dart';

class SupabaseFunctionInvokeControl extends StatefulWidget {
  const SupabaseFunctionInvokeControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TASupabaseFunctionInvoke action;
  final Function(TASupabaseFunctionInvokeParams params) onParamsChanged;

  @override
  State<SupabaseFunctionInvokeControl> createState() =>
      SupabaseFunctionInvokeControlState();
}

class SupabaseFunctionInvokeControlState
    extends State<SupabaseFunctionInvokeControl> {
  FTextTypeInput? supabaseFrom;
  List<MapElement>? body;
  List<MapElement>? headers;
  MapElement? supabaseEq;

  void updateParams() {
    setState(() {
      widget.onParamsChanged(
        TASupabaseFunctionInvokeParams(
          supabaseFrom: supabaseFrom,
          body: body,
          headers: headers,
          supabaseEq: supabaseEq,
        ),
      );
    });
  }

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextControl(
          valueType: VariableType.string,
          value: widget.action.params.supabaseFrom ?? FTextTypeInput(),
          title: 'Function',
          callBack: (final value, final old) {
            supabaseFrom = value;
            updateParams();
          },
        ),
      ],
    );
  }
}
