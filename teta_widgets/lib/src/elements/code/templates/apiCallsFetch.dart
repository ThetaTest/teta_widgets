// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
// Project imports:
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';

/// Generates the code for Api Calls Fetch widget
class ApiCallsFetchCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NDynamic node,
    final List<CNode> children,
    final int? loop,
  ) async {
    final apiCallsSelectedRequest = node.body
        .attributes[DBKeys.apiCallsSelectedRequest] as Map<String, dynamic>;
    //
    final apiCallsResponseNameNew =
        (node.body.attributes[DBKeys.apiCallsResponseName] as FTextTypeInput)
            .toCode(
              loop,
              resultType: ResultTypeEnum.string,
            )
            .replaceAll("'", '')
            .replaceAll(" ", '');
    final apiCallsDynamicValues = <String, dynamic>{};
    final apiCallsDynamicValue =
        node.body.attributes[DBKeys.apiCallsDynamicValue] as List<MapElement>;
    for (final e in apiCallsDynamicValue) {
      if (e.key.isEmpty) {
        break;
      }
      var value = e.value.toCode(
        0,
        resultType: ResultTypeEnum.string,
      );

      if (value.contains('this.datasets')) {
        value = '\${$value}';
      } else {
        value = value.replaceAll("'", '').replaceAll(' ', '');
      }
      if (value != null && value != '' && value != '0') {
        apiCallsDynamicValues[e.key] = value;
      }
    }
    //
    var mapParameters = <String, dynamic>{};
    var mapHeaders = <String, dynamic>{};
    var mapBody = <String, dynamic>{};

    var url = '';
    apiCallsSelectedRequest.forEach((final key, final dynamic value) {
      if (key == 'requestURL') {
        url = value as String;
        var changeValue = url;
        apiCallsDynamicValues.forEach(
          (final keyDynamic, final dynamic valueDynamic) => {
            if (changeValue.contains(keyDynamic))
              {
                changeValue =
                    changeValue.replaceAll(keyDynamic, '$valueDynamic'),
              },
            url = changeValue
          },
        );
      }
      if (key == 'headers') {
        mapHeaders = value as Map<String, dynamic>;
        var mapHeaders2 = <String, dynamic>{};
        mapHeaders.forEach(
          (final key, final dynamic value) {
            var changeKey = key;
            var changeValue = value.toString();
            apiCallsDynamicValues.forEach(
              (final keyDynamic, final dynamic valueDynamic) {
                // check if dynamicValue  both key and value
                if (changeKey.contains(keyDynamic) &&
                    changeValue.contains(keyDynamic)) {
                  changeKey = changeKey.replaceAll(keyDynamic, '$valueDynamic');
                  changeValue =
                      value.toString().replaceAll(keyDynamic, '$valueDynamic');
                }
                //check if dynamicValue in key
                else if (changeKey.contains(keyDynamic)) {
                  changeKey = changeKey.replaceAll(keyDynamic, '$valueDynamic');
                }
                //check if dynamicValue in value
                else if (changeValue.contains(keyDynamic)) {
                  changeValue =
                      changeValue.replaceAll(keyDynamic, '$valueDynamic');
                }
              },
            );
            //Update new map
            mapHeaders2[changeKey] = changeValue;
          },
        );
        mapHeaders = mapHeaders2;
      }
      if (key == 'body') {
        mapBody = value as Map<String, dynamic>;
        var mapBody2 = <String, dynamic>{};
        mapBody.forEach(
          (final key, final dynamic value) {
            var changeKey = key;
            var changeValue = value.toString();
            apiCallsDynamicValues.forEach(
              (final keyDynamic, final dynamic valueDynamic) {
                // check if dynamicValue  both key and value
                if (changeKey.contains(keyDynamic) &&
                    changeValue.contains(keyDynamic)) {
                  changeKey = changeKey.replaceAll(keyDynamic, '$valueDynamic');
                  changeValue =
                      value.toString().replaceAll(keyDynamic, '$valueDynamic');
                }
                //check if dynamicValue in key
                else if (changeKey.contains(keyDynamic)) {
                  changeKey = changeKey.replaceAll(keyDynamic, '$valueDynamic');
                }
                //check if dynamicValue in value
                else if (changeValue.contains(keyDynamic)) {
                  changeValue =
                      changeValue.replaceAll(keyDynamic, '$valueDynamic');
                }
              },
            );
            //Update new map
            mapBody2[changeKey] = changeValue;
          },
        );
        mapBody = mapBody2;
      }
      if (key == 'params') {
        mapParameters = value as Map<String, dynamic>;
        var mapParameters2 = <String, dynamic>{};

        mapParameters.forEach(
          (final key, final dynamic value) {
            var changeKey = key;
            var changeValue = value.toString();
            apiCallsDynamicValues.forEach(
              (final keyDynamic, final dynamic valueDynamic) {
                // check if dynamicValue  both key and value
                if (changeKey.contains(keyDynamic) &&
                    changeValue.contains(keyDynamic)) {
                  changeKey = changeKey.replaceAll(keyDynamic, '$valueDynamic');
                  changeValue =
                      value.toString().replaceAll(keyDynamic, '$valueDynamic');
                }
                //check if dynamicValue in key
                else if (changeKey.contains(keyDynamic)) {
                  changeKey = changeKey.replaceAll(keyDynamic, '$valueDynamic');
                }
                //check if dynamicValue in value
                else if (changeValue.contains(keyDynamic)) {
                  changeValue =
                      changeValue.replaceAll(keyDynamic, '$valueDynamic');
                }
              },
            );
            //Update new map
            mapParameters2[changeKey] = changeValue;
          },
        );
        mapParameters = mapParameters2;
      }
    });
    final mapParametersString = StringBuffer()..write('{');
    for (final key in mapParameters.keys) {
      mapParametersString.write("'$key': '${mapParameters[key]}',");
    }
    mapParametersString.write('}');

    final mapHeadersString = StringBuffer()..write('{');
    for (final key in mapHeaders.keys) {
      mapHeadersString.write("'$key': '${mapHeaders[key]}',");
    }
    mapHeadersString.write('}');

    final mapBodyString = StringBuffer()..write('{');
    for (final key in mapBody.keys) {
      mapBodyString.write("'$key': '${mapBody[key]}',");
    }
    mapBodyString.write('}');
    var child = 'const SizedBox()';
    if (children.isNotEmpty) {
      child = await children.first.toCode(context);
    }
    var loader = 'const Center(child: CircularProgressIndicator(),)';
    const error = '''
    const Text('Error')''';
    const emptyData = '''
    const Text('Empty data')''';
    var connectionState = '''
    Text('State: \${snapshot.connectionState}')''';
    if (children.length >= 2) {
      loader = await children[1].toCode(context);
    }
    final func = '''
    final list = snapshot.data as List<dynamic>?;
    datasets['$apiCallsResponseNameNew'] = list ?? const <dynamic>[];
    ''';
    final code = '''
   TetaFutureBuilderHttp(
    url: "$url",
    params: $mapParametersString,
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
