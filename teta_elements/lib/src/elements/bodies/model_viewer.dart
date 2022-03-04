/*import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase/firebase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

// Project imports:
import 'package:mobile_editor/src/blocs/hover/index.dart';
import 'package:mobile_editor/src/elements/features/box_fit.dart';
import 'package:mobile_editor/src/elements/features/features.dart';
import 'package:mobile_editor/src/elements/nodes/nnull.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/elements/widgets/model-viewer.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';

const globalType = "ModelViewer";
const global_name = "Model Viewer";

//ignore: must_be_immutable
class NModelViewer extends CNode {
  static String get nodeType => globalType;
  static String get nodeName => global_name;
  final String? nodeIcon = "w_icons/spacer.png";
  final String? displayName = global_name;
  final String type = globalType;
  String? parent;
  String? nid;
  CNode? child;
  FMargins? margins;
  FMargins? paddings;
  FSize? sizes;
  String? model;
  FBoxFit? boxFit;
  FFill? fill;
  int? index;

  String? prjId;
  String? pageId;
  BuildContext? context;
  StreamSubscription? streamSubscription;
  Database db = database();
  DatabaseReference? ref;

  NModelViewer({
    this.nid,
    this.parent,
    this.child,
    this.sizes,
    this.model,
    this.boxFit,
    this.margins,
    this.paddings,
    this.fill,
    this.prjId,
    this.pageId,
    this.context,
  }) {
    if (this.nid == null) this.nid = Uuid().v1();

    StreamConnection.connect(
        prjId, pageId, nid, context, (map) => mergeJson(map));
  }

  static NModelViewer fromJson(String id,
    Map<String, dynamic> doc,
    String prjId,
    String pageId,
    BuildContext context,
  ) {
    return NModelViewer(
      nid: doc['id'],
      model: doc['model'],
      boxFit: FBoxFit().fromJson(doc['boxFit']),
      margins: FMargins().fromJson(doc['margins']),
      paddings: FMargins().fromJson(doc['paddings']),
      sizes: FSize().fromJson(doc['sizes']),
      fill: FFill().fromJson(doc['fill']),
      prjId: prjId,
      pageId: pageId,
      context: context,
    );
  }

  mergeJson(
    Map<String, dynamic> map,
  ) {
    map.keys.forEach((key) {
      if (key == 'margins') margins = FMargins().fromJson(map[key]);
      if (key == 'paddings') paddings = FMargins().fromJson(map[key]);
      if (key == 'model') model = map[key];
      if (key == 'boxFit') boxFit = FBoxFit().fromJson(map[key]);
      if (key == 'sizes') sizes = FSize().fromJson(map[key]);
      if (key == 'fill') fill = FFill().fromJson(map[key]);
    });
  }

  Map<String, dynamic> toJson() {
    return {
      'id': nid,
      't': type,
      'margins': (margins != null) ? margins!.toJson() : FMargins().toJson(),
      'paddings': (paddings != null) ? paddings!.toJson() : FMargins().toJson(),
      'model': model,
      'boxFit': (boxFit != null) ? boxFit!.toJson() : FBoxFit().toJson(),
      'sizes': (sizes != null) ? sizes!.toJson() : FSize().toJson(),
      'fill': (fill != null)
          ? fill!.toJson()
          : FFill().ready(FFillType.solid).toJson(),
    };
  }

  @override
  String toString() => 'ModelViewer { nid: $nid, model: $model }';

  @override
  Widget toWidget({
    required List<VariableObject> params,
    required List<VariableObject> states,
    required List<DatasetObject> dataset,
    int? loop,
    required bool forPlay,
  }) =>
      WModelViewer(
        node: this,
        nid: nid,
        model: model!,
        margins: margins!,
        paddings: paddings!,
        boxFit: boxFit!,
        sizes: sizes!,
        fill: fill!,
        forPlay: forPlay,
        params: params,
        states: states,
        dataset: dataset,
      );

  String toCode(BuildContext context) {
    return """
      TModelViewer(
        model: "$model",
        margins: ${margins?.toCode()},
        paddings: ${paddings?.toCode()},
        boxFit: ${boxFit?.toCode()},
        sizes: ${sizes?.toCode()},
        fill: ${fill?.toCode()},
      ) ,
    """;
  }
}
*/
