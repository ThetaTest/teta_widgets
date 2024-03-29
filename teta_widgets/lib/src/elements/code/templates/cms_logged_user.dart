// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_models/teta_models.dart';

/// Generates the code for CMS Logged User widget
class CmsLoggedUserCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NDynamic node,
    final List<CNode> children,
    final int? loop,
  ) async {
    var child = 'const SizedBox()';
    if (children.isNotEmpty) {
      child = await children.first.toCode(context);
    }
    var loader = 'const Center(child: CircularProgressIndicator(),)';
    if (children.length >= 2) {
      loader = await children[1].toCode(context);
    }

    final revenueCatFlag =
        (BlocProvider.of<ConfigCubit>(context).state as ConfigStateLoaded)
            .config
            .revenuecat is RevenueCatConfigModelInitialized;
    final code = '''
  TetaFutureBuilder<TetaUser>(
    future: Future.sync(() async {
      final user = await TetaCMS.instance.auth.user.get;
      ${revenueCatFlag ? r"""
if (UniversalPlatform.isIOS || UniversalPlatform.isAndroid || UniversalPlatform.isMacOS) {
  await Purchases.logIn('${user.uid}');
}
""" : ''}
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
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      return 'const SizedBox()';
    }
  }

  static void testCode() {
    group('CmsLoggedUser toCode test', () {
      test(
        'CmsLoggedUser: default code',
        () {
          const child = 'const SizedBox()';
          const loader = 'const Center(child: CircularProgressIndicator(),)';
          //this is for test purpose only
          const revenueCatFlag = true == true;
          expect(
            FormatterTest.format('''
TetaFutureBuilder<TetaUser>(
    future: Future.sync(() async {
      final user = await TetaCMS.I.auth.user.get;
      ${revenueCatFlag ? r"""
if (UniversalPlatform.isIOS || UniversalPlatform.isAndroid || UniversalPlatform.isMacOS) {
  await Purchases.logIn('${user.uid}');
}
""" : ''}
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
          '''),
            true,
          );
        },
      );
    });
  }
}
