// Dart imports:
// ignore_for_file: public_member_api_docs

import 'dart:convert';
import 'dart:math';

// Package imports:
import 'package:crypto/crypto.dart';
// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/src/cubits/zoomable/cubit.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_elements/src/elements/nodes/node.dart';
//import 'package:sign_in_with_apple/sign_in_with_apple.dart';

String generateNonce([int length = 32]) {
  const charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(length, (_) => charset[random.nextInt(charset.length)])
      .join();
}

/// Returns the sha256 hash of [input] in hex notation.
String sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

class FAFirebaseLoginApple {
  Future makeAction(
    BuildContext context,
    String value,
    CNode scaffold,
    CNode node,
    String? nameOfPage,
    Map<String, dynamic>? paramsToSend,
    List<VariableObject> params,
    List<VariableObject> states,
    List<DatasetObject> dataset,
    int? loop,
  ) async {
    final index =
        states.indexWhere((element) => element.name.toLowerCase() == 'status');
    try {
      if (double.tryParse(
            states[index].value as String? ?? states[index].defaultValue!,
          ) !=
          null) {
        states[index].value = 'Loading';
      }
      BlocProvider.of<ZoomableCubit>(context).changeZoomableFlag(value: false);
      BlocProvider.of<ZoomableCubit>(context).changeZoomableFlag(value: true);
    } catch (e) {
      if (kDebugMode) {
        // ignore: avoid_print
        print(e);
      }
    }
    //UserCredential? user;
    try {
      if (kIsWeb) {
        /*final provider = OAuthProvider('apple.com');
        user = await FirebaseAuth.instanceFor(
          app: Firebase.app(prj.prj.name),
        ).signInWithPopup(provider);*/
      } else {
        /*final appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          nonce: nonce,
        );
        final oauthCredential = OAuthProvider('apple.com').credential(
          idToken: appleCredential.identityToken,
          rawNonce: rawNonce,
        );
        user = await FirebaseAuth.instanceFor(
          app: Firebase.app(prj.prj.name),
        ).signInWithCredential(oauthCredential);*/
      }
    } catch (e) {
      if (kDebugMode) {
        // ignore: avoid_print
        print(e);
      }
    }
    /*if (user != null) {
      states[index].value = 'Success';
      // ignore: use_build_context_synchronously
      BlocProvider.of<ZoomableCubit>(context).changeZoomableFlag(false);
      // ignore: use_build_context_synchronously
      BlocProvider.of<ZoomableCubit>(context).changeZoomableFlag(true);
      // ignore: use_build_context_synchronously
      /*FActionNavigationOpenPage().makeAction(node, context, nameOfPage,
          paramsToSend, params, states, dataset, loop);*/
    } else {
      try {
        final index = states
            .indexWhere((element) => element.name.toLowerCase() == 'status');
        if (double.tryParse(states[index].value as String? ??
                states[index].defaultValue!) !=
            null) {
          states[index].value = 'Failed';
        }
        // ignore: use_build_context_synchronously
        BlocProvider.of<ZoomableCubit>(context).changeZoomableFlag(false);
        // ignore: use_build_context_synchronously
        BlocProvider.of<ZoomableCubit>(context).changeZoomableFlag(true);
      } catch (e) {
        if (kDebugMode) {
          // ignore: avoid_print
          print(e);
        }
      }
    }*/
  }

  String toCode(
    BuildContext context,
    String value,
    CNode scaffold,
    CNode node,
    String? nameOfPage,
    Map<String, dynamic>? paramsToSend,
    int? loop,
  ) {
    return '''
      final states = BlocProvider.of<StatesCubit>(context).state;
      if (states != null) {
        final VariableObject? email = states!.firstWhere((element) => element.name!.toLowerCase() == "email");
        final VariableObject? password = states!.firstWhere((element) => element.name!.toLowerCase() == "password");
        if (email != null && password != null) {
          try {
            final index = states.indexWhere(
                (element) => element.name!.toLowerCase() == "status");
            if (double.tryParse(
                    states[index].value ?? states[index].defaultValue) !=
                null) {
              states[index].value = "Loading";
              BlocProvider.of<StatesCubit>(context).update(states[index]);
            }
          } catch (e) {
            print(e);
          }
          ShopifyAuth auth = ShopifyAuth.instance;
          final ShopifyUser? user = await auth.signInWithEmailAndPassword(
              email: email.value ?? email.defaultValue,
              password: password.value ?? password.defaultValue);
          if (user != null) {
            try {
              final index = states.indexWhere(
                  (element) => element.name!.toLowerCase() == "status");
              if (double.tryParse(
                      states[index].value ?? states[index].defaultValue) !=
                  null) {
                states[index].value = "Success";
                BlocProvider.of<StatesCubit>(context).update(states[index]);
              }
            } catch (e) {
              print(e);
            }
            FActionNavigationOpenPage().makeAction(context, nameOfPage,
                paramsToSend, params, states, dataset, loop);
          } else {
            try {
              final index = states.indexWhere(
                  (element) => element.name!.toLowerCase() == "status");
              if (double.tryParse(
                      states[index].value ?? states[index].defaultValue) !=
                  null) {
                states[index].value = "Failed";
                BlocProvider.of<StatesCubit>(context).update(states[index]);
              }
            } catch (e) {
              print(e);
            }
          }
        }
      }
    ''';
  }
}
