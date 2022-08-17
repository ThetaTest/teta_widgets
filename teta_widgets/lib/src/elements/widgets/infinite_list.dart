// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WInfiniteListView extends StatefulWidget {
  /// Returns a ListView in Teta
  const WInfiniteListView(
    final Key? key, {
    required this.children,
    required this.node,
    required this.forPlay,
    required this.flagValue,
    required this.value,
    required this.isVertical,
    required this.params,
    required this.states,
    required this.dataset,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final List<CNode> children;
  final bool forPlay;
  final bool isVertical;
  final bool flagValue;
  final FTextTypeInput value;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  _WInfiniteListViewState createState() => _WInfiniteListViewState();
}

class _WInfiniteListViewState extends State<WInfiniteListView> {
  final bool _hasMore = false;
  final bool _loading = true;
  final bool _error = true;
  final int _nextPageThreshold = 5;
  final List<int> _array = [];

  Future<void> _fetch() async {}

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: _body(context),
    );
  }

  Widget _body(final BuildContext context) {
    return MouseRegion(
      onEnter: (final v) {
        BlocProvider.of<ZoomableCubit>(context)
            .changeZoomableFlag(value: false);
      },
      onExit: (final v) {
        BlocProvider.of<ZoomableCubit>(context).changeZoomableFlag(value: true);
      },
      child: _getBody(context),
    );
  }

  Widget _getBody(final BuildContext context) {
    if (_array.isEmpty) {
      if (_loading) {
        return widget.children.length > 2
            ? widget.children[2].toWidget(
                loop: widget.loop,
                forPlay: widget.forPlay,
                params: widget.params,
                states: widget.states,
                dataset: widget.dataset,
              )
            : const SizedBox(); //loading
      } else if (_error) {
        return widget.children.length > 1
            ? widget.children[1].toWidget(
                loop: widget.loop,
                forPlay: widget.forPlay,
                params: widget.params,
                states: widget.states,
                dataset: widget.dataset,
              )
            : const SizedBox(); // error
      }
    } else {
      return ListView.builder(
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        scrollDirection: widget.isVertical ? Axis.vertical : Axis.horizontal,
        itemCount: _array.length + (_hasMore ? 0 : 1),
        itemBuilder: (final context, final index) {
          if (index == _array.length - _nextPageThreshold) {
            _fetch();
          }
          if (index == _array.length) {
            if (_error) {
              return widget.children.length > 2
                  ? widget.children[2].toWidget(
                      loop: widget.loop,
                      forPlay: widget.forPlay,
                      params: widget.params,
                      states: widget.states,
                      dataset: widget.dataset,
                    )
                  : const SizedBox();
            }
            return widget.children.length > 1
                ? widget.children[1].toWidget(
                    loop: widget.loop,
                    forPlay: widget.forPlay,
                    params: widget.params,
                    states: widget.states,
                    dataset: widget.dataset,
                  )
                : const SizedBox();
          }
          return widget.children.isNotEmpty
              ? widget.children.first.toWidget(
                  loop: widget.loop,
                  forPlay: widget.forPlay,
                  params: widget.params,
                  states: widget.states,
                  dataset: widget.dataset,
                )
              : PlaceholderChildBuilder(
                  name: widget.node.intrinsicState.displayName,
                  node: widget.node,
                  forPlay: widget.forPlay,
                );
        },
      );
    }
    return const SizedBox();
  }
}
