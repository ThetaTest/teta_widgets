// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hovering/hovering.dart';
// Project imports:
import 'package:teta_core/src/blocs/focus/index.dart';
import 'package:teta_core/src/design_system/palette.dart';
import 'package:teta_core/src/design_system/text.dart';
import 'package:teta_core/src/models/page.dart';
import 'package:teta_core/src/models/supabase_map_element.dart';
import 'package:teta_widgets/src/elements/controls/atoms/supabase_element.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class SupabaseMapControl extends StatefulWidget {
  const SupabaseMapControl({
    Key? key,
    required this.node,
    required this.list,
    required this.page,
    required this.callBack,
  }) : super(key: key);

  final CNode node;
  final List<SupabaseMapElement> list;
  final PageObject page;
  final Function(List<SupabaseMapElement>, List<SupabaseMapElement>) callBack;

  @override
  SupabaseMapControlState createState() => SupabaseMapControlState();
}

class SupabaseMapControlState extends State<SupabaseMapControl> {
  int? nodeId;
  bool? isUpdated;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    nodeId = widget.node.nid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FocusBloc, List<CNode>>(
      listener: (context, state) {
        if (state.isNotEmpty) {
          if (state.first.nid != nodeId) {
            setState(() {
              isUpdated = true;
            });
            nodeId = state.first.nid;
          }
        }
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
                  const CText(
                    'Map data',
                    color: Palette.white,
                    size: 16,
                    weight: FontWeight.bold,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          final old = widget.list;
                          widget.list.add(
                            SupabaseMapElement(
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
                          onHover: (e) {},
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
                      (e) => Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SupabaseMapElementControl(
                          node: widget.node,
                          value: e,
                          page: widget.page,
                          callBack: (value, old) {
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
