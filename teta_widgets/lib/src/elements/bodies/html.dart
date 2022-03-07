/*import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase/firebase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_editor/src/blocs/hover/index.dart';
import 'package:mobile_editor/src/elements/controls/key_constants.dart';
import 'package:mobile_editor/src/elements/controls/type.dart';
import 'package:mobile_editor/src/elements/features/box_fit.dart';
import 'package:mobile_editor/src/elements/features/features.dart';
import 'package:mobile_editor/src/elements/features/text_type_input.dart';
import 'package:mobile_editor/src/elements/nodes/nnull.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/elements/widgets/html.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';
import 'package:uuid/uuid.dart';

const globalType = "HTML";

//ignore: must_be_immutable
class NHTML extends CNode {
  static String get nodeType => globalType;
  static String get nodeName => globalType;
  final String? nodeIcon = "w_icons/spacer.png";
  final String? displayName = globalType;
  final List<String>? synonymous = ['html', 'code', 'markdown'];
  final String type = globalType;
  String? parent;
  String? nid;
  FSize? sizes;
  FTextTypeInput? value;
  int? index;

  String? prjId;
  String? pageId;
  BuildContext? context;
  StreamSubscription? streamSubscription;
  Database db = database();
  DatabaseReference? ref;

  NHTML({
    this.nid,
    this.parent,
    this.sizes,
    this.value,
    this.prjId,
    this.pageId,
    this.context,
  }) {
    if (this.nid == null) this.nid = Uuid().v1();

    StreamConnection.connect(
        prjId, pageId, nid, context, (map) => mergeJson(map));
  }

  @override
  List<Object?> get props => [
        this.nid,
        this.parent,
        this.sizes,
        this.value,
        this.type,
        this.prjId,
        this.pageId,
        this.context,
      ];

  @override
  List<ControlModel> get controls => [];

  static NHTML fromJson(String id,
    Map<String, dynamic> doc,
    String prjId,
    String pageId,
    BuildContext context,
  ) {
    return NHTML(
      nid: doc[DBKeys.id],
      value: FTextTypeInput().fromJson(doc[DBKeys.value]),
      sizes: FSize().fromJson(doc[DBKeys.sizes]),
      prjId: prjId,
      pageId: pageId,
      context: context,
    );
  }

  Map<String, dynamic> mergeJson(
    Map<String, dynamic> map,
  ) {
    Map<String, dynamic> result = Map();
    map.keys.forEach((key) {
      if (key == DBKeys.value) value = FTextTypeInput().fromJson(map[key]);
      if (key == DBKeys.sizes) sizes = FSize().fromJson(map[key]);
    });
    return result;
  }

  Map<String, dynamic> toJson() {
    return {
       
      DBKeys.type: globalType,
      DBKeys.value: (value != null)
          ? value!.toJson()
          : FTextTypeInput(
                  value: "<h1>Write HTML</h1>", type: FTextTypeEnum.text)
              .toJson(),
      DBKeys.sizes: (sizes != null)
          ? sizes!.toJson()
          : FSize(
              sizes: SizeElement(sizes: ["max", "150"], unit: SizeUnit.pixel),
            ).toJson(),
    };
  }

  @override
  String toString() => 'HTML { nid: $nid, value: $value }';

  @override
  Widget toWidget({
    required List<VariableObject> params,
    required List<VariableObject> states,
    required List<DatasetObject> dataset,
    int? loop,
    required bool forPlay,
  }) =>
      WHTML(
        node: this,
        nid: nid,
        value: value!,
        margins: margins!,
        paddings: paddings!,
        sizes: sizes,
        forPlay: forPlay,
        params: params,
        states: states,
        dataset: dataset,
        loop: loop,
      );

  String toCode(BuildContext context) {
    return """
      THtml(
        value: ${value?.toCode()},
        margins: ${margins?.toCode()},
        paddings: ${paddings?.toCode()},
        sizes: ${sizes?.toCode()},
      ) ,
    """;
  }
}
*/
