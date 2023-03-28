import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:teta_front_end/src/design_system/textfield/textfield.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

class MapElementControl extends StatefulWidget {
  const MapElementControl({
    required this.value,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final MapElement value;
  final Function(MapElement, MapElement) callBack;

  @override
  MapElementControlState createState() => MapElementControlState();
}

class MapElementControlState extends State<MapElementControl> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController()..text = widget.value.key;
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<FocusBloc, List<int>>(
      listener: (final context, final state) {
        if (state.isNotEmpty) {
          setState(() {
            controller.text = widget.value.key;
          });
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: TParagraph(
              'Column',
            ),
          ),
          CTextField(
            //text: text,
            controller: controller,
            callBack: (final value) {
              final old = widget.value;
              final newValue = widget.value.copyWith(key: value);
              widget.callBack(newValue, old);
            },
          ),
          const Gap(Grid.medium),
          TextControl(
            valueType: VariableType.dynamic,
            value: widget.value.value,
            title: 'Value',
            callBack: (final value, final old) {
              final newValue = widget.value.copyWith(value: value);
              widget.callBack(newValue, widget.value);
            },
          ),
        ],
      ),
    );
  }
}
