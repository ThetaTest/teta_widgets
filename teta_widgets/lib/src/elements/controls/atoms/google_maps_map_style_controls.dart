// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/features/google_maps_map_style.dart';
// Project imports:
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_front_end/teta_front_end.dart';

class GoogleMapsMapStyleControls extends StatefulWidget {
  const GoogleMapsMapStyleControls({
    required this.mapStyle,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final FGoogleMapsMapStyle mapStyle;
  final Function(FGoogleMapsMapStyle, FGoogleMapsMapStyle) callBack;

  @override
  GoogleMapsMapStyleControlsState createState() =>
      GoogleMapsMapStyleControlsState();
}

class GoogleMapsMapStyleControlsState
    extends State<GoogleMapsMapStyleControls> {
  String? dropdown;

  @override
  void initState() {
    super.initState();
    dropdown = widget.mapStyle.getString;
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<FocusBloc, List<int>>(
      listener: (final context, final state) {
        if (state.isNotEmpty) {
          dropdown = widget.mapStyle.getString;
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
                      'Map Style',
                    ),
                  ],
                ),
              ),
              CDropdownCustom<String>(
                value: dropdown,
                items: [
                  buildMapStyleMenuItem(
                    'Standard',
                    'assets/images/standard.png',
                  ),
                  buildMapStyleMenuItem('Silver', 'assets/images/silver.png'),
                  buildMapStyleMenuItem('Retro', 'assets/images/retro.png'),
                  buildMapStyleMenuItem('Dark', 'assets/images/dark.png'),
                  buildMapStyleMenuItem('Night', 'assets/images/night.png'),
                  buildMapStyleMenuItem(
                    'Aubergine',
                    'assets/images/aubergine.png',
                  ),
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

  DropdownCustomMenuItem<String> buildMapStyleMenuItem(
    final String value,
    final String asset,
  ) =>
      DropdownCustomMenuItem<String>(
        value: value,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BR(4),
              child: Image.asset(
                asset,
                package: 'teta_widgets',
                fit: BoxFit.cover,
                height: 40,
                width: 40,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            TParagraph(value),
            const Spacer(),
          ],
        ),
      );
}
