// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/src/design_system/textfield/textfield.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class MapElementControl extends StatefulWidget {
  const MapElementControl({
    required this.node,
    required this.value,
    required this.page,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final CNode node;
  final MapElement value;
  final PageObject page;
  final Function(MapElement, MapElement) callBack;

  @override
  MapElementControlState createState() => MapElementControlState();
}

class MapElementControlState extends State<MapElementControl> {
  int? nodeId;
  bool? isUpdated;
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    nodeId = widget.node.nid;
    controller.text = widget.value.key;
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
              controller.text = widget.value.key;
            });
            nodeId = state.first.nid;
          }
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: TParagraph(
              'Column',
            ),
          ),
          CTextField(
            //text: text,
            controller: controller,
            callBack: (final value) {
              final old = widget.value;
              final newValue = widget.value.copyWith(key: value);
              widget.callBack(newValue, old);
            },
          ),
          TextControl(
            valueType: VariableType.dynamic,
            node: widget.node,
            value: widget.value.value,
            page: widget.page,
            title: 'Value',
            callBack: (final value, final old) {
              final newValue = widget.value.copyWith(value: value);
              widget.callBack(newValue, widget.value);
            },
          ),
        ],
      ),
    );
  }
}
