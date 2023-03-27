import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../actions/mixpanel/set_user_id/action.dart';
import '../../../../actions/mixpanel/set_user_id/params.dart';
import '../../../../features/text_type_input.dart';
import '../../../atoms/text.dart';

class MixpanelSetUserIdControl extends StatefulWidget {
  const MixpanelSetUserIdControl({
    required this.action,
    required this.onParamsChanged,
    final Key? key,
  }) : super(key: key);

  final TAMixpanelSetUserId action;
  final Function(TAMixpanelSetUserIdParams params) onParamsChanged;

  @override
  State<MixpanelSetUserIdControl> createState() =>
      _MixpanelSetUserIdControlState();
}

class _MixpanelSetUserIdControlState extends State<MixpanelSetUserIdControl> {
  FTextTypeInput? userId;

  void updateParams() {
    widget.onParamsChanged(TAMixpanelSetUserIdParams(userIdValue: userId));
  }

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextControl(
          valueType: VariableType.string,
          value: widget.action.params.userIdValue ?? FTextTypeInput(),
          title: 'User Id',
          callBack: (final value, final old) {
            userId = value;
            updateParams();
          },
        ),
      ],
    );
  }
}
