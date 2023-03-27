import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../actions/airtable/update/action.dart';
import '../../../../actions/airtable/update/params.dart';
import '../../../../features/text_type_input.dart';
import '../../../atoms/text.dart';
import '../../db_map.dart';

class AirtableUpdateControl extends StatefulWidget {
  const AirtableUpdateControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TAAirtableUpdate action;
  final Function(TAAirtableUpdateParams params) onParamsChanged;

  @override
  State<AirtableUpdateControl> createState() => AirtableUpdateControlState();
}

class AirtableUpdateControlState extends State<AirtableUpdateControl> {
  FTextTypeInput? airtableRecordName;
  List<MapElement>? airtableData;

  void updateParams() {
    widget.onParamsChanged(
      TAAirtableUpdateParams(
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
