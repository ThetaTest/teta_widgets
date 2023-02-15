// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/controls/atoms/cms_collections.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/actions/element.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';

class TetaCmsDeleteControl extends StatelessWidget {
  const TetaCmsDeleteControl({
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
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              Image.asset(Assets.icons.left.dataset.path, width: 24),
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: TParagraph(
                  'DELETE DATA',
                  color: Color(0xFFe7e7e7),
                ),
              ),
            ],
          ),
        ),
        CMSCollectionControl(
          collectionName: action.cmsCollectionId,
          callBack: (final value, final old) {
            action.cmsCollectionId = value;
            callback();
          },
        ),
        const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: TParagraph(
              'Where',
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextControl(
            valueType: VariableType.string,
            value: action.dbFrom ?? FTextTypeInput(),
            title: 'Document Id',
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
