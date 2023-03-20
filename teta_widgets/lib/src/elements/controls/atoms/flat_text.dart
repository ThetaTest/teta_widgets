// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_front_end/src/design_system/textfield/textfield.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_front_end/teta_front_end.dart';

class FlatTextControl extends StatefulWidget {
  const FlatTextControl({
    required this.value,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final String value;
  final Function(String, String) callBack;

  @override
  FlatTextControlState createState() => FlatTextControlState();
}

class FlatTextControlState extends State<FlatTextControl> {
  bool? isUpdated;
  TextEditingController? controller;

  @override
  void initState() {
    controller = TextEditingController();
    controller!.text = widget.value;
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<FocusBloc, List<int>>(
      listener: (final context, final state) {
        if (state.isNotEmpty) {
          controller!.text = widget.value;
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TParagraph(
            'Flat Text',
          ),
          CTextField(
            controller: controller!,
            placeholder: widget.value,
            hpadding: 4,
            callBack: (final text) {
              final old = widget.value;
              widget.callBack(text, old);
            },
          ),
        ],
      ),
    );
  }
}
