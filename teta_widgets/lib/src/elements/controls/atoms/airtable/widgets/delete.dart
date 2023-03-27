import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../actions/airtable/delete/action.dart';
import '../../../../actions/airtable/delete/params.dart';
import '../../../../features/text_type_input.dart';
import '../../../atoms/text.dart';
import '../../db_map.dart';

class AirtableDeleteControl extends StatefulWidget {
  const AirtableDeleteControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TAAirtableDelete action;
  final Function(TAAirtableDeleteParams params) onParamsChanged;

  @override
  State<AirtableDeleteControl> createState() => AirtableDeleteControlState();
}

class AirtableDeleteControlState extends State<AirtableDeleteControl> {
  FTextTypeInput? airtableRecordName;
  List<MapElement>? airtableData;

  void updateParams() {
    widget.onParamsChanged(
      TAAirtableDeleteParams(
        airtableData: airtableData ?? [],
        airtableRecordName: airtableRecordName,
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
                  'INSERT NEW DATA',
                  color: Color(0xFFe7e7e7),
                ),
              ),
            ],
          ),
        ),
        TextControl(
          valueType: VariableType.string,
          value: widget.action.params.airtableRecordName ?? FTextTypeInput(),
          title: 'Record name',
          callBack: (final value, final old) {
            airtableRecordName = value;
            updateParams();
          },
        ),
        DBMapControl(
          list: widget.action.params.airtableData,
          callBack: (final value, final old) {
            airtableData = value;
            updateParams();
          },
        )
      ],
    );
  }
}
