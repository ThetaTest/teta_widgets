// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Checkbox widget
String checkBoxCodeTemplate(
  final int pageId,
  final BuildContext context,
  final NodeBody body,
  final CNode node,
  final CNode? child,
  final int loop,
) {
  final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
  if (abstract.type == FTextTypeEnum.state ||
      abstract.type == FTextTypeEnum.param) {
    final val = abstract.toCode(loop);
    final value = val
        .replaceAll("'", '')
        .replaceAll(r'$', '')
        .replaceAll('{', '')
        .replaceAll('}', '');
    return '''
   StatefulBuilder(
            builder: (final context, final localSetState) {
              return Checkbox(
                value: $value == 'true',
                onChanged: (final bool? b) {
                  localSetState(() {
                    if ($value == 'true') {
                      $value = 'false';
                    } else {
                      $value = 'true';
                    }
                  });
                },
              );
            },
          )
  ''';
  } else if (abstract.type == FTextTypeEnum.text) {
    final val = abstract.toCode(loop);
    final value = val == 'true';
    return '''
Builder(builder: (context) {
          var val = $value;
          return StatefulBuilder(
            builder: (final context, final localSetState) {
              return Checkbox(
                value: val,
                onChanged: (final bool? b) {
                  localSetState(() {
                    val = b!;
                  });
                },
              );
            },
          );
        })
''';
  } else {
    return '''
Checkbox(
      value: false,
      onChanged: (final bool? b) {
    },
)
''';
  }
}
