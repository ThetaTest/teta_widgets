/*import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:mobile_editor/src/blocs/data/index.dart';
import 'package:mobile_editor/src/design_system/palette.dart';
import 'package:mobile_editor/src/design_system/text.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/models/data.dart';

class DataAttrControl extends StatefulWidget {
  final CNode node;
  final Function(String, String) callBack;
  DataAttrControl({Key? key, required this.node, required this.callBack})
      : super(key: key);

  @override
  _DataAttrControlState createState() => _DataAttrControlState();
}

class _DataAttrControlState extends State<DataAttrControl> {
  String? dropdown;

  @override
  void initState() {
    super.initState();
    dropdown = widget.node.dataModelAttr;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, List<DataModel>>(
      builder: (context, state) {
        DataModel data = state
            .firstWhere((element) => element.name == widget.node.dataModel);
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
              CText(
                'Choose your dataset',
                size: 11,
                color: Palette.white,
              ),
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),

                // dropdown below..
                child: DropdownButton<String>(
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    underline: const SizedBox(),
                    onChanged: (String newValue) {
                      setState(() {
                        state.firstWhere(
                            (element) => element.name == widget.node.dataModel);
                        dropdown = newValue;
                        widget.callBack(dropdown, widget.node.dataModelAttr);
                      });
                    },
                    isDense: true,
                    isExpanded: true,
                    items: data.jsonMap
                        .where((element) => element.value != '')
                        .where((element) => element.loop == 0)
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
}*/
