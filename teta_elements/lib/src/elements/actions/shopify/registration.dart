// Flutter imports:
/*import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_editor/src/blocs/focus_page/index.dart';
// Project imports:
import 'package:mobile_editor/src/cubits/zoomable/cubit.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';
import 'package:mobile_editor/src/utils/shopify/shopify/shopify.dart';

class FActionShopifyRegistration {
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
      if (page.states != null) {
        final email = page.states
            .firstWhere((element) => element.name.toLowerCase() == 'email');
        final password = page.states
            .firstWhere((element) => element.name.toLowerCase() == 'password');
        final firstName = page.states.firstWhere(
            (element) => element.name.toLowerCase() == 'first name');
        final lastName = page.states
            .firstWhere((element) => element.name.toLowerCase() == 'last name');
        if (email != null && password != null) {
          try {
            final index = states.indexWhere(
                (element) => element.name.toLowerCase() == 'status');
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
          final auth = ShopifyAuth.instance;
          final user = await auth.createUserWithEmailAndPassword(
            email: email.value as String? ?? email.defaultValue!,
            password: password.value as String? ?? password.defaultValue!,
            firstName: firstName.value as String? ?? firstName.defaultValue!,
            lastName: lastName.value as String? ?? lastName.defaultValue!,
          );
          if (user != null) {
            try {
              final index = states.indexWhere(
                  (element) => element.name.toLowerCase() == 'status');
              if (double.tryParse(states[index].value as String? ??
                      states[index].defaultValue!) !=
                  null) {
                states[index].value = 'Success';
              }
              BlocProvider.of<ZoomableCubit>(context).changeZoomableFlag(false);
              BlocProvider.of<ZoomableCubit>(context).changeZoomableFlag(true);
              print(nameOfPage);
              print(paramsToSend);
              /*FActionNavigationOpenPage().makeAction(node, context, nameOfPage,
                  paramsToSend, params, states, dataset, loop);*/
            } catch (e) {
              print(e);
            }
          } else {
            try {
              final index = states.indexWhere(
                  (element) => element.name.toLowerCase() == 'status');
              if (double.tryParse(states[index].value as String? ??
                      states[index].defaultValue!) !=
                  null) {
                states[index].value = 'Failed';
              }
              BlocProvider.of<ZoomableCubit>(context).changeZoomableFlag(false);
              BlocProvider.of<ZoomableCubit>(context).changeZoomableFlag(true);
            } catch (e) {
              print(e);
            }
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
    List<VariableObject> params,
    List<VariableObject> states,
    List<DatasetObject> dataset,
    int? loop,
  ) {
    return '''
    try {
      final states = BlocProvider.of<StatesCubit>(context).state;
      if (states != null) {
        final VariableObject? email = states!
            .firstWhere((element) => element.name!.toLowerCase() == "email");
        final VariableObject? password = states!
            .firstWhere((element) => element.name!.toLowerCase() == "password");
        final VariableObject? firstName = states!.firstWhere(
            (element) => element.name!.toLowerCase() == "first name");
        final VariableObject? lastName = states!.firstWhere(
            (element) => element.name!.toLowerCase() == "last name");
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
          final ShopifyUser? user = await auth.createUserWithEmailAndPassword(
            email: email.value ?? email.defaultValue,
            password: password.value ?? password.defaultValue,
            firstName: firstName?.value ?? firstName?.defaultValue,
            lastName: lastName?.value ?? lastName?.defaultValue,
          );
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
    }''';
  }
}
*/
