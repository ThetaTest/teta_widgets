// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/src/design_system/hex_color.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/border.dart';
import 'package:teta_widgets/src/elements/features/border_radius.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/shadow.dart';

/// Class made to facilitate the creation of BoxDecoration for widgets
class TetaBoxDecoration {
  /// Get a [BoxDecoration]
  static BoxDecoration get({
    required final BuildContext context,
    required final FFill fill,
    final FBorderRadius? borderRadius,
    final FShadow? shadow,
    final FBorder? borders,
    final FFill? borderFill,
  }) {
    return fill.type == FFillType.none
        ? BoxDecoration(
            borderRadius: borderRadius?.get,
            boxShadow: const [
              //shadows.get(context),
            ],
            border: borders?.get(context, forPlay: true),
          )
        : fill.paletteStyle != null
            ? BoxDecoration(
                color: HexColor(fill.get(context).getHexColor(context)),
                borderRadius: borderRadius?.get,
                boxShadow: const [
                  //shadows.get(context),
                ],
                border: borders?.get(context, forPlay: true),
              )
            : fill.type == FFillType.solid
                ? BoxDecoration(
                    color: HexColor(fill.levels!.first.color),
                    borderRadius: borderRadius?.get,
                    boxShadow: const [
                      //shadows.get(context),
                    ],
                    border: borders?.get(context, forPlay: true),
                  )
                : fill.type == FFillType.linearGradient
                    ? BoxDecoration(
                        gradient: LinearGradient(
                          colors: fill.levels!
                              .map((final e) => HexColor(e.color))
                              .toList(),
                          begin: fill.begin!,
                          end: fill.end!,
                          stops: fill.levels!.map((final e) => e.stop).toList(),
                        ),
                        borderRadius: borderRadius?.get,
                        boxShadow: const [
                          //shadows.get(context),
                        ],
                        border: borders?.get(context, forPlay: true),
                      )
                    : fill.type == FFillType.radialGradient
                        ? BoxDecoration(
                            gradient: RadialGradient(
                              colors: fill.levels!
                                  .map((final e) => HexColor(e.color))
                                  .toList(),
                              center: fill.center!,
                              radius: fill.radius!,
                              stops: fill.levels!
                                  .map((final e) => e.stop)
                                  .toList(),
                            ),
                            borderRadius: borderRadius?.get,
                            boxShadow: const [
                              //shadows.get(context),
                            ],
                            border: borders?.get(context, forPlay: true),
                          )
                        : BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                fill.levels!.first.color,
                              ),
                              fit: fill.boxFit!.get,
                            ),
                            boxShadow: const [
                              //shadows.get(context),
                            ],
                            border: borders?.get(context, forPlay: true),
                          );
  }
}
