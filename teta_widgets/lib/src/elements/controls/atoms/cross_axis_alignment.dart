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
import 'package:teta_widgets/src/elements/features/cross_axis_alignment.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class CrossAxisAlignmentControls extends StatefulWidget {
  const CrossAxisAlignmentControls({
    Key? key,
    required this.node,
    required this.crossAxisAlignment,
    required this.callBack,
  }) : super(key: key);

  final CNode node;
  final FCrossAxisAlignment crossAxisAlignment;
  final Function(FCrossAxisAlignment, FCrossAxisAlignment) callBack;

  @override
  CrossAxisAlignmentControlsState createState() =>
      CrossAxisAlignmentControlsState();
}

class CrossAxisAlignmentControlsState
    extends State<CrossAxisAlignmentControls> {
  int? nodeId;
  bool? isUpdated;
  String? dropdown;

  @override
  void initState() {
    super.initState();
    nodeId = widget.node.nid;
    dropdown = widget.crossAxisAlignment.getString(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FocusBloc, List<CNode>>(
      listener: (context, state) {
        if (state.isNotEmpty) {
          if (state.first.nid != nodeId) {
            setState(() {
              isUpdated = true;
              dropdown = widget.crossAxisAlignment.getString(context);
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
              const Padding(
                padding: EdgeInsets.only(
                  bottom: 8,
                ),
                child: CText('Cross Axis Alignment', color: Palette.white),
              ),
              CDropdown(
                value: dropdown,
                items: const [
                  'Start',
                  'Center',
                  'End',
                  'Stretch',
                  'Baseline',
                ],
                onChange: (newValue) {
                  if (newValue != null) {
                    setState(() {
                      dropdown = newValue;
                    });
                    final old = FCrossAxisAlignment()
                        .fromJson(widget.crossAxisAlignment.toJson());
                    final cAA = widget.crossAxisAlignment..set(newValue);
                    widget.callBack(cAA, old);
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
