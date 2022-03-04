// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
// Project imports:
import 'package:teta_core/src/blocs/focus/bloc.dart';
import 'package:teta_core/src/design_system/buttons/button.dart';
import 'package:teta_core/src/design_system/palette.dart';
import 'package:teta_core/src/design_system/text.dart';
import 'package:teta_core/src/design_system/textfield/textfield.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class NameControl extends StatefulWidget {
  const NameControl({
    Key? key,
    required this.node,
    required this.title,
    required this.callBack,
  }) : super(key: key);

  final CNode node;
  final String? title;
  final Function(String, String) callBack;

  @override
  NameState createState() => NameState();
}

class NameState extends State<NameControl> {
  bool isLoading = false;
  bool isIgnoring = false;
  FocusNode focusNode = FocusNode();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.title == 'Description'
        ? widget.node.description ?? ''
        : widget.node.name ?? widget.node.intrinsicState.displayName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FocusBloc, List<CNode>>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: CText(
                widget.title ?? 'Name',
                color: Palette.white,
              ),
            ),
            CTextField(
              controller: controller,
              hpadding: 0,
              callBack: (text) {
                setState(() {
                  isLoading = true;
                });
              },
              onSubmitted: (text) {
                widget.title == 'Description'
                    ? widget.node.description = text
                    : widget.node.name = text;
                widget.callBack(
                  text,
                  widget.title == 'Description'
                      ? widget.node.description ?? ''
                      : widget.node.name ??
                          widget.node.intrinsicState.displayName,
                );
                setState(() {
                  isLoading = false;
                });
              },
            ),
            if (isLoading)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: CButton(
                  label: 'Submit',
                  callback: () {
                    widget.title == 'Description'
                        ? widget.node.description = controller.text
                        : widget.node.name = controller.text;
                    widget.callBack(
                      controller.text,
                      widget.title == 'Description'
                          ? widget.node.description ?? ''
                          : widget.node.name ??
                              widget.node.intrinsicState.displayName,
                    );

                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
