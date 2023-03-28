/*import 'package:easy_web_view/easy_web_view.dart';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:mobile_editor/src/elements/draggable.dart';
import 'package:mobile_editor/src/elements/features/box_fit.dart';
import 'package:mobile_editor/src/elements/features/features.dart';
import 'package:mobile_editor/src/elements/node_selection.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';

//ignore: must_be_immutable
class WModelViewer extends StatelessWidget {
  final CNode node;
  final String? nid;
  final FMargins margins;
  final FMargins paddings;
  final FSize sizes;
  final String model;
  final FBoxFit boxFit;
  final FFill fill;
  final bool forPlay;
  final double? index;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  WModelViewer({
    required this.model,
    required this.node,
    required this.margins,
    required this.paddings,
    required this.sizes,
    required this.boxFit,
    this.nid,
    required this.fill,
    required this.forPlay,
    this.index,
    this.loop,
    required this.params,
    required this.states,
    required this.dataset,
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
    final szs = sizes.get(context);
    return Container(
      margin: margins.get(context),
      padding: paddings.get(context),
      child: EasyWebView(
        key: Key(nid!),
        src: """
                <!DOCTYPE html>
                <html>
                <head>
                  <!-- Import the component -->
                  <script type="module" src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"></script>
                  <script nomodule src="https://unpkg.com/@google/model-viewer/dist/model-viewer-legacy.js"></script>
                  <style>
                    body {
                      margin: 0;
                      padding: 0;
                    }
                    model-viewer {
                      --poster-color: transparent;
                      width: 100%;
                      height: ${szs.sizes!.last}px;
                      outline: none;
                      background: transparent;
                    }
                  </style>
                </head>
                <body>
                  <!-- Use it like any other HTML element -->
                  <model-viewer src="https://modelviewer.dev/shared-assets/models/Astronaut.glb" alt="A 3D model of an astronaut" ar auto-rotate camera-controls></model-viewer>
                </body>
              </html>""",
        onLoaded: () {},
        isHtml: true,
        convertToWidgets: false,
        width: double.parse("${MediaQuery.of(context).size.width}"),
        height: sizes.get(context).get(context, forPlay)[1],
      ),
    );
  }
}
*/
