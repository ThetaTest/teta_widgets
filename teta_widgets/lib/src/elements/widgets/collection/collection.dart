/// FIXME: This widget is deprecated

/*import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_editor/src/blocs/data/index.dart';
import 'package:mobile_editor/src/blocs/focus_page/index.dart';
import 'package:mobile_editor/src/blocs/focus_project/index.dart';
import 'package:mobile_editor/src/elements/builder/drag_target.dart';
import 'package:mobile_editor/src/elements/builder/draggable.dart';
import 'package:mobile_editor/src/elements/builder/node_selection.dart';
import 'package:mobile_editor/src/elements/features/text_type_input.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/models/data.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';
import 'package:nil/nil.dart';

class WCollection extends StatefulWidget {
  final CNode node;
  final CNode? child;
  final String? nid;
  final FTextTypeInput? value;
  final bool forPlay;
  final double? index;
  final bool? isHorizontalScroll;
  final bool? displayRealData;
  final String? dataModel;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  const WCollection({
    required this.node,
    required this.child,
    required this.value,
    required this.nid,
    required this.forPlay,
    this.index,
    this.isHorizontalScroll,
    this.displayRealData,
    required this.params,
    required this.states,
    required this.dataset,
    this.dataModel,
  });

  @override
  _WCollectionState createState() => _WCollectionState();
}

class _WCollectionState extends State<WCollection> {
  DatasetObject? map;
  List<String>? options = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (!widget.forPlay)
        ? DraggableNode(
            node: widget.node,
            child: NodeSelection(
              node: widget.node,
              forPlay: widget.forPlay,
              nid: widget.nid,
              child: body(context),
            ),
            forPlay: widget.forPlay,
          )
        : body(context);
  }

  Widget body(BuildContext context) {
    return widget.child != null
        ? BlocBuilder<DataBloc, List<DataModel>>(
            builder: (context, state) {
              DataModel? data;
              try {
                data = state.firstWhere(
                  (element) => widget.value!.datasetName! == element.name,
                );
              } catch (e) {
                print(e);
              }
              if (data == null) return const SizedBox();
              if (map == null) fetch(data, context);
              if (map != null) {
                final List<DatasetObject> list = [];
                list.addAll(widget.dataset);
                list.add(map!);
                final prjState =
                    BlocProvider.of<FocusProjectBloc>(context).state;
                try {
                  if (pageFocused.scaffold!.dataset != null) {
                    bool flag = true;
                    pageFocused.scaffold!.dataset!.forEach((element) {
                      if (element.name == map!.name) flag = false;
                    });
                    if (flag) pageFocused.scaffold!.dataset!.add(map!);
                  } else
                    pageFocused.scaffold!.dataset = [map!];
                  if (prjState is ProjectLoaded) {
                    prjState.prj.pages!.forEach((element) {
                      if (element.id == pageFocused.id) {
                        if (element.scaffold!.dataset != null) {
                          bool flag = true;
                          element.scaffold!.dataset!.forEach((element) {
                            if (element.name == map!.name) flag = false;
                          });
                          if (flag) element.scaffold!.dataset!.add(map!);
                        } else
                          element.scaffold!.dataset = [map!];
                      }
                    });
                  }
                } catch (e) {}

                return Column(
                  children: [
                    for (int i = 0; i < map!.totalLoop!; i++)
                      widget.child!.toWidget(
                        loop: i,
                        forPlay: widget.forPlay,
                        params: widget.params,
                        states: widget.states,
                        dataset: list,
                      )
                  ],
                );
              } else
                return Center(
                  child: CircularProgressIndicator(),
                );
            },
          )
        : widget.child != null
            ? widget.child!.toWidget(
                forPlay: widget.forPlay,
                params: widget.params,
                states: widget.states,
                dataset: widget.dataset,
              )
            : DragTargetWidget(node: widget.node);
  }

  Future<void> fetch(DataModel data, BuildContext context) async {
    print("FETCH COLLECTION");
    final result = await data.posts();
    print("result.map: ${result.map}");
    setState(() {
      map = result;
    });
  }
}
*/
