import 'package:flutter/material.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../../actions/supabase/storage_delete/action.dart';
import '../../../../../actions/supabase/storage_delete/params.dart';
import '../../../../../features/text_type_input.dart';
import '../../../../atoms/text.dart';

class SupabaseStorageDeleteControl extends StatefulWidget {
  const SupabaseStorageDeleteControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TASupabaseStorageDelete action;
  final Function(TASupabaseStorageDeleteParams params) onParamsChanged;

  @override
  State<SupabaseStorageDeleteControl> createState() =>
      SupabaseStorageDeleteControlState();
}

class SupabaseStorageDeleteControlState
    extends State<SupabaseStorageDeleteControl> {
  FTextTypeInput? pathFile;
  FTextTypeInput? supabaseFrom;

  void updateParams() {
    widget.onParamsChanged(
      TASupabaseStorageDeleteParams(
        pathFile: pathFile,
        supabaseFrom: supabaseFrom,
      ),
    );
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
          title: 'Bucket ID',
          callBack: (final value, final old) {
            supabaseFrom = value;
            updateParams();
          },
        ),
        TextControl(
          valueType: VariableType.string,
          value: widget.action.params.pathFile ?? FTextTypeInput(),
          title: 'File path',
          callBack: (final value, final old) {
            pathFile = value;
            updateParams();
          },
        ),
      ],
    );
  }
}
