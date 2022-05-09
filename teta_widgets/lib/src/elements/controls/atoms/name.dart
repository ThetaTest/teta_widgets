// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/src/design_system/textfield/textfield.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/nodes/node.dart';

class NameControl extends StatefulWidget {
  const NameControl({
    required this.node,
    required this.title,
    required this.callBack,
    final Key? key,
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
  Widget build(final BuildContext context) {
    return BlocBuilder<FocusBloc, List<CNode>>(
      builder: (final context, final state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: THeadline3(
                widget.title ?? 'Name',
              ),
            ),
            CTextField(
              controller: controller,
              callBack: (final text) {
                setState(() {
                  isLoading = true;
                });
              },
              onSubmitted: (final text) {
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
