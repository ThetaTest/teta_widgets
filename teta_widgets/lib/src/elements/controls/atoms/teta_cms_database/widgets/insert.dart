import 'package:flutter/widgets.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../actions/teta_cms/database/insert/action.dart';
import '../../../../actions/teta_cms/database/insert/params.dart';
import '../../../atoms/cms_collections.dart';
import '../../../atoms/db_map.dart';

class TetaCmsInsertControl extends StatefulWidget {
  const TetaCmsInsertControl({
    required this.action,
    required this.onParamsChanged,
    final Key? key,
  }) : super(key: key);

  final TATetaCMSInsert action;
  final Function(TATetaCMSInsertParams params) onParamsChanged;

  @override
  State<TetaCmsInsertControl> createState() => _TetaCmsInsertControlState();
}

class _TetaCmsInsertControlState extends State<TetaCmsInsertControl> {
  String? collectionId;
  List<MapElement>? dbData;

  @override
  void initState() {
    super.initState();
    collectionId = widget.action.params.collectionId;
    dbData = widget.action.params.dbData;
  }

  void updateParams() {
    setState(() {
      widget.onParamsChanged(
        TATetaCMSInsertParams(
          collectionId: collectionId,
          dbData: dbData,
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
                  'INSERT NEW DATA',
                  color: Color(0xFFe7e7e7),
                ),
              ),
            ],
          ),
        ),
        CMSCollectionControl(
          collectionName: collectionId,
          callBack: (final value, final old) {
            collectionId = value;
            updateParams();
          },
        ),
        DBMapControl(
          list: dbData ?? [],
          callBack: (final value, final old) {
            dbData = value;
            updateParams();
          },
        ),
      ],
    );
  }
}
