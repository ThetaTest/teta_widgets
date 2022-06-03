// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/src/utils/frame/device_frame.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WResponsiveCondition extends StatelessWidget {
  /// Returns a Responsive Condition in Teta
  const WResponsiveCondition(
    final Key? key, {
    required this.node,
    required this.visibleOnMobile,
    required this.visibleOnTablet,
    //required this.visibleOnDesktop,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final bool forPlay;
  final bool visibleOnMobile;
  final bool visibleOnTablet;
  //final bool visibleOnDesktop;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<DeviceModeCubit, DeviceInfo>(
      builder: (final context, final state) {
        // if (state.identifier.type == DeviceType.desktop) {
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
        if (state.identifier.type == DeviceType.tablet) {
          return visibleOnTablet
              ? ChildConditionBuilder(
                  ValueKey('${node.nid} $loop'),
                  name: node.intrinsicState.displayName,
                  child: child,
                  params: params,
                  states: states,
                  dataset: dataset,
                  forPlay: forPlay,
                  loop: loop,
                )
              : const SizedBox();
        }
        return visibleOnMobile
            ? ChildConditionBuilder(
                ValueKey('${node.nid} $loop'),
                name: node.intrinsicState.displayName,
                child: child,
                params: params,
                states: states,
                dataset: dataset,
                forPlay: forPlay,
                loop: loop,
              )
            : const SizedBox();
      },
    );
  }
}
