// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/controls/atoms/cms_collections.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/atoms/db_map.dart';
import 'package:teta_widgets/src/elements/features/actions/element.dart';

class TetaCmsInsertControl extends StatelessWidget {
  const TetaCmsInsertControl({
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
        const Gap(Grid.small),
        CMSCollectionControl(
          collectionName: action.cmsCollectionId,
          callBack: (final value, final old) {
            action.cmsCollectionId = value;
            callback();
          },
        ),
        DBMapControl(
          list: action.dbData ?? <MapElement>[],
          callBack: (final value, final old) {
            action.dbData = value;
            callback();
          },
        ),
      ],
    );
  }
}
