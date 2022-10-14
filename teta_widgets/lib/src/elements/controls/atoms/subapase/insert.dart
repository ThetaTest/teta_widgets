// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/atoms/db_map.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
import 'package:teta_widgets/src/elements/features/actions/element.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class SupabaseInsertControl extends StatelessWidget {
  const SupabaseInsertControl({
    required this.prj,
    required this.page,
    required this.node,
    required this.action,
    required this.callback,
    final Key? key,
  }) : super(key: key);

  final ProjectObject prj;
  final PageObject page;
  final CNode node;
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
                child: THeadline3(
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
          value: action.dbFrom ?? FTextTypeInput(),
          page: page,
          title: 'From Table',
          callBack: (final value, final old) {
            action.dbFrom = value;
            callback();
          },
        ),
        DBMapControl(
          node: node,
          list: action.dbData ?? <MapElement>[],
          page: page,
          callBack: (final value, final old) {
            action.dbData = value;
            callback();
          },
        ),
      ],
    );
  }
}
