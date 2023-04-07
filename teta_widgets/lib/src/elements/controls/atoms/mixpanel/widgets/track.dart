import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../actions/mixpanel/track/action.dart';
import '../../../../actions/mixpanel/track/params.dart';
import '../../../../features/text_type_input.dart';
import '../../../atoms/text.dart';
import '../../../http_params.dart';

class MixpanelTrackControl extends StatefulWidget {
  const MixpanelTrackControl({
    required this.action,
    required this.onParamsChanged,
    final Key? key,
  }) : super(key: key);

  final TAMixpanelTrack action;
  final Function(TAMixpanelTrackParams params) onParamsChanged;

  @override
  State<MixpanelTrackControl> createState() => _MixpanelTrackControlState();
}

class _MixpanelTrackControlState extends State<MixpanelTrackControl> {
  FTextTypeInput? eventName;
  List<MapElement>? props;

  void updateParams() {
    setState(() {
      widget.onParamsChanged(
        TAMixpanelTrackParams(
          eventName: eventName,
          props: props,
        ),
      );
    });
  }

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextControl(
          valueType: VariableType.string,
          value: widget.action.params.eventName ?? FTextTypeInput(),
          title: 'Event name',
          callBack: (final value, final old) {
            eventName = value;
            updateParams();
          },
        ),
        const Gap(Grid.small),
        HttpParamsControl(
          title: 'Event Properties',
          list: widget.action.params.props ?? <MapElement>[],
          callBack: (final value, final old) {
            props = value;
            updateParams();
          },
        ),
        const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: TDetailLabel(
              r'Add Event Properties. Example : { "key" : "$value" , "key1" : "$value1"}',
            ),
          ),
        ),
      ],
    );
  }
}
