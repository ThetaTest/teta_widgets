/*import 'package:flutter/material.dart';

// Package imports:
import 'package:mobile_editor/src/elements/features/children_ids.dart';
import 'package:mobile_editor/src/elements/features/cross_axis_alignment.dart';
import 'package:mobile_editor/src/elements/features/fill.dart';
import 'package:mobile_editor/src/elements/features/font_size.dart';
import 'package:mobile_editor/src/elements/features/font_weight.dart';
import 'package:mobile_editor/src/elements/features/main_axis_alignment.dart';
import 'package:mobile_editor/src/elements/features/margins.dart';
import 'package:mobile_editor/src/elements/features/sizes.dart';
import 'package:mobile_editor/src/elements/features/text_align.dart';
import 'package:mobile_editor/src/elements/features/text_style.dart';
import 'package:mobile_editor/src/elements/features/text_type_input.dart';
import 'package:mobile_editor/src/elements/nodes/column.dart';
import 'package:mobile_editor/src/elements/nodes/container.dart';
import 'package:mobile_editor/src/elements/nodes/image.dart';
import 'package:mobile_editor/src/elements/nodes/responsive/dynamic_row.dart';
import 'package:mobile_editor/src/elements/nodes/responsive/wrapper.dart';
import 'package:mobile_editor/src/elements/nodes/text.dart';
import 'package:mobile_editor/src/elements/templates/template.dart';
import 'package:nanoid/nanoid.dart';

//ignore: must_be_immutable
class TempSectionTwoColsLeftImageRightTitleDescription extends CTemplate {
  String? id;
  String? name = "Row with two compact columns";
  String? type;

  TempSectionTwoColsLeftImageRightTitleDescription({
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
        fill: FFill(paletteStyle: "xXHoXe56355C+p2"),
        paddings: FMargins(
          margins: ["0", "40", "0", "40"],
        ),
        width: FSize(
          element: SizeElement(
            unit: SizeUnit.percent,
            size: "100%",
          ),
        ),
        height: FSize(
          element: SizeElement(
            unit: SizeUnit.percent,
            size: "auto",
          ),
        ),
      ).toJson(),
      "$id-2": NWrapper(
        nid: "$id-2",
        childrenIds: FChildrenIds(childrenIds: ["$id-3"]),
      ).toJson(),
      "$id-3": NDynamicRow(
        nid: "$id-3",
        childrenIds: FChildrenIds(childrenIds: ["$id-4", "$id-11"]),
      ).toJson(),
      "$id-4": NContainer(
        nid: "$id-4",
        childrenIds: FChildrenIds(childrenIds: ["$id-5"]),
        fill: FFill(paletteStyle: "xXHoXe56355C+p2"),
        paddings: FMargins(
          margins: ["0", "0", "0", "0"],
        ),
        width: FSize(
          element: SizeElement(
            unit: SizeUnit.percent,
            size: "100%",
          ),
        ),
        height: FSize(
          element: SizeElement(
            unit: SizeUnit.percent,
            size: "auto",
          ),
        ),
      ).toJson(),
      "$id-5": NDynamicRow(
        nid: "$id-5",
        childrenIds: FChildrenIds(childrenIds: ["$id-6", "$id-7"]),
      ).toJson(),
      "$id-6": NImage(
        nid: "$id-6",
        image: FTextTypeInput(
          type: FTextTypeEnum.text,
          value: "https://source.unsplash.com/random",
        ),
        width: FSize(
          element: SizeElement(
            unit: SizeUnit.pixel,
            size: "72",
          ),
        ),
        height: FSize(
          element: SizeElement(
            unit: SizeUnit.pixel,
            size: "72",
          ),
        ),
      ).toJson(),
      "$id-7": NContainer(
        nid: "$id-7",
        childrenIds: FChildrenIds(childrenIds: ["$id-8"]),
        fill: FFill(paletteStyle: "xXHoXe56355C+p2"),
        paddings: FMargins(
          margins: ["0", "16", "0", "0"],
        ),
        width: FSize(
          element: SizeElement(
            unit: SizeUnit.percent,
            size: "100%",
          ),
        ),
        height: FSize(
          element: SizeElement(
            unit: SizeUnit.percent,
            size: "auto",
          ),
        ),
      ).toJson(),
      "$id-8": NColumn(
        nid: "$id-8",
        childrenIds: FChildrenIds(childrenIds: ["$id-9", "$id-10"]),
        mainAxisAlignment: FMainAxisAlignment(
          aligns: MainAxisAlignment.center,
        ),
        crossAxisAlignment: FCrossAxisAlignment(
          aligns: CrossAxisAlignment.start,
        ),
      ).toJson(),
      "$id-9": NText(
        nid: "$id-9",
        value: FTextTypeInput(
          type: FTextTypeEnum.text,
          value: 'This is the title',
        ),
        textStyle: FTextStyle(
          textStyleModel: "Important",
          fontSize: FFontSize(sizes: 24),
          fontWeight: FFontWeight(
            fontWeights: FontWeight.w600,
          ),
          fill: FFill(paletteStyle: "xXHoXe56355C+p5"),
          textAlign: FTextAlign(textAligns: TextAlign.center),
        ),
        isFullWidth: true,
      ).toJson(),
      "$id-10": NText(
        nid: "$id-10",
        value: FTextTypeInput(
          type: FTextTypeEnum.text,
          value: 'This is the subheading',
        ),
        textStyle: FTextStyle(
          textStyleModel: "Paragraph",
          fontSize: FFontSize(sizes: 16),
          fontWeight: FFontWeight(
            fontWeights: FontWeight.w400,
          ),
          fill: FFill(paletteStyle: "xXHoXe56355C+p6"),
          textAlign: FTextAlign(textAligns: TextAlign.center),
        ),
        isFullWidth: true,
      ).toJson(),
      "$id-11": NContainer(
        nid: "$id-11",
        childrenIds: FChildrenIds(childrenIds: ["$id-12"]),
        fill: FFill(paletteStyle: "xXHoXe56355C+p2"),
        paddings: FMargins(
          margins: ["0", "24", "0", "0"],
        ),
        width: FSize(
          element: SizeElement(
            unit: SizeUnit.percent,
            size: "100%",
          ),
        ),
        height: FSize(
          element: SizeElement(
            unit: SizeUnit.percent,
            size: "auto",
          ),
        ),
      ).toJson(),
      "$id-12": NDynamicRow(
        nid: "$id-12",
        childrenIds: FChildrenIds(childrenIds: ["$id-13", "$id-14"]),
      ).toJson(),
      "$id-13": NImage(
        nid: "$id-13",
        image: FTextTypeInput(
          type: FTextTypeEnum.text,
          value: "https://source.unsplash.com/random",
        ),
        width: FSize(
          element: SizeElement(
            unit: SizeUnit.pixel,
            size: "72",
          ),
        ),
        height: FSize(
          element: SizeElement(
            unit: SizeUnit.pixel,
            size: "72",
          ),
        ),
      ).toJson(),
      "$id-14": NContainer(
        nid: "$id-14",
        childrenIds: FChildrenIds(childrenIds: ["$id-15"]),
        fill: FFill(paletteStyle: "xXHoXe56355C+p2"),
        paddings: FMargins(
          margins: ["0", "16", "0", "0"],
        ),
        width: FSize(
          element: SizeElement(
            unit: SizeUnit.percent,
            size: "100%",
          ),
        ),
        height: FSize(
          element: SizeElement(
            unit: SizeUnit.percent,
            size: "auto",
          ),
        ),
      ).toJson(),
      "$id-15": NColumn(
        nid: "$id-15",
        childrenIds: FChildrenIds(childrenIds: ["$id-16", "$id-17"]),
        mainAxisAlignment: FMainAxisAlignment(
          aligns: MainAxisAlignment.center,
        ),
        crossAxisAlignment:
            FCrossAxisAlignment(aligns: CrossAxisAlignment.start),
      ).toJson(),
      "$id-16": NText(
        nid: "$id-16",
        value: FTextTypeInput(
          type: FTextTypeEnum.text,
          value: 'This is the title',
        ),
        textStyle: FTextStyle(
          textStyleModel: "Important",
          fontSize: FFontSize(sizes: 24),
          fontWeight: FFontWeight(
            fontWeights: FontWeight.w600,
          ),
          fill: FFill(paletteStyle: "xXHoXe56355C+p5"),
          textAlign: FTextAlign(textAligns: TextAlign.left),
        ),
        isFullWidth: true,
      ).toJson(),
      "$id-17": NText(
        nid: "$id-17",
        value: FTextTypeInput(
          type: FTextTypeEnum.text,
          value: 'This is the subheading',
        ),
        textStyle: FTextStyle(
          textStyleModel: "Paragraph",
          fontSize: FFontSize(sizes: 16),
          fontWeight: FFontWeight(
            fontWeights: FontWeight.w400,
          ),
          fill: FFill(paletteStyle: "xXHoXe56355C+p6"),
          textAlign: FTextAlign(textAligns: TextAlign.center),
        ),
        isFullWidth: true,
      ).toJson(),
    };
    return map;
  }
}
*/
