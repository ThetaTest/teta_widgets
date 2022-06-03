// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

/// Generates the code for Padding widget
String cmsLoggedUserCodeTemplate(
  final BuildContext context,
  final NDynamic node,
  final List<CNode> children,
  final int? loop,
) {
  var child = 'const SizedBox()';
  if (children.isNotEmpty) {
    child = children.first.toCode(context);
  }
  var loader = 'const Center(child: CircularProgressIndicator(),)';
  if (children.length >= 2) {
    loader = children[1].toCode(context);
  }

  return '''
  FutureBuilder(
    future: TetaCMS.instance.auth.user.get,
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return $loader;
      }
      final user = snapshot.data as Map<String, dynamic>?;
      final data = <String, dynamic>{
        'isLogged': user?.keys.isNotEmpty,
        'uid': user?['uid'],
        'name': user?['name'],
        'email': user?['email'],
        'locale': user?['locale'],
        'provider': user?['provider'],
      };
      datasets['Teta Auth User'] = [
        if (data != null) data,
      ];
      const index = 0;
      return $child;
    }
  )
  ''';
}
