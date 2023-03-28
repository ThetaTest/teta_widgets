// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
import 'package:theta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:theta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';

class WInfiniteListView extends StatefulWidget {
  /// Returns a ListView in Teta
  const WInfiniteListView(
    final Key? key, {
    required this.state,
    required this.children,
    required this.flagValue,
    required this.value,
    required this.isVertical,
  }) : super(key: key);

  final TetaWidgetState state;
  final List<CNode> children;
  final bool isVertical;
  final bool flagValue;
  final FTextTypeInput value;
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
    return TetaWidget(
      state: widget.state,
      child: MouseRegion(
        onEnter: (final v) {
          BlocProvider.of<ZoomableCubit>(context)
              .changeZoomableFlag(value: false);
        },
        onExit: (final v) {
          BlocProvider.of<ZoomableCubit>(context)
              .changeZoomableFlag(value: true);
        },
        child: _getBody(context),
      ),
    );
  }

  Widget _getBody(final BuildContext context) {
    if (_array.isEmpty) {
      if (_loading) {
        return widget.children.length > 2
            ? widget.children[2].toWidget(state: widget.state)
            : const SizedBox(); //loading
      } else if (_error) {
        return widget.children.length > 1
            ? widget.children[1].toWidget(state: widget.state)
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
                  ? widget.children[2].toWidget(state: widget.state)
                  : const SizedBox();
            }
            return widget.children.length > 1
                ? widget.children[1].toWidget(state: widget.state)
                : const SizedBox();
          }
          return widget.children.isNotEmpty
              ? widget.children.first.toWidget(state: widget.state)
              : PlaceholderChildBuilder(
                  name: widget.state.node.intrinsicState.displayName,
                  node: widget.state.node,
                  forPlay: widget.state.forPlay,
                );
        },
      );
    }
    return const SizedBox();
  }
}
