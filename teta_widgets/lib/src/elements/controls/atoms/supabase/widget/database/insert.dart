import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../../actions/supabase/insert/action.dart';
import '../../../../../actions/supabase/insert/params.dart';
import '../../../../../features/text_type_input.dart';
import '../../../../atoms/db_map.dart';
import '../../../../atoms/text.dart';

class SupabaseInsertControl extends StatefulWidget {
  const SupabaseInsertControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TASupabaseInsert action;
  final Function(TASupabaseInsertParams params) onParamsChanged;

  @override
  State<SupabaseInsertControl> createState() => SupabaseInsertControlState();
}

class SupabaseInsertControlState extends State<SupabaseInsertControl> {
  FTextTypeInput? supabaseFrom;
  List<MapElement>? supabaseData;

  @override
  void initState() {
    super.initState();
    supabaseFrom = widget.action.params.supabaseFrom;
    supabaseData = widget.action.params.supabaseData;
  }

  void updateParams() {
    setState(() {
      widget.onParamsChanged(
        TASupabaseInsertParams(
          supabaseData: supabaseData,
          supabaseFrom: supabaseFrom,
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
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              Image.asset(Assets.icons.left.dataset.path, width: 24),
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: TParagraph(
                  'INSERT NEW DATA',
                  color: Color(0xFFe7e7e7),
                ),
              ),
            ],
          ),
        ),
        TextControl(
          valueType: VariableType.string,
          value: supabaseFrom ?? FTextTypeInput(),
          title: 'From Table',
          callBack: (final value, final old) {
            supabaseFrom = value;
            updateParams();
          },
        ),
        DBMapControl(
          list: supabaseData ?? [],
          callBack: (final value, final old) {
            supabaseData = value;
            updateParams();
          },
        ),
      ],
    );
  }
}
