// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/dataset.dart';
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
String stripeProductsBuilderCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode? child,
) {
  final _scrollDirection =
      !(body.attributes[DBKeys.isVertical] as bool? ?? false)
          ? 'scrollDirection: Axis.horizontal,'
          : '';
  final shrinkWrap = body.attributes[DBKeys.flag] as bool? ?? false;
  // final dataset =
  //     (body.attributes[DBKeys.datasetInput] as FDataset).datasetName;

  final prj =
      (BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded).prj;
  var childCode = 'const SizedBox();';
  if (child != null) {
    childCode = child.toCode(context);
  }
  return '''
   FutureBuilder(
      future: http.get(
        Uri.parse('https://builder.teta.so:8402/product/${prj.id}/list'),
        headers: <String, String>{
          'stripe-api-key':
              '${prj.config!.stripePrivateKey}',
        },
      ),
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final jsonData = json.decode((snapshot.data as http.Response).body)
              as List<dynamic>;
          final map = jsonData
              .map((final dynamic e) => e as Map<String, dynamic>)
              .toList();
          this.datasets['products'] = map;
          return ListView.builder(
            $_scrollDirection
            shrinkWrap: $shrinkWrap,
            itemCount: map.length,
            itemBuilder: (context, index) {
              return $childCode;
            },
          );
        }
      }),
    )
    ''';
}
