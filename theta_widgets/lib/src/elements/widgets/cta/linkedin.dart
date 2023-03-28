// Flutter imports:

// Package imports:
import 'package:font_awesome_flutter_named/font_awesome_flutter_named.dart';
import 'package:google_fonts/google_fonts.dart';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:theta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:theta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WLoginWithLinkedin extends StatelessWidget {
  /// Returns a Linkedin SignIn button
  const WLoginWithLinkedin(
    final Key? key, {
    required this.state,
    required this.width,
    required this.height,
    this.child,
    this.action,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final NodeGestureActions? action;
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
              nodeGestureActions: action,
              actionValue: null,
            ),
            onLongPress: () => GestureBuilder.get(
              context: context,
              state: state,
              gesture: ActionGesture.onLongPress,
              nodeGestureActions: action,
              actionValue: null,
            ),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xff0077b5)),
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
              overlayColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 10, 157, 236)),
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
                      faIconNameMapping['linkedin'],
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Sign in with LinkedIn',
                  style: GoogleFonts.getFont(
                    'Source Sans Pro',
                    color: Colors.white,
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
