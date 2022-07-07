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
  TetaFutureBuilder(
    future: TetaCMS.instance.auth.user.get,
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return $loader;
      }
      final user = snapshot.data as TetaUser?;
      final data = <String, dynamic>{
        'isLogged': data?.isLogged,
        'uid': data?.uid,
        'name': data?.name,
        'email': data?.email,
        'provider': data?.provider,
        'created_at': data?.createdAt,
      };
      datasets['Teta Auth User'] = [
        if (data != null) data,
      ];
      var index = 0;
      return $child;
    }
  )
  ''';
}
