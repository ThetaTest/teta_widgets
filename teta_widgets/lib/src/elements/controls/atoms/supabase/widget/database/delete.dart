import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/controls/atoms/db_map.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/atoms/map_element.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../../actions/supabase/delete/action.dart';
import '../../../../../actions/supabase/delete/params.dart';
import '../../../../../features/text_type_input.dart';
import '../../../../atoms/map_element.dart';
import '../../../../atoms/text.dart';

class SupabaseDeleteControl extends StatefulWidget {
  const SupabaseDeleteControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TASupabaseDelete action;
  final Function(TASupabaseDeleteParams params) onParamsChanged;

  @override
  State<SupabaseDeleteControl> createState() => SupabaseDeleteControlState();
}

class SupabaseDeleteControlState extends State<SupabaseDeleteControl> {
  FTextTypeInput? supabaseFrom;
  MapElement? supabaseEq;

  @override
  void initState() {
    super.initState();
    supabaseFrom = widget.action.params.supabaseFrom;
    supabaseEq = widget.action.params.supabaseEq;
  }

  void updateParams() {
    widget.onParamsChanged(
      TASupabaseDeleteParams(
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
        const Gap(Grid.medium),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              Image.asset(Assets.icons.left.dataset.path, width: 24),
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: TParagraph(
                  'Update data',
                  color: Color(0xFFe7e7e7),
                ),
              ),
            ],
          ),
        ),
        const Gap(Grid.small),
        TextControl(
          valueType: VariableType.string,
          value: supabaseFrom ?? FTextTypeInput(),
          title: 'From Table',
          callBack: (final value, final old) {
            supabaseFrom = value;
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
            value: supabaseEq ?? MapElement(key: '', value: FTextTypeInput()),
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
