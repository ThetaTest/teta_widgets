// Flutter imports:
// ignore_for_file: public_member_api_docs, avoid_dynamic_calls

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_repositories/src/project_repository.dart';
import 'package:teta_repositories/src/project_styles_repository.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/atoms/fill.dart';
import 'package:teta_widgets/src/elements/controls/atoms/font_family.dart';
import 'package:teta_widgets/src/elements/controls/atoms/font_size.dart';
import 'package:teta_widgets/src/elements/controls/atoms/font_style.dart';
import 'package:teta_widgets/src/elements/controls/atoms/font_weight.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text_align.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text_decoration.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text_direction.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text_styles.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/text_style.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class TextPrefabControl extends StatelessWidget {
  const TextPrefabControl({
    required this.textStyle,
    required this.keyValue,
    final Key? key,
    this.title,
  }) : super(key: key);

  final FTextStyle textStyle;
  final String? title;
  final String keyValue;

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: [
        TextStylesControl(
          node: node,
          textStyle: textStyle,
          callBack: (final textStyleModel, final flag, final old) {
            if (textStyleModel == null) return;
            if (flag) {
              sl.get<ProjectStylesRepository>().assignTextStyle(
                    styleName: textStyleModel,
                    node: node,
                    keyValue: keyValue,
                  );
            }
            final old = textStyle;
            textStyle.textStyleModel = textStyleModel;
            ControlBuilder.toDB(
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
                child: TParagraph(
                  title ?? 'Text Properties',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: FontSizeControl(
                  node: node,
                  textStyle: textStyle,
                  callBack: (final value, final old) {
                    ControlBuilder.toDB(
                      node,
                      context,
                      keyValue,
                      value,
                      old,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: FontFamilyControl(
                  node: node,
                  textStyle: textStyle,
                  callBack: (final value, final old) => ControlBuilder.toDB(
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
                child: FontWeightControl(
                  node: node,
                  textStyle: textStyle,
                  callBack: (final value, final old) => ControlBuilder.toDB(
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
                        callBack: (final value, final old) =>
                            ControlBuilder.toDB(
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
                  callBack: (final value, final old) => ControlBuilder.toDB(
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
                  callBack: (final value, final old) => ControlBuilder.toDB(
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
        if (kDebugMode)
          TextDirectionControl(
            node: node,
            textDirection: textStyle.textDirection!,
            callBack: (final dir, final old) {
              final old = FTextStyle.fromJson(textStyle.toJson());
              textStyle.textDirection = dir;
              ControlBuilder.toDB(
                node,
                context,
                keyValue,
                textStyle.toJson(),
                old,
              );
            },
          ),
        const Gap(16),
        FillControl(
          title: 'Text Color',
          fill: textStyle.fill ?? FFill(),
          node: node,
          isImageEnabled: false,
          isNoneEnabled: false,
          type: FillTypeControlType.onlySolid,
          callBack: (final color, final isStyled, final old) {
            if (!isStyled) {
              final old = FTextStyle.fromJson(textStyle.toJson());
              textStyle.fill = color;
              ControlBuilder.toDB(
                node,
                context,
                keyValue,
                textStyle.toJson(),
                old,
              );
            }
            //! TODO:
            /*else {
              if (textStyle.fill!.paletteStyle is int) {
                sl.get<ProjectStylesRepository>().updateColorStyle(
                      ColorStyleModel(
                        id: textStyle.fill!.paletteStyle! as int,
                        channelId: Constants.instance.currentChannelID!,
                        fill: color,
                        light: textStyle
                      ),
                    );
              }
            }*/
          },
        ),
      ],
    );
  }
}
