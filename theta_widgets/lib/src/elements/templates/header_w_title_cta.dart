/*import 'package:flutter/material.dart';

// Package imports:
import 'package:mobile_editor/src/elements/features/children_ids.dart';
import 'package:mobile_editor/src/elements/features/cross_axis_alignment.dart';
import 'package:mobile_editor/src/elements/features/fill.dart';
import 'package:mobile_editor/src/elements/features/font_size.dart';
import 'package:mobile_editor/src/elements/features/font_weight.dart';
import 'package:mobile_editor/src/elements/features/main_axis_alignment.dart';
import 'package:mobile_editor/src/elements/features/sizes.dart';
import 'package:mobile_editor/src/elements/features/text_style.dart';
import 'package:mobile_editor/src/elements/features/text_type_input.dart';
import 'package:mobile_editor/src/elements/nodes/column.dart';
import 'package:mobile_editor/src/elements/nodes/container.dart';
import 'package:mobile_editor/src/elements/nodes/text.dart';
import 'package:mobile_editor/src/elements/templates/template.dart';
import 'package:nanoid/nanoid.dart';

//ignore: must_be_immutable
class TempHeaderWTitleCTA extends CTemplate {
  String? id;
  String? name = "Header with Title & CTA";
  String? type;

  TempHeaderWTitleCTA({
    this.id,
    this.name,
    this.type,
  }) {
    this.id = nanoid(12);
  }

  @override
  String toString() => 'Default Template { }';

  @override
  List<Object> get props => [
        name!,
      ];

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map();
    map = {
      "$id-1": NContainer(
          nid: "$id-1",
          childrenIds: FChildrenIds(childrenIds: ["$id-2"]),
          fill: FFill().ready(FFillType.image),
          width: FSize(
            element: SizeElement(
              unit: SizeUnit.percent,
              size: "100%",
            ),
          ),
          height: FSize(
            element: SizeElement(
              unit: SizeUnit.percent,
              size: "40",
            ),
          )).toJson(),
      "$id-2": NColumn(
        nid: "$id-2",
        childrenIds: FChildrenIds(childrenIds: ["$id-3", "$id-4"]),
        mainAxisAlignment: FMainAxisAlignment(
          aligns: MainAxisAlignment.center,
        ),
        crossAxisAlignment: FCrossAxisAlignment(
          aligns: CrossAxisAlignment.center,
        ),
      ).toJson(),
      "$id-3": NText(
        nid: "$id-3",
        value: FTextTypeInput(
          type: FTextTypeEnum.text,
          value: 'This is the title',
        ),
        textStyle: FTextStyle(
          textStyleModel: "Hero",
          fontSize: FFontSize(sizes: 32),
          fontWeight: FFontWeight(
            fontWeights: FontWeight.w600,
          ),
          fill: FFill(
            type: FFillType.solid,
            levels: [
              FFillElement(
                color: 'ffffff',
                stop: 0,
              )
            ],
          ),
        ),
      ).toJson(),
      "$id-4": NText(
        nid: "$id-4",
        value: FTextTypeInput(
          type: FTextTypeEnum.text,
          value: 'This is the subheading',
        ),
        textStyle: FTextStyle(
          textStyleModel: "Subheadline",
          fontSize: FFontSize(sizes: 16),
          fontWeight: FFontWeight(
            fontWeights: FontWeight.w400,
          ),
          fill: FFill(
            type: FFillType.solid,
            levels: [
              FFillElement(
                color: 'ffffff',
                stop: 0,
              )
            ],
          ),
        ),
      ).toJson(),
    };
    return map;
  }
}
*/
