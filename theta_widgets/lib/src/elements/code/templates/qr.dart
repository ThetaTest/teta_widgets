// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Qr widget
class QrCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
    final int? loop,
  ) async {
    final content = (body.attributes[DBKeys.value] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );
    final withImage = body.attributes[DBKeys.flag] as bool;
    final image = (body.attributes[DBKeys.image] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );
    final fill = body.attributes[DBKeys.fill] as FFill;
    final hex = fill.getHexColor(context);
    final size = (body.attributes[DBKeys.width] as FSize).toCode(
      context: context,
      isWidth: true,
    );
    final tempOpacity = fill.levels?.first.opacity ?? 1;
    final opacity = tempOpacity >= 0 && tempOpacity <= 1 ? tempOpacity : 1.0;
    final code = '''
    QrImage(
      data: $content,
      size: $size,
      foregroundColor: Color(0xff$hex).withOpacity($opacity),
      ${withImage ? 'embeddedImage: NetworkImage($image),' : ''}
      gapless: false,
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
    group('QR toCode test', () {
      test(
        'QR: default',
        () {
          final body = NodeBody.get(NType.qrCode);
          final content =
              (body.attributes[DBKeys.value] as FTextTypeInput).toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
          final withImage = body.attributes[DBKeys.flag] as bool;
          final image =
              (body.attributes[DBKeys.image] as FTextTypeInput).toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
          final fill = FFill.toCodeTests(FFill().ready(FFillType.solid));

          expect(
            FormatterTest.format('''
              QrImage(
                data: $content,
                size: 24,
                ${fill!.replaceAll('color:', 'foregroundColor:')}
                ${withImage ? 'embeddedImage: NetworkImage($image),' : ''}
                gapless: false,
              )'''),
            true,
          );
        },
      );
    });
  }
}
