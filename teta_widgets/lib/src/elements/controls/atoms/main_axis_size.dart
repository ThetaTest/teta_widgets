// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class MainAxisSizeControl extends StatefulWidget {
  const MainAxisSizeControl({
    required this.node,
    required this.size,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final CNode node;
  final FMainAxisSize size;
  final Function(FMainAxisSize, FMainAxisSize) callBack;

  @override
  MainAxisSizeControlState createState() => MainAxisSizeControlState();
}

class MainAxisSizeControlState extends State<MainAxisSizeControl> {
  int? nodeId;
  bool? isUpdated;
  String? dropdown;

  @override
  void initState() {
    super.initState();
    nodeId = widget.node.nid;
    dropdown = widget.size.getString;
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<FocusBloc, List<CNode>>(
      listener: (final context, final state) {
        if (state.isNotEmpty) {
          if (state.first.nid != nodeId) {
            setState(() {
              isUpdated = true;
              dropdown = widget.size.getString;
            });
            nodeId = state.first.nid;
          }
        }
      },
      child: BlocBuilder<FocusBloc, List<CNode>>(
        builder: (final context, final state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 8,
                ),
                child: Row(
                  children: const [
                    TParagraph(
                      'Main Axis Size',
                    ),
                  ],
                ),
              ),
              CDropdown(
                value: dropdown,
                items: const [
                  'Min',
                  'Max',
                ],
                onChange: (final newValue) {
                  if (newValue != null) {
                    setState(() {
                      dropdown = newValue;
                    });
                    final old = FMainAxisSize.fromJson(widget.size.toJson());
                    final sz = widget.size..set(newValue);
                    widget.callBack(sz, old);
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
