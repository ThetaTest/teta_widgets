/*import 'package:flutter/material.dart';

// Package imports:
import 'package:mobile_editor/src/elements/features/features.dart';
import 'package:mobile_editor/src/elements/features/menu_voice.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';
import 'package:mobile_editor/src/types/responsive_display_enum.dart';
import 'package:uuid/uuid.dart';

const globalType = "FltBtn";

//ignore: must_be_immutable
class NFloatingButton extends CNode {
  static String get nodeType => globalType;
  static String get nodeName => globalType;
  final String type = globalType;
  String? parent;
  String? nid;
  FFill? fill;
  bool? showLeading;
  List<MenuVoice>? menu;
  List<ResponsiveDisplayEnum>? responsiveDisplay;
  int? index;

  NFloatingButton({
    this.nid,
    this.parent,
    this.responsiveDisplay,
  }) {
    if (nid == null) this.nid = Uuid().v1();
  }

  @override
  List<Object?> get props => [
        this.nid,
        this.parent,
        this.responsiveDisplay,
      ];

  @override
  String toString() => 'BottomBar { nid: $nid, menu: $menu }';

  static NFloatingButton fromJson(Map<String, dynamic> doc) {
    List<String> responsiveDisplayString = ["visible", "visible", "visible"];
    List<ResponsiveDisplayEnum> responsiveDisplay = [];
    if (doc['dynamicRowResponsive'] != null)
      responsiveDisplayString = doc['responsiveDisplay'].cast<String>();
    responsiveDisplayString.forEach((element) {
      if (element == "visible")
        responsiveDisplay.add(ResponsiveDisplayEnum.visible);
      else
        responsiveDisplay.add(ResponsiveDisplayEnum.hidden);
    });

    return NFloatingButton(
      nid: doc['id'],
      responsiveDisplay: responsiveDisplay,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': 'bottomBar',
      't': type,
    };
  }

  @override
  Widget toWidget({
    required List<VariableObject> params,
    required List<VariableObject> states,
    required List<DatasetObject> dataset,
    int? loop,
    required bool forPlay,
  }) =>
      const SizedBox();

  String toCode(BuildContext context) {
    //List<String> listChildren = [];
    //children.map((e) => listChildren.add(e.toCode(context))).toList();
    return """
    Row(
      children: [],
    )""";

    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
  }
}
*/
