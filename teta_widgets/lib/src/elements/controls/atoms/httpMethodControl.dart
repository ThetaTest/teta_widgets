// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart ';

class HttpMethodControl extends StatefulWidget {
  const HttpMethodControl({
    required this.node,
    required this.httpMethod,
    required this.callBack,
    final Key? key,
    this.title,
  }) : super(key: key);

  final CNode node;
  final String? title;
  final String httpMethod;
  final Function(String, String) callBack;

  @override
  State<HttpMethodControl> createState() => _HttpMethodControlState();
}

class _HttpMethodControlState extends State<HttpMethodControl> {
  int? nodeId;
  bool? isUpdated;
  String? dropdown;

  @override
  void initState() {
    super.initState();
    nodeId = widget.node.nid;
    dropdown = widget.httpMethod;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FocusBloc, List<CNode>>(
      listener: (final context, final state) {
        if (state.isNotEmpty) {
          if (state.first.nid != nodeId) {
            setState(() {
              isUpdated = true;
              dropdown = widget.httpMethod;
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
                  children: [
                    THeadline3(
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
