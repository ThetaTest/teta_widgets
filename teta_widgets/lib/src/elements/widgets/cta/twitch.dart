// Flutter imports:

// Package imports:
import 'package:font_awesome_flutter_named/font_awesome_flutter_named.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WLoginWithTwitch extends StatelessWidget {
  /// Returns a Twitch SignIn button
  const WLoginWithTwitch(
    final Key? key, {
    required this.state,
    required this.width,
    required this.height,
    this.child,
    this.action,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FAction? action;
  final FSize width;
  final FSize height;

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: state.node,
      forPlay: state.forPlay,
      child: SizedBox(
        width: width.get(context: context, isWidth: true),
        height: height.get(context: context, isWidth: false),
        child: SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: ElevatedButton(
            onPressed: () => GestureBuilder.get(
              context: context,
              state: state,
              gesture: ActionGesture.onTap,
              action: action,
              actionValue: null,
            ),
            onLongPress: () => GestureBuilder.get(
              context: context,
              state: state,
              gesture: ActionGesture.onLongPress,
              action: action,
              actionValue: null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(2.0),
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Icon(
                      faIconNameMapping['twitch'],
                      color: Color(0xff6441A4),
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Sign in with Twitch',
                  style: GoogleFonts.getFont(
                    'Source Sans Pro',
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.50,
                  ),
                ),
              ],
            ),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.all(10)),
              backgroundColor: MaterialStateProperty.all(Colors.white),
              elevation: MaterialStateProperty.all(2),
              side: MaterialStateProperty.all(
                BorderSide(
                  width: 2.0,
                  color: Colors.transparent,
                ),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              shadowColor: MaterialStateProperty.all(Colors.black),
              overlayColor: MaterialStateProperty.all(Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
