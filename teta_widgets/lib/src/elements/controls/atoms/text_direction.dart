// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class TextDirectionControl extends StatefulWidget {
  const TextDirectionControl({
    required this.node,
    required this.textDirection,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final CNode node;
  final FTextDirection textDirection;
  final Function(FTextDirection, FTextDirection) callBack;

  @override
  TextDirectionControlState createState() => TextDirectionControlState();
}

class TextDirectionControlState extends State<TextDirectionControl> {
  int? nodeId;
  bool? isUpdated;
  String? dropdown;

  @override
  void initState() {
    super.initState();
    nodeId = widget.node.nid;
    dropdown = widget.textDirection.getStringForDropDown;
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<FocusBloc, List<CNode>>(
      listener: (final context, final state) {
        if (state.isNotEmpty) {
          if (state.first.nid != nodeId) {
            setState(() {
              isUpdated = true;
              dropdown = widget.textDirection.getStringForDropDown;
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
                    THeadline3(
                      'Text Direction',
                    ),
                  ],
                ),
              ),
              CDropdown(
                value: dropdown,
                items: const [
                  'Left to Right',
                  'Right to Left',
                ],
                onChange: (final newValue) {
                  if (newValue != null) {
                    setState(() {
                      dropdown = newValue;
                    });
                    final old =
                        FTextDirection.fromJson(widget.textDirection.toJson());
                    final dir = widget.textDirection..set(newValue);
                    widget.callBack(dir, old);
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
