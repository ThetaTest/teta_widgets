// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_core/teta_core.dart';
import 'package:theta_widgets/src/elements/controls/key_constants.dart';
import 'package:theta_widgets/src/elements/features/text_type_input.dart';
// Project imports:
import '../../../../../../../teta_open_classes/lib/src/nodes/dynamic.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import 'package:theta_widgets/src/elements/code/formatter_test.dart';
import 'package:theta_models/theta_models.dart';

/// Generates the code for Custom Http Request widget
class CustomHttpRequestCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NDynamic node,
    final List<CNode> children,
    final int? loop,
  ) async {
    final url =
        (node.body.attributes[DBKeys.customHttpRequestURL] as FTextTypeInput)
            .toCode(
              loop,
              resultType: ResultTypeEnum.string,
            )
            .replaceAll("'", '')
            .replaceAll(" ", '');
    final params =
        node.body.attributes[DBKeys.customHttpRequestList] as List<MapElement>;
    final mapParams = <String, dynamic>{};
    for (final e in params) {
      mapParams[e.key] = e.value
          .toCode(
            0,
            resultType: ResultTypeEnum.string,
          )
          .replaceAll("'", '')
          .replaceAll(" ", '');
    }
    final mapParamsString = StringBuffer()..write('{');
    for (final key in mapParams.keys) {
      mapParamsString.write("'$key': '${mapParams[key]}',");
    }
    mapParamsString.write('}');

    final headers = node.body.attributes[DBKeys.customHttpRequestHeader]
        as List<MapElement>;
    final mapHeaders = <String, dynamic>{};
    for (final e in headers) {
      var value = e.value
          .toCode(
            0,
            resultType: ResultTypeEnum.string,
          )
          .replaceAll("'", '');
      if (value.substring(value.length - 1) == ' ') {
        value = value.substring(0, value.length - 1);
      }
      mapHeaders[e.key] = value;
    }
    final mapHeadersString = StringBuffer()..write('{');
    for (final key in mapHeaders.keys) {
      mapHeadersString.write("'$key': '${mapHeaders[key]}',");
    }
    mapHeadersString.write('}');
    var child = 'const SizedBox()';
    if (children.isNotEmpty) {
      child = await children.first.toCode(context);
    }
    var loader = 'const Center(child: CircularProgressIndicator(),)';
    var error = '''
    const Text('Error')''';
    var emptyData = '''
    const Text('Empty data')''';
    var connectionState = '''
    Text('State: \${snapshot.connectionState}')''';
    if (children.length >= 2) {
      loader = await children[1].toCode(context);
    }
    final func = '''
    final list = snapshot.data as List<dynamic>?;
    datasets['${node.name ?? node.intrinsicState.displayName}'] = list ?? const <dynamic>[];
    ''';
    final code = '''
    TetaFutureBuilderHttp(
    url: "$url",
    params: $mapParamsString,
    headers: $mapHeadersString,
    builder: (context, snapshot) {
      
      if(snapshot.connectionState == ConnectionState.waiting){
         return $loader;
      }else if(snapshot.connectionState == ConnectionState.done){
        if(snapshot.hasError){
          return $error;
        }else if (snapshot.hasData){
          $func
          return  $child;
        }else{
          return $emptyData;
        }
      }else{
        return $connectionState;
      }
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

  static void testCode() {}
}
