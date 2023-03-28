// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:theta_widgets/src/elements/code/snippets.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';

/// Generates the code for ListView.builder widget
///
/// Returns:
/// ```dart
/// Builder(
///   builder: (context) {
///     final children = <Widget>[]; // node's children
///     return ListView.builder(
///       scrollDirection: Axis.vertical,
///       itemCount: children.length,
///       itemBuilder: (context, index) {
///         return children[index];
///       },
///     );
///   },
/// );
/// ```
Future<String> firestoreFutureBuilderCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final List<CNode> children,
) async {
  var child = 'const SizedBox();';
  if (children.isNotEmpty) {
    child = await CS.child(context, children.first, comma: true)
      ..replaceAll(',', '');
  }
  var loader = 'const CircularProgressIndicator();';
  if (children.length >= 2) {
    loader = await CS.child(context, children[1], comma: true)
      ..replaceAll(',', '');
  }
  return '''
    StreamBuilder(
      stream: ${CS.firestorePath(context, body, isStream: true)},
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return $loader;
        }
        return $child;
      });
  ''';
}

// ignore: unused_element
Widget _example() {
  /*widget.path.values!.length.isEven
          ? FirebaseFirestore.instanceFor(
              app: Firebase.app(prj.prj.name),
            ).doc(finalPath != '' ? finalPath : ' ').get()
          : FirebaseFirestore.instanceFor(
              app: Firebase.app(prj.prj.name),
            ).collection(finalPath != '' ? finalPath : ' ').get(),*/
  return const SizedBox();
}
