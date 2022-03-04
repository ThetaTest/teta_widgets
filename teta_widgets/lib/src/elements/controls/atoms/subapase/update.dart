// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/design_system/text.dart';
import 'package:teta_core/src/models/page.dart';
import 'package:teta_core/src/models/project.dart';
import 'package:teta_core/src/models/supabase_map_element.dart';
import 'package:teta_elements/src/elements/controls/atoms/supabase_element.dart';
import 'package:teta_elements/src/elements/controls/atoms/supabase_map.dart';
import 'package:teta_elements/src/elements/controls/atoms/text.dart';
import 'package:teta_elements/src/elements/features/actions/element.dart';
import 'package:teta_elements/src/elements/features/text_type_input.dart';
import 'package:teta_elements/src/elements/nodes/node.dart';

class SupabaseUpdateControl extends StatelessWidget {
  const SupabaseUpdateControl({
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
                  'UPDATE DATA',
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
        const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: CText(
            'Where',
            customColor: Colors.white,
            weight: FontWeight.bold,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(8),
          ),
          child: SupabaseMapElementControl(
            node: node,
            value: action.supabaseEq ??
                SupabaseMapElement(key: '', value: FTextTypeInput()),
            page: page,
            callBack: (value, old) {
              action.supabaseEq = value;
              callback();
            },
          ),
        ),
      ],
    );
  }
}
