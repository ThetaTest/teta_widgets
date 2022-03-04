// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
// Package imports:
import 'package:hovering/hovering.dart';
// Project imports:
import 'package:teta_core/src/design_system/palette.dart';
import 'package:teta_core/src/design_system/text.dart';
import 'package:teta_core/src/models/page.dart';
import 'package:teta_core/src/models/project.dart';
import 'package:teta_widgets/src/elements/controls/atoms/action_element.dart';
import 'package:teta_widgets/src/elements/features/action.dart';
import 'package:teta_widgets/src/elements/features/actions/element.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:uuid/uuid.dart';

class ActionControl extends StatefulWidget {
  const ActionControl({
    required this.prj,
    required this.page,
    required this.node,
    required this.action,
    required this.callBack,
    Key? key,
  }) : super(key: key);

  final ProjectObject prj;
  final PageObject page;
  final CNode node;
  final FAction action;
  final Function(FAction, FAction) callBack;

  @override
  ActionControlState createState() => ActionControlState();
}

class ActionControlState extends State<ActionControl> {
  String? id;
  String? dropdown;
  PageObject? pageObject;

  @override
  void initState() {
    super.initState();
    if (widget.prj.pages != null) pageObject = widget.prj.pages!.first;
    if (pageObject != null) dropdown = pageObject!.name;
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: widget.action.actions?.isEmpty ?? true ? 0 : 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CText(
                  'Actions',
                  color: Palette.white,
                  size: 16,
                  weight: FontWeight.bold,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        final old = widget.action;
                        widget.action.actions = [
                          ...widget.action.actions ?? [],
                          FActionElement(id: const Uuid().v1())
                        ];
                        widget.callBack(widget.action, old);
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
                        onHover: (e) {},
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
          Column(
            children: widget.action.actions!
                .map(
                  (e) => ActionElementControl(
                    name: 'Action ${widget.action.actions!.indexOf(e)}',
                    element: e,
                    prj: widget.prj,
                    page: widget.page,
                    node: widget.node,
                    callBack: (value, old) {
                      final old = widget.action;
                      final index = widget.action.actions!.indexOf(e);
                      widget.action.actions![index] = value;
                      widget.callBack(widget.action, old);
                    },
                    callBackToDelete: () {
                      final old = widget.action;
                      widget.action.actions!.remove(e);
                      widget.callBack(widget.action, old);
                    },
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
