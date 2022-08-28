// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
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

  final revenueCatFlag =
      (BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded)
              .prj
              .config
              ?.isRevenueCatEnabled ??
          false;
  return '''
  TetaFutureBuilder(
    future: Future<TetaUser>.value(() {
      final user = await TetaCMS.instance.auth.user.get;
      ${revenueCatFlag ? 'await Purchases.logIn(user.uid!);' : ''}
      return user;
    }),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return $loader;
      }
      final user = snapshot.data as TetaUser?;
      final data = <String, dynamic>{
        'isLogged': user?.isLogged,
        'uid': user?.uid,
        'name': user?.name,
        'email': user?.email,
        'provider': user?.provider,
        'created_at': user?.createdAt,
      };
      datasets['Teta Auth User'] = [
        if (data != null) data,
      ];
      return $child;
    }
  )
  ''';
}
