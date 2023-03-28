/// FIXME: This widget is deprecated

/*import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_editor/src/cubits/device_mode/cubit.dart';
import 'package:mobile_editor/src/design_system/palette.dart';
import 'package:mobile_editor/src/design_system/text.dart';
import 'package:mobile_editor/src/elements/builder/draggable.dart';
import 'package:mobile_editor/src/elements/builder/node_selection.dart';
import 'package:mobile_editor/src/elements/controls/key_constants.dart';
import 'package:mobile_editor/src/elements/features/features.dart';
import 'package:mobile_editor/src/elements/nodes/enum.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';
import 'package:mobile_editor/src/types/dynamic_row_responsive_enum.dart';
import 'package:mobile_editor/src/utils/responsive_system/enum/devices.dart';
import 'package:uuid/uuid.dart';

//ignore: must_be_immutable
class WDynamicRow extends StatelessWidget {
  final CNode node;
  String? nid;
  List<CNode>? children;
  final FMargins? margins;
  final FMargins? paddings;
  final double? index;
  final bool forPlay;
  final double? indexUpdatedAt;
  final int? numberOfColumns;
  final List<DynamicRowResponsiveEnum>? dynamicRowResponsive;
  final String? component;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  WDynamicRow({
    this.nid,
    this.children,
    required this.node,
    this.margins,
    this.paddings,
    required this.forPlay,
    this.index,
    this.indexUpdatedAt,
    this.numberOfColumns,
    this.dynamicRowResponsive,
    this.component,
    this.loop,
    required this.params,
    required this.states,
    required this.dataset,
  }) {
    if (this.nid == null) this.nid = Uuid().v1();
    if (this.children == null) this.children = [];
  }

  Widget build(BuildContext context) {
    return (!forPlay)
        ? DraggableNode(
            node: node,
            child: NodeSelection(
                node: node, child: body(context), forPlay: forPlay, nid: nid),
            forPlay: forPlay,
          )
        : body(context);
  }

  Widget body(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: margins!.get(context),
      padding: paddings!.get(context),
      child: BlocBuilder<DeviceModeCubit, DeviceScreenType>(
        builder: (context, state) {
          if (state == DeviceScreenType.Desktop) {
            return inline(context);
          }
          if (state == DeviceScreenType.Tablet) {
            return dynamicRowResponsive![1] == DynamicRowResponsiveEnum.inline
                ? inline(context)
                : block();
          }
          return dynamicRowResponsive![0] == DynamicRowResponsiveEnum.inline
              ? inline(context)
              : block();
        },
      ),
    );
  }

  Widget inline(BuildContext context) {
    if (children != null) {
      return Row(
        children: children!
            .map(
              (e) => e.globalType == NType.image &&
                      (e.body.attributes[DBKeys.width]?.element?.unit ==
                              SizeUnit.pixel &&
                          e.body.attributes[DBKeys.width].get(
                                  context: context,
                                  forPlay: forPlay,
                                  isWidth: true) !=
                              double.maxFinite)
                  ? loop != null
                      ? e.toWidget(
                          loop: loop,
                          forPlay: forPlay,
                          params: params,
                          states: states,
                          dataset: dataset,
                        )
                      : e.toWidget(
                          forPlay: forPlay,
                          params: params,
                          states: states,
                          dataset: dataset,
                        )
                  : Expanded(
                      child: loop != null
                          ? e.toWidget(
                              loop: loop,
                              forPlay: forPlay,
                              params: params,
                              states: states,
                              dataset: dataset,
                            )
                          : e.toWidget(
                              forPlay: forPlay,
                              params: params,
                              states: states,
                              dataset: dataset,
                            ),
                    ),
            )
            .toList(),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CText(
              'Dynamic List',
              size: 16,
              color: Palette.black,
            ),
            GestureDetector(
              child: const Icon(Icons.info, size: 24, color: Colors.black),
            ),
          ],
        ),
      );
    }
  }

  Widget block() {
    if (children != null) {
      return Column(
        children: children!
            .map(
              (e) => loop != null
                  ? e.toWidget(
                      loop: loop,
                      forPlay: forPlay,
                      params: params,
                      states: states,
                      dataset: dataset,
                    )
                  : e.toWidget(
                      forPlay: forPlay,
                      params: params,
                      states: states,
                      dataset: dataset,
                    ),
            )
            .toList(),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CText(
              'Dynamic List',
              size: 16,
              color: Palette.black,
            ),
            GestureDetector(
              child: const Icon(Icons.info, size: 24, color: Colors.black),
            ),
          ],
        ),
      );
    }
  }
}
*/
