// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class HttpMethodControl extends StatefulWidget {
  const HttpMethodControl({
    required this.httpMethod,
    required this.callBack,
    final Key? key,
    this.title,
  }) : super(key: key);

  final String? title;
  final String httpMethod;
  final Function(String, String) callBack;

  @override
  State<HttpMethodControl> createState() => _HttpMethodControlState();
}

class _HttpMethodControlState extends State<HttpMethodControl> {
  String? dropdown;

  @override
  void initState() {
    super.initState();
    dropdown = widget.httpMethod;
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<FocusBloc, List<int>>(
      listener: (final context, final state) {
        if (state.isNotEmpty) {
          dropdown = widget.httpMethod;
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
                  children: [
                    TParagraph(
                      widget.title ?? 'Http Methods',
                    ),
                  ],
                ),
              ),
              CDropdown(
                value: dropdown,
                items: const ['Get', 'Post', 'Delete'],
                onChange: (final newValue) {
                  if (newValue != null) {
                    setState(() {
                      dropdown = newValue;
                    });
                    final old = widget.httpMethod;
                    final value = newValue;
                    widget.callBack(value, old);
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
