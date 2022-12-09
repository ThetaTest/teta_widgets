// Flutter imports:
// Package imports:
import 'package:camera/camera.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WCamera extends StatefulWidget {
  /// Returns a Camera widget in Teta
  const WCamera(
    final Key? key, {
    required this.state,
    required this.controller,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FTextTypeInput controller;

  @override
  State<WCamera> createState() => _WCameraState();
}

class _WCameraState extends State<WCamera> {
  @override
  Widget build(final BuildContext context) {
    final page = BlocProvider.of<PageCubit>(context).state;
    VariableObject? variable;
    if (widget.controller.type == FTextTypeEnum.param) {
      variable = page.params
          .firstWhereOrNull((final e) => e.name == widget.controller.paramName);
    } else {
      variable = page.states
          .firstWhereOrNull((final e) => e.name == widget.controller.stateName);
    }
    return NodeSelectionBuilder(
      node: widget.state.node,
      forPlay: widget.state.forPlay,
      child: variable?.controller != null
          ? SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: CameraPreview(variable!.controller!),
            )
          : const Center(
              child: TParagraph(
                'Camera Controller is not initialized yet',
              ),
            ),
    );
  }
}
