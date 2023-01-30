// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/main_axis_alignment.dart';

class MainAxisAlignmentControls extends StatefulWidget {
  const MainAxisAlignmentControls({
    required this.mainAxisAlignment,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final FMainAxisAlignment mainAxisAlignment;
  final Function(FMainAxisAlignment, FMainAxisAlignment) callBack;

  @override
  MainAxisAlignmentControlsState createState() =>
      MainAxisAlignmentControlsState();
}

class MainAxisAlignmentControlsState extends State<MainAxisAlignmentControls> {
  String? dropdown;

  @override
  void initState() {
    super.initState();
    dropdown = widget.mainAxisAlignment.getString;
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<FocusBloc, List<int>>(
      listener: (final context, final state) {
        if (state.isNotEmpty) {
          setState(() {
            dropdown = widget.mainAxisAlignment.getString;
          });
        }
      },
      child: BlocBuilder<FocusBloc, List<int>>(
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
                      'Main Axis Alignment',
                    ),
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
                onChange: (final newValue) {
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
