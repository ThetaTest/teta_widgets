// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

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
String firestoreFutureBuilderCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final List<CNode> children,
) {
  var child = 'const SizedBox()';
  if (children.isNotEmpty) {
    child = CS.child(context, children.first, comma: true).replaceAll(',', '');
  }
  var loader = 'const CircularProgressIndicator()';
  if (children.length >= 2) {
    loader = CS.child(context, children[1], comma: true).replaceAll(',', '');
  }
  const functionDoc = '''
  final doc = snapshot.data! as DocumentSnapshot;
  final map = DatasetObject(
      name: 'Query Firestore FB',
      map: [doc.data() as Map<String, dynamic>? ?? <String, dynamic>{}]);
  context.read<DatasetCubit>().add(map);
  ''';
  const functionColl = '''
  final coll = snapshot.data! as QuerySnapshot;
  final map = DatasetObject(
      name: 'Query Firestore FB',
      map: coll.docs
          .map((e) => doc.data() as Map<String, dynamic>? ?? <String, dynamic>{})
          .toList());
  BlocProvider.of<DatasetCubit>(context).add(map);
  ''';
  final func =
      CS.firestorePath(context, body, isStream: false).contains('.doc(')
          ? functionDoc
          : functionColl;

  return '''
    FutureBuilder(
      future: ${CS.firestorePath(context, body, isStream: false)},
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return $loader;
        }
        $func
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
