import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../actions/teta_cms/database/update/action.dart';
import '../../../../actions/teta_cms/database/update/params.dart';
import '../../../../features/text_type_input.dart';
import '../../../atoms/cms_collections.dart';
import '../../../atoms/db_map.dart';
import '../../../atoms/text.dart';

class TetaCmsUpdateControl extends StatefulWidget {
  const TetaCmsUpdateControl({
    required this.action,
    required this.onParamsChanged,
    final Key? key,
  }) : super(key: key);

  final TATetaCMSUpdate action;
  final Function(TATetaCMSUpdateParams) onParamsChanged;

  @override
  State<TetaCmsUpdateControl> createState() => _TetaCmsUpdateControlState();
}

class _TetaCmsUpdateControlState extends State<TetaCmsUpdateControl> {
  late String? cmsCollectionId;
  late List<MapElement> dbData;
  late FTextTypeInput documentId;

  @override
  void initState() {
    super.initState();
    cmsCollectionId = widget.action.params.collectionId;
    dbData = widget.action.params.dbData ?? [];
    documentId = widget.action.params.documentId ?? FTextTypeInput();
  }

  void updateParams() {
    setState(() {
      widget.onParamsChanged(
        TATetaCMSUpdateParams(
          collectionId: cmsCollectionId,
          dbData: dbData,
          documentId: documentId,
        ),
      );
    });
  }

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
                  'UPDATE DATA',
                  color: Color(0xFFe7e7e7),
                ),
              ),
            ],
          ),
        ),
        CMSCollectionControl(
          collectionName: cmsCollectionId,
          callBack: (final value, final old) {
            cmsCollectionId = value;
            updateParams();
          },
        ),
        const TParagraph('Where'),
        const SizedBox(height: 8),
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
        DBMapControl(
          list: dbData,
          callBack: (final value, final old) {
            dbData = value;
            updateParams();
          },
        ),
      ],
    );
  }
}
