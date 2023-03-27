import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/controls/atoms/cms_collections.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:theta_models/theta_models.dart';

import '../../../../actions/teta_cms/database/delete/action.dart';
import '../../../../actions/teta_cms/database/delete/params.dart';

class TetaCmsDeleteControl extends StatefulWidget {
  const TetaCmsDeleteControl({
    required this.action,
    required this.onParamsChanged,
    final Key? key,
  }) : super(key: key);

  final TATetaCMSDelete action;
  final Function(TATetaCMSDeleteParams params) onParamsChanged;

  @override
  State<TetaCmsDeleteControl> createState() => _TetaCmsDeleteControlState();
}

class _TetaCmsDeleteControlState extends State<TetaCmsDeleteControl> {
  late String? cmsCollectionId;
  late FTextTypeInput documentId;

  @override
  void initState() {
    super.initState();
    cmsCollectionId = widget.action.params.collectionId;
    documentId = widget.action.params.documentId ?? FTextTypeInput();
  }

  void updateParams() {
    widget.onParamsChanged(
      TATetaCMSDeleteParams(
        collectionId: cmsCollectionId,
        documentId: documentId,
      ),
    );
  }

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
                  'Delete data',
                  color: Color(0xFFe7e7e7),
                ),
              ),
            ],
          ),
        ),
        const Gap(Grid.small),
        CMSCollectionControl(
          collectionName: cmsCollectionId,
          callBack: (final value, final old) {
            cmsCollectionId = value;
            updateParams();
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
            value: documentId,
            title: 'Document Id',
            callBack: (final value, final old) {
              documentId = value;
              updateParams();
            },
          ),
        ),
      ],
    );
  }
}
