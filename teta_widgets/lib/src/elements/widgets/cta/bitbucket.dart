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

class WLoginWithBitBucket extends StatelessWidget {
  /// Returns a BitBucket SignIn button
  const WLoginWithBitBucket(
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
      state: state,
      child: SizedBox(
        width: width.get(
          context: context,
          isWidth: true,
          forPlay: state.forPlay,
        ),
        height: height.get(
          context: context,
          isWidth: false,
          forPlay: state.forPlay,
        ),
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
            style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
              backgroundColor: MaterialStateProperty.all(Colors.white),
              elevation: MaterialStateProperty.all(2),
              side: MaterialStateProperty.all(
                const BorderSide(
                  width: 2,
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
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(2),
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Icon(
                      faIconNameMapping['bitbucket'],
                      color: const Color(0xff2684FF),
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  'Sign in with BitBucket',
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
          ),
        ),
      ),
    );
  }
}
