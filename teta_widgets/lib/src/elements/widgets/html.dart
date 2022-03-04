/*import 'package:easy_web_view/easy_web_view.dart';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mobile_editor/src/elements/draggable.dart';
import 'package:mobile_editor/src/elements/features/features.dart';
import 'package:mobile_editor/src/elements/features/text_type_input.dart';
import 'package:mobile_editor/src/elements/node_selection.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';

//ignore: must_be_immutable
class WHTML extends StatelessWidget {
  CNode node;
  String? nid;
  FMargins margins;
  FMargins paddings;
  FSize? sizes;
  FTextTypeInput value;
  bool forPlay;
  double? index;
  int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  WHTML({
    required this.value,
    required this.node,
    required this.margins,
    required this.paddings,
    this.sizes,
    this.nid,
    required this.forPlay,
    this.index,
    required this.params,
    required this.states,
    required this.dataset,
    this.loop,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableNode(
      node: node,
      child: NodeSelection(
          node: node, child: body(context), forPlay: forPlay, nid: nid),
      forPlay: forPlay,
    );
  }

  Widget body(BuildContext context) {
    final szs = sizes!.get(context);
    return Container(
      margin: margins.get(context),
      padding: paddings.get(context),
      width: sizes!.get(context).get(context, forPlay)[0],
      height: sizes!.get(context).get(context, forPlay)[1],
      child: html(szs),
    );
  }

  Widget html(SizeElement szs) {
    String finalValue = "${value.value}";
    try {
      final param = params.firstWhere(
          (element) => element.id == "47537cf0-b2e9-11eb-8da3-f5fdb7901889");
      finalValue = param.value ?? param.defaultValue;
    } catch (e) {}
    if (value.type == FTextTypeEnum.param) {
      try {
        final param =
            params.firstWhere((element) => element.name == value.paramName);
        finalValue =
            (forPlay) ? param.value ?? param.defaultValue : param.defaultValue!;
      } catch (e) {}
    }
    if (value.type == FTextTypeEnum.state) {
      try {
        final state =
            states.firstWhere((element) => element.name == value.stateName);
        finalValue =
            (forPlay) ? state.value ?? state.defaultValue : state.defaultValue;
      } catch (e) {}
    }
    if (value.type == FTextTypeEnum.dataset) {
      try {
        final db = dataset
            .firstWhere((element) => element.name == value.datasetName)
            .map![loop!];
        finalValue = db["${value.datasetAttr}"];
      } catch (e) {
        print(e);
        finalValue = "${value.datasetAttr}";
      }
    }
    return EasyWebView(
      key: Key(nid!),
      src: "$finalValue",
      onLoaded: () {},
      isHtml: true,
      convertToWidgets: true,
    );
  }
}
*/
