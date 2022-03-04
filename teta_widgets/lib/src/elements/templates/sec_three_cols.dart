/*import 'package:flutter/material.dart';

// Package imports:
import 'package:nanoid/nanoid.dart';

// Project imports:
import 'package:mobile_editor/src/elements/features/children_ids.dart';
import 'package:mobile_editor/src/elements/features/cross_axis_alignment.dart';
import 'package:mobile_editor/src/elements/features/fill.dart';
import 'package:mobile_editor/src/elements/features/font_size.dart';
import 'package:mobile_editor/src/elements/features/font_weight.dart';
import 'package:mobile_editor/src/elements/features/main_axis_alignment.dart';
import 'package:mobile_editor/src/elements/features/margins.dart';
import 'package:mobile_editor/src/elements/features/sizes.dart';
import 'package:mobile_editor/src/elements/features/text_style.dart';
import 'package:mobile_editor/src/elements/features/text_type_input.dart';
import 'package:mobile_editor/src/elements/nodes/column.dart';
import 'package:mobile_editor/src/elements/nodes/container.dart';
import 'package:mobile_editor/src/elements/nodes/image.dart';
import 'package:mobile_editor/src/elements/nodes/responsive/dynamic_row.dart';
import 'package:mobile_editor/src/elements/nodes/responsive/wrapper.dart';
import 'package:mobile_editor/src/elements/nodes/text.dart';
import 'package:mobile_editor/src/elements/templates/template.dart';

//ignore: must_be_immutable
class TempSectionThreeCols extends CTemplate {
  String? id;
  String? name = "Row with three columns";
  String? type;

  TempSectionThreeCols({
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
        childrenIds: FChildrenIds(childrenIds: ["$id-4", "$id-9", "$id-14"]),
      ).toJson(),
      "$id-4": NContainer(
        nid: "$id-4",
        childrenIds: FChildrenIds(childrenIds: ["$id-5"]),
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
      "$id-5": NColumn(
        nid: "$id-5",
        childrenIds: FChildrenIds(childrenIds: ["$id-6", "$id-7", "$id-8"]),
        mainAxisAlignment: FMainAxisAlignment(
          aligns: MainAxisAlignment.center,
        ),
        crossAxisAlignment: FCrossAxisAlignment(
          aligns: CrossAxisAlignment.center,
        ),
      ).toJson(),
      "$id-6": NImage(
        nid: "$id-6",
        image: FTextTypeInput(
          type: FTextTypeEnum.text,
          value: "https://source.unsplash.com/random",
        ),
        width: FSize(
          element: SizeElement(
            unit: SizeUnit.percent,
            size: "100%",
          ),
        ),
        height: FSize(
          element: SizeElement(
            unit: SizeUnit.pixel,
            size: "250",
          ),
        ),
      ).toJson(),
      "$id-7": NText(
        nid: "$id-7",
        value: FTextTypeInput(
          type: FTextTypeEnum.text,
          value: 'This is the title',
        ),
        textStyle: FTextStyle(
          textStyleModel: "Important",
          fontSize: FFontSize(sizes: 24),
          fontWeight: FFontWeight(fontWeights: FontWeight.w600),
          fill: FFill(paletteStyle: "xXHoXe56355C+p5"),
        ),
      ).toJson(),
      "$id-8": NText(
        nid: "$id-8",
        value: FTextTypeInput(
          type: FTextTypeEnum.text,
          value: 'This is the subheading',
        ),
        textStyle: FTextStyle(
          textStyleModel: "Paragraph",
          fontSize: FFontSize(sizes: 16),
          fontWeight: FFontWeight(fontWeights: FontWeight.w400),
          fill: FFill(paletteStyle: "xXHoXe56355C+p6"),
        ),
      ).toJson(),
      "$id-9": NContainer(
        nid: "$id-9",
        childrenIds: FChildrenIds(childrenIds: ["$id-10"]),
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
      "$id-10": NColumn(
        nid: "$id-10",
        childrenIds: FChildrenIds(childrenIds: ["$id-11", "$id-12", "$id-13"]),
        mainAxisAlignment: FMainAxisAlignment(
          aligns: MainAxisAlignment.center,
        ),
        crossAxisAlignment:
            FCrossAxisAlignment(aligns: CrossAxisAlignment.center),
      ).toJson(),
      "$id-11": NImage(
        nid: "$id-11",
        image: FTextTypeInput(
          type: FTextTypeEnum.text,
          value: "https://source.unsplash.com/random",
        ),
        width: FSize(
          element: SizeElement(
            unit: SizeUnit.percent,
            size: "100%",
          ),
        ),
        height: FSize(
          element: SizeElement(
            unit: SizeUnit.pixel,
            size: "250",
          ),
        ),
      ).toJson(),
      "$id-12": NText(
        nid: "$id-12",
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
        ),
      ).toJson(),
      "$id-13": NText(
        nid: "$id-13",
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
        ),
      ).toJson(),
      "$id-14": NContainer(
        nid: "$id-14",
        childrenIds: FChildrenIds(childrenIds: ["$id-15"]),
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
      "$id-15": NColumn(
        nid: "$id-15",
        childrenIds: FChildrenIds(childrenIds: ["$id-16", "$id-17", "$id-18"]),
        mainAxisAlignment: FMainAxisAlignment(
          aligns: MainAxisAlignment.center,
        ),
        crossAxisAlignment: FCrossAxisAlignment(
          aligns: CrossAxisAlignment.center,
        ),
      ).toJson(),
      "$id-16": NImage(
        nid: "$id-16",
        image: FTextTypeInput(
          type: FTextTypeEnum.text,
          value: "https://source.unsplash.com/random",
        ),
        width: FSize(
          element: SizeElement(
            unit: SizeUnit.percent,
            size: "100%",
          ),
        ),
        height: FSize(
          element: SizeElement(
            unit: SizeUnit.pixel,
            size: "250",
          ),
        ),
      ).toJson(),
      "$id-17": NText(
        nid: "$id-17",
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
        ),
      ).toJson(),
      "$id-18": NText(
        nid: "$id-18",
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
        ),
      ).toJson(),
    };
    return map;
  }
}
*/
