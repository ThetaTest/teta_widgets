/*import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_editor/src/blocs/data/index.dart';
import 'package:mobile_editor/src/design_system/palette.dart';
import 'package:mobile_editor/src/design_system/text.dart';
import 'package:mobile_editor/src/elements/features/text_type_input.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/models/data.dart';
import 'package:nil/nil.dart';

class DataControl extends StatefulWidget {
  final CNode node;
  final Function(FTextTypeInput, FTextTypeInput) callBack;
  DataControl({
    Key? key,
    required this.node,
    required this.callBack,
  }) : super(key: key);

  @override
  _DataControlState createState() => _DataControlState();
}

class _DataControlState extends State<DataControl> {
  String? dropdown;

  @override
  void initState() {
    super.initState();
    dropdown = widget.node.dataModel;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, List<DataModel>>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CText(
                'Choose your dataset',
                size: 11,
                color: Palette.white,
              ),
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                // dropdown below..
                child: DropdownButton<String>(
                    value: widget.node.value?.datasetName ?? null,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    underline: const SizedBox(),
                    onChanged: (String? newValue) {
                      final old = widget.node.value!;
                      widget.node.value!.datasetName = newValue;
                      widget.callBack(widget.node.value!, old);
                    },
                    isDense: true,
                    isExpanded: true,
                    items: state
                        .map((e) => '${e.name}')
                        .toList()
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: CText(value, size: 16),
                      );
                    }).toList()),
              ),
            ],
          ),
        );
      },
    );
  }
}
*/
