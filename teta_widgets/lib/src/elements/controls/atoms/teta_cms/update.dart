// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/controls/atoms/cms_collections.dart';
import 'package:teta_widgets/src/elements/controls/atoms/db_map.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
import 'package:teta_widgets/src/elements/features/actions/element.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class TetaCmsUpdateControl extends StatelessWidget {
  const TetaCmsUpdateControl({
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
                  'UPDATE DATA',
                  color: Color(0xFFe7e7e7),
                ),
              ),
            ],
          ),
        ),
        CMSCollectionControl(
          node: node,
          collectionId: action.cmsCollectionId,
          callBack: (final value, final old) {
            action.cmsCollectionId = value;
            callback();
          },
        ),
        DBMapControl(
          node: node,
          list: action.dbData ?? [],
          page: page,
          callBack: (final value, final old) {
            action.dbData = value;
            callback();
          },
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: THeadline3(
            'Where',
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextControl(
            node: node,
            value: action.dbFrom ?? FTextTypeInput(),
            page: page,
            title: 'Document Id',
            withConvertTo: false,
            callBack: (final value, final old) {
              action.dbFrom = value;
              callback();
            },
          ),
        ),
      ],
    );
  }
}
