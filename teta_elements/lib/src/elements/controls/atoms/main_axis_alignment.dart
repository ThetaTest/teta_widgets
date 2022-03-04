// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
// Project imports:
import 'package:teta_core/src/blocs/focus/bloc.dart';
import 'package:teta_core/src/design_system/dropdowns/dropdown.dart';
import 'package:teta_core/src/design_system/palette.dart';
import 'package:teta_core/src/design_system/text.dart';
import 'package:teta_elements/src/elements/features/main_axis_alignment.dart';
import 'package:teta_elements/src/elements/nodes/node.dart';

class MainAxisAlignmentControls extends StatefulWidget {
  const MainAxisAlignmentControls({
    Key? key,
    required this.node,
    required this.mainAxisAlignment,
    required this.callBack,
  }) : super(key: key);

  final CNode node;
  final FMainAxisAlignment mainAxisAlignment;
  final Function(FMainAxisAlignment, FMainAxisAlignment) callBack;

  @override
  MainAxisAlignmentControlsState createState() =>
      MainAxisAlignmentControlsState();
}

class MainAxisAlignmentControlsState extends State<MainAxisAlignmentControls> {
  int? nodeId;
  bool? isUpdated;
  String? dropdown;

  @override
  void initState() {
    super.initState();
    nodeId = widget.node.nid;
    dropdown = widget.mainAxisAlignment.getString;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FocusBloc, List<CNode>>(
      listener: (context, state) {
        if (state.isNotEmpty) {
          if (state.first.nid != nodeId) {
            setState(() {
              isUpdated = true;
              dropdown = widget.mainAxisAlignment.getString;
            });
            nodeId = state.first.nid;
          }
        }
      },
      child: BlocBuilder<FocusBloc, List<CNode>>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 8,
                ),
                child: Row(
                  children: const [
                    CText('Main Axis Alignment', color: Palette.white),
                  ],
                ),
              ),
              CDropdown(
                value: dropdown,
                items: const [
                  'Start',
                  'Center',
                  'End',
                  'Space Around',
                  'Space Between',
                  'Space Evenly',
                ],
                onChange: (newValue) {
                  if (newValue != null) {
                    setState(() {
                      dropdown = newValue;
                    });
                    final old = FMainAxisAlignment()
                        .fromJson(widget.mainAxisAlignment.toJson());
                    final mAA = widget.mainAxisAlignment..set(newValue);
                    widget.callBack(mAA, old);
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
