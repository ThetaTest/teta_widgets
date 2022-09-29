// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/features/google_maps_map_style.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/main_axis_alignment.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class GoogleMapsMapStyleControls extends StatefulWidget {
  const GoogleMapsMapStyleControls({
    required this.node,
    required this.mapStyle,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final CNode node;
  final FGoogleMapsMapStyle mapStyle;
  final Function(FGoogleMapsMapStyle, FGoogleMapsMapStyle) callBack;

  @override
  GoogleMapsMapStyleControlsState createState() =>
      GoogleMapsMapStyleControlsState();
}

class GoogleMapsMapStyleControlsState extends State<GoogleMapsMapStyleControls> {
  int? nodeId;
  bool? isUpdated;
  String? dropdown;

  @override
  void initState() {
    super.initState();
    nodeId = widget.node.nid;
    dropdown = widget.mapStyle.getString;
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<FocusBloc, List<CNode>>(
      listener: (final context, final state) {
        if (state.isNotEmpty) {
          if (state.first.nid != nodeId) {
            setState(() {
              isUpdated = true;
              dropdown = widget.mapStyle.getString;
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
                      'Map Style',
                    ),
                  ],
                ),
              ),
              CDropdown(
                value: dropdown,
                items: const [
                  'Standard',
                  'Silver',
                  'Retro',
                  'Dark',
                  'Night',
                  'Aubergine',
                ],
                onChange: (final newValue) {
                  if (newValue != null) {
                    setState(() {
                      dropdown = newValue;
                    });
                    final old = FGoogleMapsMapStyle()
                        .fromJson(widget.mapStyle.toJson());
                    final mAA = widget.mapStyle..set(newValue);
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
