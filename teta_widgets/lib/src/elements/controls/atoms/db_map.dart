// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hovering/hovering.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/atoms/map_element.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

class DBMapControl extends StatefulWidget {
  const DBMapControl({
    required this.list,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final List<MapElement> list;
  final Function(List<MapElement>, List<MapElement>) callBack;

  @override
  DBMapControlState createState() => DBMapControlState();
}

class DBMapControlState extends State<DBMapControl> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<FocusBloc, List<int>>(
      listener: (final context, final state) {
        if (state.isNotEmpty) {}
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: widget.list.isEmpty ? 0 : 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TParagraph(
                    'Map data',
                  ),
                  Row(
                    children: [
                      BounceSmall(
                        onTap: () {
                          final old = widget.list;
                          widget.list.add(
                            MapElement(
                              key: '',
                              value: FTextTypeInput(),
                            ),
                          );
                          widget.callBack(widget.list, old);
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
                          onHover: (final e) {},
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
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: widget.list
                    .map(
                      (final e) => Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: MapElementControl(
                          value: e,
                          callBack: (final value, final old) {
                            final old = widget.list;
                            final index = widget.list.indexOf(e);
                            widget.list[index] = value;
                            widget.callBack(widget.list, old);
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
