// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Align widget
String qrCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode? child,
  final int? loop,
) {
  final content =
      (body.attributes[DBKeys.value] as FTextTypeInput).toCode(loop);
  final withImage = body.attributes[DBKeys.flag] as bool;
  final image = (body.attributes[DBKeys.image] as FTextTypeInput).toCode(loop);
  final fill = body.attributes[DBKeys.fill] as FFill;
  final hex = fill.getHexColor(context);
  final size = (body.attributes[DBKeys.width] as FSize).toCode(
    context: context,
    isWidth: true,
  );
  return '''
    QrImage(
      data: $content,
      size: $size,
      foregroundColor: Color(0xff$hex).withOpacity(${fill.levels?.first.opacity ?? 1}),
      ${withImage ? 'embeddedImage: NetworkImage($image),' : ''}
      gapless: false,
    )
  ''';
}
