// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/src/models/variable.dart';

// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/update.dart';

/// Change a state for an action
void changeState(VariableObject? state, BuildContext context, String value) {
  if (state != null) {
    state.value = value;
    update(context);
  }
}
