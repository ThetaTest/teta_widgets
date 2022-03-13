// Flutter imports:
// Package imports:
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WAudioPlayer extends StatefulWidget {
  /// Returns a [WAudioPlayer] widget in Teta
  const WAudioPlayer(
    final Key? key, {
    required this.node,
    required this.controller,
    required this.url,
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
  final FTextTypeInput url;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  State<WAudioPlayer> createState() => _WAudioPlayerState();
}

class _WAudioPlayerState extends State<WAudioPlayer> {
  bool isInitialized = false;
  VariableObject? variable;
  DatasetObject _map = DatasetObject(
    name: '',
    map: [<String, dynamic>{}],
  );

  @override
  void initState() {
    _map = DatasetObject(
      name: widget.node.name ?? widget.node.intrinsicState.displayName,
      map: [<String, dynamic>{}],
    );
    init();
    super.initState();
  }

  Future<void> init() async {
    final page = BlocProvider.of<FocusPageBloc>(context).state;
    if (widget.controller.type == FTextTypeEnum.param) {
      variable = page.params
          .firstWhereOrNull((final e) => e.name == widget.controller.paramName);
    } else {
      variable = page.states
          .firstWhereOrNull((final e) => e.name == widget.controller.stateName);
    }
    variable?.audioController ??= AudioPlayer();
    if (variable?.audioController != null) {
      isInitialized = true;
    }
  }

  @override
  Widget build(final BuildContext context) {
    if (isInitialized) {
      return StreamBuilder(
        stream: variable?.audioController?.positionStream,
        builder: (final context, final snapshot) {
          if (!snapshot.hasData) {
            // has data is negative
            _map = _map.copyWith(
              name: widget.node.name ?? widget.node.intrinsicState.displayName,
              map: [
                <String, dynamic>{
                  'is playing': variable?.audioController?.playing.toString(),
                },
              ],
            );
          } else {
            final duration = snapshot.data as Duration?;
            _map = _map.copyWith(
              name: widget.node.name ?? widget.node.intrinsicState.displayName,
              map: [
                <String, dynamic>{
                  'minutes': duration?.inMinutes.toString(),
                  'seconds': duration?.inSeconds.toString(),
                  'is playing': variable?.audioController?.playing.toString(),
                },
              ],
            );
          }
          final datasets = addDataset(context, widget.dataset, _map);

          return ChildConditionBuilder(
            ValueKey('${widget.node.nid} ${widget.loop}'),
            name: widget.node.intrinsicState.displayName,
            child: widget.child,
            params: widget.params,
            states: widget.states,
            dataset: widget.dataset.isEmpty ? datasets : widget.dataset,
            forPlay: widget.forPlay,
            loop: widget.loop,
          );
        },
      );
    } else {
      return const Center(
        child: CText(
          'Audio Controller is not initialized yet',
          typography: CTypo.extraBold16(),
        ),
      );
    }
  }
}
