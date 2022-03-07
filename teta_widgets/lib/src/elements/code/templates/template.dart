// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

/// Template Abstract Class
class Template {
  const Template({required this.name, required this.attributes});

  final String name;
  final Map<String, dynamic> attributes;

  String get(BuildContext context, CNode node) {
    return '''
      $name(

      )
    ''';
  }
}

const containerTemplate = Template(
  name: 'Container',
  attributes: <String, String>{
    'width': DBKeys.width,
    'height': DBKeys.height,
  },
);
