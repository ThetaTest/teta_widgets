// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/controls/atoms/db_map.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/atoms/map_element.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
import 'package:teta_widgets/src/elements/features/actions/element.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';

class SupabaseUpdateControl extends StatelessWidget {
  const SupabaseUpdateControl({
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
          value: action.dbFrom ?? FTextTypeInput(),
          title: 'From Table',
          callBack: (final value, final old) {
            action.dbFrom = value;
            callback();
          },
        ),
        DBMapControl(
          list: action.dbData ?? [],
          callBack: (final value, final old) {
            action.dbData = value;
            callback();
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
            value: action.dbEq ?? MapElement(key: '', value: FTextTypeInput()),
            callBack: (final value, final old) {
              action.dbEq = value;
              callback();
            },
          ),
        ),
      ],
    );
  }
}
