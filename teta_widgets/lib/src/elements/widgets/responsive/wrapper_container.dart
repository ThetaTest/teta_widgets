// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/src/utils/frame/device_frame.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

//ignore: must_be_immutable
class WWrapperContainer extends StatelessWidget {
  const WWrapperContainer({
    required this.node,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    final Key? key,
    this.child,
    this.index,
    this.component,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final double? index;
  final bool forPlay;
  final String? component;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(final BuildContext context) {
    return NodeSelection(
      node: node,
      forPlay: forPlay,
      nid: node.nid,
      child: BlocBuilder<DeviceModeCubit, DeviceInfo>(
        builder: (final context, final state) {
          if (state.identifier.type == DeviceType.desktop) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: ChildConditionBuilder(
                  ValueKey('${node.nid} $loop desktop'),
                  name: node.intrinsicState.displayName,
                  node: node,
                  child: child,
                  params: params,
                  states: states,
                  dataset: dataset,
                  forPlay: forPlay,
                  loop: loop,
                ),
              ),
            );
          }
          if (state.identifier.type == DeviceType.tablet) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: ChildConditionBuilder(
                ValueKey('${node.nid} $loop tablet'),
                name: node.intrinsicState.displayName,
                node: node,
                child: child,
                params: params,
                states: states,
                dataset: dataset,
                forPlay: forPlay,
                loop: loop,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ChildConditionBuilder(
              ValueKey('${node.nid} $loop mobile'),
              name: node.intrinsicState.displayName,
              node: node,
              child: child,
              params: params,
              states: states,
              dataset: dataset,
              forPlay: forPlay,
              loop: loop,
            ),
          );
        },
      ),
    );
  }
}
