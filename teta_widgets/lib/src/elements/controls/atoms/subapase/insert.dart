// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/design_system/text.dart';
import 'package:teta_core/src/models/page.dart';
import 'package:teta_core/src/models/project.dart';
import 'package:teta_elements/src/elements/controls/atoms/supabase_map.dart';
import 'package:teta_elements/src/elements/controls/atoms/text.dart';
import 'package:teta_elements/src/elements/features/actions/element.dart';
import 'package:teta_elements/src/elements/features/text_type_input.dart';
import 'package:teta_elements/src/elements/nodes/node.dart';

class SupabaseInsertControl extends StatelessWidget {
  const SupabaseInsertControl({
    Key? key,
    required this.prj,
    required this.page,
    required this.node,
    required this.action,
    required this.callback,
  }) : super(key: key);

  final ProjectObject prj;
  final PageObject page;
  final CNode node;
  final FActionElement action;
  final Function() callback;

  @override
  Widget build(BuildContext context) {
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
                child: CText(
                  'INSERT NEW DATA',
                  customColor: Color(0xFFe7e7e7),
                  weight: FontWeight.bold,
                  size: 12,
                ),
              ),
            ],
          ),
        ),
        TextControl(
          node: node,
          value: action.supabaseFrom ?? FTextTypeInput(),
          page: page,
          title: 'From Table',
          callBack: (value, old) {},
        ),
        SupabaseMapControl(
          node: node,
          list: action.supabaseData ?? [],
          page: page,
          callBack: (value, old) {
            action.supabaseData = value;
            callback();
          },
        ),
      ],
    );
  }
}
