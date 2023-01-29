// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WResponsiveCondition extends StatelessWidget {
  /// Returns a Responsive Condition in Teta
  const WResponsiveCondition(
    final Key? key, {
    required this.state,
    required this.visibleOnMobile,
    required this.visibleOnTablet,
    //required this.visibleOnDesktop,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final bool visibleOnMobile;
  final bool visibleOnTablet;
  //final bool visibleOnDesktop;

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<DeviceModeCubit, DeviceState>(
      builder: (final context, final deviceInfostate) {
        // if (deviceInfostate.identifier.type == DeviceType.desktop) {
        //   return visibleOnDesktop
        //       ? ChildConditionBuilder(
        //           ValueKey('${node.nid} $loop'),
        //           name: node.intrinsicState.displayName,
        //           child: child,
        //           params: params,
        //           states: states,
        //           dataset: dataset,
        //           forPlay: forPlay,
        //           loop: loop,
        //         )
        //       : const SizedBox();
        // }
        if (deviceInfostate.info.identifier.type == DeviceType.tablet) {
          return visibleOnTablet
              ? ChildConditionBuilder(
                  ValueKey(state.toKey),
                  state: state,
                  child: child,
                )
              : const SizedBox();
        }
        return visibleOnMobile
            ? ChildConditionBuilder(
                ValueKey(state.toKey),
                state: state,
                child: child,
              )
            : const SizedBox();
      },
    );
  }
}
