// Flutter imports:
// Package imports:
// ignore_for_file: lines_longer_than_80_chars

/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_editor/src/blocs/focus_page/index.dart';
// Project imports:
import 'package:mobile_editor/src/blocs/focus_project/index.dart';
import 'package:mobile_editor/src/cubits/zoomable/cubit.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';

class FAFirebaseLoginEmailPassword {
  void makeAction(
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
    try {
      final page = BlocProvider.of<FocusPageBloc>(context).state;
      VariableObject? email;
      try {
        email = page.states
            .firstWhere((element) => element.name.toLowerCase() == 'email');
      } catch (_) {}
      VariableObject? password;
      try {
        page.states
            .firstWhere((element) => element.name.toLowerCase() == 'password');
      } catch (_) {}
      final index = states
          .indexWhere((element) => element.name.toLowerCase() == 'status');
      if (email != null && password != null) {
        try {
          if (double.tryParse(states[index].value as String? ??
                  states[index].defaultValue!) !=
              null) {
            states[index].value = 'Loading';
          }
          BlocProvider.of<ZoomableCubit>(context).changeZoomableFlag(false);
          BlocProvider.of<ZoomableCubit>(context).changeZoomableFlag(true);
        } catch (e) {
          print(e);
        }
        UserCredential? user;
        try {
          final prj =
              BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded;
          user = await FirebaseAuth.instanceFor(
            app: Firebase.app(prj.prj.name),
          ).signInWithEmailAndPassword(
            email: email.value as String? ?? email.defaultValue!,
            password: password.value as String? ?? password.defaultValue!,
          );
        } catch (e) {
          print(e);
        }
        if (user != null) {
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
            final index = states.indexWhere(
                (element) => element.name.toLowerCase() == 'status');
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
            print(e);
          }
        }
      }
    } catch (e) {
      print(e);
    }
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
      try {
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
      } catch (e) {
        print(e);
      }
    ''';
  }
}
*/
