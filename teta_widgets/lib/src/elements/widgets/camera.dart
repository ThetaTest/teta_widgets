// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:camera/camera.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';

// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WCamera extends StatefulWidget {
  /// Returns a Camera widget in Teta
  const WCamera(
    Key? key, {
    required this.node,
    required this.controller,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final FTextTypeInput controller;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  State<WCamera> createState() => _WCameraState();
}

class _WCameraState extends State<WCamera> {
  @override
  Widget build(BuildContext context) {
    final page = BlocProvider.of<FocusPageBloc>(context).state;
    VariableObject? variable;
    if (widget.controller.type == FTextTypeEnum.param) {
      variable = page.params
          .firstWhereOrNull((e) => e.name == widget.controller.paramName);
    } else {
      variable = page.states
          .firstWhereOrNull((e) => e.name == widget.controller.stateName);
    }
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: variable?.controller != null
          ? SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: CameraPreview(variable!.controller!),
            )
          : const Center(
              child: CText(
                'Camera Controller is not initialized yet',
                customColor: Colors.white,
              ),
            ),
    );
  }
}
