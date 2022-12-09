import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/controls/atoms/db_map.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
import 'package:teta_widgets/src/elements/features/actions/element.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class AirtableUpdateControl extends StatelessWidget {
  const AirtableUpdateControl({
    required this.prj,
    required this.node,
    required this.page,
    required this.action,
    required this.callback,
    final Key? key,
  }) : super(key: key);

  final ProjectObject prj;
  final CNode node;
  final PageObject page;
  final FActionElement action;
  final Function() callback;

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
          node: node,
          value: action.airtableRecordName ?? FTextTypeInput(),
          page: page,
          title: 'Record name',
          callBack: (final value, final old) {
            action.airtableRecordName = value;
            callback();
          },
        ),
        DBMapControl(
          node: node,
          list: action.dbData ?? <MapElement>[],
          page: page,
          callBack: (final value, final old) {
            action.dbData = value;
            callback.call();
          },
        )
      ],
    );
  }
}
