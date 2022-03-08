// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Padding widget
String wrapperCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode? child,
) {
  return '''
    BlocBuilder<DeviceModeCubit, DeviceInfo>(
        builder: (context, state) {
          if (state.identifier.type == DeviceType.desktop) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                ${CS.child(context, child, comma: true)}
              ),
            );
          }
          if (state.identifier.type == DeviceType.tablet) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              ${CS.child(context, child, comma: true)}
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            ${CS.child(context, child, comma: true)}
          );
        },
      )
  ''';
}
