import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/controls/atoms/db_map.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
import 'package:teta_widgets/src/elements/features/actions/element.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';

class AirtableInsertControl extends StatelessWidget {
  const AirtableInsertControl({
    required this.action,
    required this.callback,
    final Key? key,
  }) : super(key: key);
  final FActionElement action;
  final Function() callback;

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
                  'Insert data',
                  color: Color(0xFFe7e7e7),
                ),
              ),
            ],
          ),
        ),
        TextControl(
          valueType: VariableType.string,
          value: action.airtableRecordName ?? FTextTypeInput(),
          title: 'Record name',
          callBack: (final value, final old) {
            action.airtableRecordName = value;
            callback();
          },
        ),
        DBMapControl(
          list: action.dbData ?? <MapElement>[],
          callBack: (final value, final old) {
            action.dbData = value;
            callback.call();
          },
        )
      ],
    );
  }
}
