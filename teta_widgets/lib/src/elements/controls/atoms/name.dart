// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/src/design_system/textfield/textfield.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:

class NameControl extends StatefulWidget {
  const NameControl({
    required this.title,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

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
    final nodeId = BlocProvider.of<FocusBloc>(context).state.first;
    final node = (context.read<PageCubit>().state as PageLoaded)
        .page
        .flatList
        .firstWhere((final element) => element.nid == nodeId);
    controller.text = widget.title == 'Description'
        ? node.description ?? ''
        : node.name ?? node.intrinsicState.displayName;

    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<FocusBloc, List<int>>(
      builder: (final context, final state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: TParagraph(
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
                final nodeId = BlocProvider.of<FocusBloc>(context).state.first;
                final node = (context.read<PageCubit>().state as PageLoaded)
                    .page
                    .flatList
                    .firstWhere((final element) => element.nid == nodeId);
                widget.title == 'Description'
                    ? node.description = text
                    : node.name = text;
                widget.callBack(
                  text,
                  widget.title == 'Description'
                      ? node.description ?? ''
                      : node.name ?? node.intrinsicState.displayName,
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
                    final nodeId =
                        BlocProvider.of<FocusBloc>(context).state.first;
                    final node = (context.read<PageCubit>().state as PageLoaded)
                        .page
                        .flatList
                        .firstWhere((final element) => element.nid == nodeId);
                    widget.title == 'Description'
                        ? node.description = controller.text
                        : node.name = controller.text;
                    widget.callBack(
                      controller.text,
                      widget.title == 'Description'
                          ? node.description ?? ''
                          : node.name ?? node.intrinsicState.displayName,
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
