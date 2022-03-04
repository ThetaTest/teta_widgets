// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/src/utils/frame/device_frame.dart';
// Project imports:
import 'package:teta_core/teta_core.dart';

//ignore: must_be_immutable
class WWrapperContainer extends StatelessWidget {
  const WWrapperContainer({
    Key? key,
    this.child,
    required this.node,
    required this.forPlay,
    this.index,
    this.component,
    this.loop,
    required this.params,
    required this.states,
    required this.dataset,
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
  Widget build(BuildContext context) {
    return NodeSelection(
      node: node,
      forPlay: forPlay,
      nid: node.nid,
      child: BlocBuilder<DeviceModeCubit, DeviceInfo>(
        builder: (context, state) {
          if (state.identifier.type == DeviceType.desktop) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: ChildConditionBuilder(
                  name: node.intrinsicState.displayName,
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
                name: node.intrinsicState.displayName,
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
              name: node.intrinsicState.displayName,
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
