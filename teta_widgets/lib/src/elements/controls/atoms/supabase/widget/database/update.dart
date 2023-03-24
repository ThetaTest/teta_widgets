import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../../actions/supabase/update/action.dart';
import '../../../../../actions/supabase/update/params.dart';
import '../../../../../features/text_type_input.dart';
import '../../../../atoms/db_map.dart';
import '../../../../atoms/map_element.dart';
import '../../../../atoms/text.dart';

class SupabaseUpdateControl extends StatefulWidget {
  const SupabaseUpdateControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TASupabaseUpdate action;
  final Function(TASupabaseUpdateParams params) onParamsChanged;

  @override
  State<SupabaseUpdateControl> createState() => SupabaseUpdateControlState();
}

class SupabaseUpdateControlState extends State<SupabaseUpdateControl> {
  FTextTypeInput? supabaseFrom;
  List<MapElement>? supabaseData;
  MapElement? supabaseEq;

  @override
  void initState() {
    super.initState();
    supabaseFrom = widget.action.params.supabaseFrom;
    supabaseData = widget.action.params.supabaseData;
    supabaseEq = widget.action.params.supabaseEq;
  }

  void updateParams() {
    widget.onParamsChanged(
      TASupabaseUpdateParams(
        supabaseData: supabaseData,
        supabaseEq: supabaseEq,
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
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              Image.asset(Assets.icons.left.dataset.path, width: 24),
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: TParagraph(
                  'UPDATE DATA',
                  color: Color(0xFFe7e7e7),
                ),
              ),
            ],
          ),
        ),
        TextControl(
          valueType: VariableType.string,
          value: widget.action.params.supabaseFrom ?? FTextTypeInput(),
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
        const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: TParagraph(
            'Where',
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(8),
          ),
          child: MapElementControl(
            value: supabaseEq ??
                MapElement(
                  key: '',
                  value: FTextTypeInput(),
                ),
            callBack: (final value, final old) {
              supabaseEq = value;
              updateParams();
            },
          ),
        ),
      ],
    );
  }
}
