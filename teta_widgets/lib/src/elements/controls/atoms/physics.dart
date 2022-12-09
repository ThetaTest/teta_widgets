// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/physic.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class PhysicsControl extends StatefulWidget {
  const PhysicsControl({
    required this.node,
    required this.physic,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final CNode node;
  final FPhysic physic;
  final Function(FPhysic, FPhysic) callBack;

  @override
  PhysicsControlState createState() => PhysicsControlState();
}

class PhysicsControlState extends State<PhysicsControl> {
  String? dropdown;

  @override
  void initState() {
    super.initState();
    dropdown = 'AlwaysScrollableScrollPhysics';
  }

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: TParagraph(
            'Physics',
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CDropdown(
                value: widget.physic.getStringForDropDown(context),
                items: FPhysic.physicsList,
                onChange: (final newValue) {
                  if (newValue != null) {
                    setState(() {
                      dropdown = newValue;
                    });
                    final old = FPhysic.fromJson(widget.physic.toJson());
                    final phy = widget.physic.copyWith(
                      physic: FPhysic.convertDropDownToValue(newValue),
                    );
                    widget.callBack(phy, old);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
