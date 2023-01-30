// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/cross_axis_alignment.dart';

class CrossAxisAlignmentControls extends StatefulWidget {
  const CrossAxisAlignmentControls({
    required this.crossAxisAlignment,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final FCrossAxisAlignment crossAxisAlignment;
  final Function(FCrossAxisAlignment, FCrossAxisAlignment) callBack;

  @override
  CrossAxisAlignmentControlsState createState() =>
      CrossAxisAlignmentControlsState();
}

class CrossAxisAlignmentControlsState
    extends State<CrossAxisAlignmentControls> {
  String? dropdown;

  @override
  void initState() {
    super.initState();
    dropdown = widget.crossAxisAlignment.getString(context);
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<FocusBloc, List<int>>(
      listener: (final context, final state) {
        if (state.isNotEmpty) {
          setState(() {
            dropdown = widget.crossAxisAlignment.getString(context);
          });
        }
      },
      child: BlocBuilder<FocusBloc, List<int>>(
        builder: (final context, final state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  bottom: 8,
                ),
                child: TParagraph(
                  'Cross Axis Alignment',
                ),
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
                onChange: (final newValue) {
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
