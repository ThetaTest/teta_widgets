// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/design_system/text.dart';
import 'package:teta_core/src/models/page.dart';
import 'package:teta_core/src/models/project.dart';
import 'package:teta_core/src/models/supabase_map_element.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/atoms/supabase_element.dart';
import 'package:teta_widgets/src/elements/controls/atoms/supabase_map.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
import 'package:teta_widgets/src/elements/features/actions/element.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class SupabaseUpdateControl extends StatelessWidget {
  const SupabaseUpdateControl({
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
          callBack: (final value, final old) {},
        ),
        SupabaseMapControl(
          node: node,
          list: action.supabaseData ?? [],
          page: page,
          callBack: (final value, final old) {
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
            callBack: (final value, final old) {
              action.supabaseEq = value;
              callback();
            },
          ),
        ),
      ],
    );
  }
}
