// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';

// Project imports:
import 'package:teta_widgets/src/elements/nodes/node.dart';

/// Generates the code for Padding widget
String stripeProductsListTemplate(
  final BuildContext context,
  final CNode node,
  final CNode? child,
  final List<CNode>? children,
  final int pageId,
  final int? loop,
) {
  final prj =
      (BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded).prj;
  var child = 'const SizedBox()';
  if (children!.isNotEmpty) {
    child = children.first.toCode(context);
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
          this.stripeProductsList = map;
          return $child
        }
      }),
    )
  ''';
}
