import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_front_end/teta_front_end.dart';

import '../../../../actions/translator/translate/action.dart';
import '../../../../actions/translator/translate/params.dart';

class TranslatorTranslateControl extends StatefulWidget {
  const TranslatorTranslateControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TATranslatorTranslate action;
  final Function(TATranslatorTranslateParams params) onParamsChanged;

  @override
  State<TranslatorTranslateControl> createState() =>
      TranslatorTranslateControlState();
}

class TranslatorTranslateControlState
    extends State<TranslatorTranslateControl> {
  String? stateName;

  @override
  void initState() {
    super.initState();
    stateName = widget.action.params.stateName;
  }

  void updateParams() {
    widget.onParamsChanged(TATranslatorTranslateParams(stateName: stateName));
  }

  @override
  Widget build(final BuildContext context) {
    final pageLoaded = context.read<PageCubit>().state as PageLoaded;
    return CDropdown(
      value: pageLoaded.page.defaultStates
                  .map((final e) => e.name)
                  .where((final element) => element != 'null')
                  .toList()
                  .indexWhere(
                    (final e) => e == stateName,
                  ) !=
              -1
          ? widget.action.params.stateName
          : null,
      items: pageLoaded.page.defaultStates
          .map((final e) => e.name)
          .where((final element) => element != 'null')
          .toList(),
      onChange: (final newValue) {
        stateName = newValue;
        updateParams();
      },
    );
  }
}
