/*
// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
// Project imports:
import 'package:mobile_editor/src/blocs/focus_page/index.dart';
import 'package:mobile_editor/src/blocs/focus_project/index.dart';
import 'package:mobile_editor/src/design_system/dropdowns/dropdown.dart';
import 'package:mobile_editor/src/elements/controls/atoms/firebase/path.dart';
import 'package:mobile_editor/src/elements/features/action.dart';
import 'package:mobile_editor/src/elements/features/firestore_path.dart';

class FirebaseFirestoreActionElementBody extends StatelessWidget {
  final FActionElement element;
  final Function(FActionElement, FActionElement) callback;
  const FirebaseFirestoreActionElementBody({
    Key? key,
    required this.element,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config =
        (BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded)
            .prj
            .config;
    return Column(
      children: [
        CDropdown(
          value: FActionElement.getFirebaseFirestore(config).indexWhere((e) =>
                      e ==
                      FActionElement.convertFirebaseFirestoreValueToDropdown(
                          element.actionFirebaseFirestore)) !=
                  -1
              ? FActionElement.convertFirebaseFirestoreValueToDropdown(
                  element.actionFirebaseFirestore)
              : null,
          items: FActionElement.getFirebaseFirestore(config),
          onChange: (newValue) {
            if (newValue != null) {
              final old = element;
              element.convertFirebaseFirestoreFromDropdown(newValue);
              callback(element, old);
            }
          },
        ),
        FirestorePathControl(
          prj: (BlocProvider.of<FocusProjectBloc>(context).state
                  as ProjectLoaded)
              .prj,
          page: BlocProvider.of<FocusPageBloc>(context).state,
          path: element.path ?? FFirestorePath(),
          isForAddData: true,
          callBack: (path, old) {
            final old = element;
            element.path = path;
            callback(element, old);
          },
        ),
      ],
    );
  }
}
*/
