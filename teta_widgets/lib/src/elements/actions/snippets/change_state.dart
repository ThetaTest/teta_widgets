import 'package:flutter/material.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_elements/src/elements/actions/snippets/update.dart';

/// Change a state for an action
void changeState(VariableObject? state, BuildContext context, String value) {
  if (state != null) {
    state.value = value;
    update(context);
  }
}
