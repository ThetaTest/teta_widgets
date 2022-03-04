// Flutter imports:
// ignore_for_file: public_member_api_docs, avoid_dynamic_calls

import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/src/design_system/palette.dart';
import 'package:teta_core/src/design_system/text.dart';
import 'package:teta_core/src/models/page.dart';
import 'package:teta_core/src/models/palette.dart';
import 'package:teta_core/src/models/project.dart';
import 'package:teta_core/src/repositories/project.dart';
import 'package:teta_core/src/repositories/queries/color_style.dart';
import 'package:teta_widgets/src/elements/controls/atoms/fill.dart';
import 'package:teta_widgets/src/elements/controls/atoms/font_family.dart';
import 'package:teta_widgets/src/elements/controls/atoms/font_size.dart';
import 'package:teta_widgets/src/elements/controls/atoms/font_style.dart';
import 'package:teta_widgets/src/elements/controls/atoms/font_weight.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text_align.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text_decoration.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text_styles.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/text_style.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class TextPrefabControl extends StatelessWidget {
  const TextPrefabControl({
    Key? key,
    required this.prj,
    required this.page,
    required this.node,
    required this.textStyle,
    this.title,
    required this.keyValue,
  }) : super(key: key);

  final ProjectObject prj;
  final PageObject page;
  final CNode node;
  final FTextStyle textStyle;
  final String? title;
  final String keyValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextStylesControl(
          node: node,
          textStyle: textStyle,
          callBack: (textStyleModel, flag, old) {
            if (flag) {
              ProjectRepository.addTextStyle(
                prjId: prj.id,
                text: node,
                name: textStyleModel,
              );
            }
            final old = textStyle;
            textStyle.textStyleModel = textStyleModel;
            ControlBuilder.toDB(
              prj,
              page,
              node,
              context,
              keyValue,
              textStyle.toJson(),
              old.toJson(),
            );
          },
        ),
        const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Divider(height: 1, color: Colors.white38),
        ),
        if (!(node.globalType == NType.text) ||
            node.body.attributes[keyValue]?.textStyleModel == null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: CText(
                  title ?? 'Text Properties',
                  color: Palette.white,
                  weight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 4,
                        ),
                        child: FontSizeControl(
                          node: node,
                          textStyle: textStyle,
                          callBack: (value, old) {
                            ControlBuilder.toDB(
                              prj,
                              page,
                              node,
                              context,
                              keyValue,
                              value,
                              old,
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: FontFamilyControl(
                          node: node,
                          textStyle: textStyle,
                          callBack: (value, old) => ControlBuilder.toDB(
                            prj,
                            page,
                            node,
                            context,
                            keyValue,
                            value,
                            old,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: FontWeightControl(
                  node: node,
                  textStyle: textStyle,
                  callBack: (value, old) => ControlBuilder.toDB(
                    prj,
                    page,
                    node,
                    context,
                    keyValue,
                    value,
                    old,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: FontStyleControls(
                        node: node,
                        textStyle: textStyle,
                        callBack: (value, old) => ControlBuilder.toDB(
                          prj,
                          page,
                          node,
                          context,
                          keyValue,
                          value,
                          old,
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 8)),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          child: Row(
            children: [
              Expanded(
                child: TextAlignControls(
                  node: node,
                  textStyle: textStyle,
                  callBack: (value, old) => ControlBuilder.toDB(
                    prj,
                    page,
                    node,
                    context,
                    keyValue,
                    value,
                    old,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(left: 8)),
              Expanded(
                child: TextDecorationControl(
                  node: node,
                  textStyle: textStyle,
                  callBack: (value, old) => ControlBuilder.toDB(
                    prj,
                    page,
                    node,
                    context,
                    keyValue,
                    value,
                    old,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          child: Divider(height: 1, color: Colors.white38),
        ),
        FillControl(
          title: 'Fill',
          fill: textStyle.fill ?? FFill(),
          node: node,
          isImageEnabled: false,
          isNoneEnabled: false,
          type: FillTypeControlType.onlySolid,
          callBack: (color, isStyled, old) {
            if (!isStyled) {
              final old = FTextStyle.fromJson(textStyle.toJson());
              textStyle.fill = color;
              ControlBuilder.toDB(
                prj,
                page,
                node,
                context,
                keyValue,
                textStyle.toJson(),
                old,
              );
            } else {
              ColorStyleQueries.update(
                PaletteModel(id: textStyle.fill!.paletteStyle!, fill: color),
              );
            }
          },
        ),
      ],
    );
  }
}
