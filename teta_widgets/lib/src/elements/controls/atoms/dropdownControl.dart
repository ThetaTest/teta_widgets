// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class DropdownControl extends StatefulWidget {
  const DropdownControl({
    required this.node,
    required this.item,
    required this.list,
    required this.callBack,
    final Key? key,
    this.title,
  }) : super(key: key);

  final CNode node;
  final String? title;
  final String item;
  final List<String> list;
  final Function(String, String) callBack;

  @override
  State<DropdownControl> createState() => _DropdownControlState();
}

class _DropdownControlState extends State<DropdownControl> {
  int? nodeId;
  bool? isUpdated;
  String? dropdown;
  List<String>? dropdownList;
  @override
  void initState() {
    super.initState();
    nodeId = widget.node.nid;
    dropdown = widget.item;
    dropdownList = widget.list;
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<FocusBloc, List<CNode>>(
      listener: (final context, final state) {
        if (state.isNotEmpty) {
          if (state.first.nid != nodeId) {
            setState(() {
              isUpdated = true;
              dropdown = widget.item;
              dropdownList = widget.list;
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
                    TParagraph(
                      widget.title ?? 'Select from List',
                    ),
                  ],
                ),
              ),
              CDropdown(
                value: dropdown,
                items: dropdownList ?? ['EmptyList'],
                onChange: (final newValue) {
                  if (newValue != null) {
                    setState(() {
                      dropdown = newValue;
                    });
                    final old = widget.item;
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
