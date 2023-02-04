
import 'package:flutter/cupertino.dart';

import '../../../../teta_widgets.dart';
import '../../nodes/node_body.dart';
import '../formatter_test.dart';

class UserLoggedInCodeTemplate{

  static Future<String> toCode(
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final int loop,
  ) async {
        var loader = 'const CircularProgressIndicator()';

    const func = '''
  final userMap = snapshot.data as Map<String,dynamic>?;
  if (doc == null) return const SizedBox();
  
  final datasets = this.datasets;
  datasets['Supabase user is logged'] = doc.data as List<dynamic>? ?? <dynamic>[];
  ''';
  final code = '''
FutureBuilder<Map<String,dynamic>(
   future: Supabase.instance.client.auth.currentUser;
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return $loader;
      }
      $func
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
  }
  
