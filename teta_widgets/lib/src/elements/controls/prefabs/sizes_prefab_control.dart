// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/src/design_system/palette.dart';
import 'package:teta_core/src/design_system/text.dart';
import 'package:teta_core/src/models/page.dart';
import 'package:teta_core/src/models/project.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/atoms/size.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class SizesPrefabControl extends StatelessWidget {
  const SizesPrefabControl({
    required this.prj,
    required this.page,
    required this.node,
    required this.values,
    final Key? key,
  }) : super(key: key);

  final ProjectObject prj;
  final PageObject page;
  final CNode node;
  final List<FSize> values;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 16, bottom: 8),
            child: CText(
              'Sizes',
              color: Palette.white,
              weight: FontWeight.bold,
            ),
          ),
          SizeControl(
            node: node,
            size: values.first,
            isWidth: true,
            title: 'Width',
            keyAttr: DBKeys.width,
            isFromSizesPrefab: true,
            callBack: (final value, final old) {
              ControlBuilder.toDB(
                prj,
                page,
                node,
                context,
                DBKeys.width,
                value,
                old,
              );
            },
          ),
          SizeControl(
            node: node,
            size: values.last,
            isWidth: false,
            title: 'Height',
            keyAttr: DBKeys.height,
            isFromSizesPrefab: true,
            callBack: (final value, final old) => ControlBuilder.toDB(
              prj,
              page,
              node,
              context,
              DBKeys.height,
              value,
              old,
            ),
          ),
        ],
      ),
    );
  }
}
