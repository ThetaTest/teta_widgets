// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hovering/hovering.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/atoms/map_element.dart';
import 'package:teta_widgets/src/elements/controls/http_params_element.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class HttpParamsControl extends StatefulWidget {
  const HttpParamsControl({
    required this.node,
    required this.list,
    required this.page,
    required this.callBack,
    final Key? key,
    this.title,
  }) : super(key: key);

  final CNode node;
  final List<MapElement> list;
  final PageObject page;
  final Function(List<MapElement>, List<MapElement>) callBack;
  final String? title;

  @override
  HttpParamsControlState createState() => HttpParamsControlState();
}

class HttpParamsControlState extends State<HttpParamsControl> {
  int? nodeId;
  bool? isUpdated;
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    nodeId = widget.node.nid;
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<FocusBloc, List<CNode>>(
      listener: (final context, final state) {
        if (state.isNotEmpty) {
          if (state.first.nid != nodeId) {
            setState(() {
              isUpdated = true;
            });
            nodeId = state.first.nid;
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: widget.list.isEmpty ? 0 : 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  THeadline3(
                    widget.title ?? 'Add Params',
                  ),
                  Row(
                    children: [
                      BounceSmall(
                        onTap: () {
                          final old = widget.list;
                          widget.list.add(
                            MapElement(
                              key: '',
                              value: FTextTypeInput(),
                            ),
                          );
                          widget.callBack(widget.list, old);
                        },
                        child: HoverWidget(
                          hoverChild: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                              ),
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 24,
                              color: Colors.white,
                            ),
                          ),
                          onHover: (final e) {},
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: widget.list
                    .map(
                      (final e) => Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: HttpParamsElementControl(
                          node: widget.node,
                          value: e,
                          page: widget.page,
                          callBack: (final value, final old) {
                            final old = widget.list;
                            final index = widget.list.indexOf(e);
                            widget.list[index] = value;
                            widget.callBack(widget.list, old);
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
