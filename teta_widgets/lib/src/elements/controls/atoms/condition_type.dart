// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/features/condition_type.dart';
// Project imports:

class ConditionTypeControl extends StatefulWidget {
  const ConditionTypeControl({
    required this.conditionType,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final FConditionType conditionType;
  final Function(FConditionType, FConditionType) callBack;

  @override
  ConditionTypeControlState createState() => ConditionTypeControlState();
}

class ConditionTypeControlState extends State<ConditionTypeControl> {
  String? dropdown;

  @override
  void initState() {
    super.initState();
    dropdown = widget.conditionType.getString(context);
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<FocusBloc, List<int>>(
      listener: (final context, final state) {
        if (state.isNotEmpty) {
          setState(() {
            dropdown = widget.conditionType.getString(context);
          });
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
                  children: const [
                    TParagraph(
                      'Condition type',
                    ),
                  ],
                ),
              ),
              CDropdownCustom<String>(
                value: dropdown,
                items: [
                  'Equal',
                  'Not equal',
                  'Is null',
                  'Not null',
                  'Greater than',
                  'Greater than or equal to',
                  'Less than',
                  'Less than or equal to',
                  'Contains',
                  'Starts with',
                  'Ends with',
                ]
                    .map(
                      (e) => DropdownCustomMenuItem<String>(
                        value: e,
                        child: TParagraph(e),
                      ),
                    )
                    .toList(),
                onChange: (final newValue) {
                  if (newValue != null) {
                    setState(() {
                      dropdown = newValue;
                    });
                    final old = FConditionType()
                        .fromJson(widget.conditionType.toJson());
                    final sz = widget.conditionType..set(newValue);
                    widget.callBack(sz, old);
                  }
                },
                expanded: true,
              ),
            ],
          );
        },
      ),
    );
  }
}
