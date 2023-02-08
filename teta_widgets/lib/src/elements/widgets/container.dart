// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/src/rendering/find.dart';
import 'package:teta_core/teta_core.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WContainer extends StatefulWidget {
  /// Returns a Container widget
  const WContainer(
    final Key? key, {
    required this.state,
    required this.width,
    required this.height,
    required this.margins,
    required this.paddings,
    required this.fill,
    required this.borderRadius,
    required this.borders,
    required this.shadows,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FSize width;
  final FSize height;
  final FMargins margins;
  final FMargins paddings;
  final FFill fill;
  final FBorderRadius borderRadius;
  final FBorder borders;
  final FShadow shadows;

  @override
  State<WContainer> createState() => _WContainerState();
}

class _WContainerState extends State<WContainer> {
  @override
  Widget build(final BuildContext context) {
    final nodes = (context.read<PageCubit>().state as PageLoaded).page.flatList;
    final parent = sl.get<FindNodeRendering>().findParentByChildrenIds(
          flatList: nodes,
          element: widget.state.node,
        )!;
    final width = widget.width.get(
      context: context,
      isWidth: true,
      forPlay: widget.state.forPlay,
    );
    final height = widget.height.get(
      context: context,
      isWidth: false,
      forPlay: widget.state.forPlay,
    );
    var mustBeWrappedInExpanded = false;
    if (parent.globalType == NType.row && width == double.maxFinite) {
      mustBeWrappedInExpanded = true;
    } else if (parent.globalType == NType.column &&
        height == double.maxFinite) {
      mustBeWrappedInExpanded = true;
    }
    final container = TetaWidget(
      state: widget.state,
      child: Container(
        margin: widget.margins.get(
          context,
          forPlay: widget.state.forPlay,
        ),
        padding: widget.paddings.get(
          context,
          forPlay: widget.state.forPlay,
        ),
        width: width,
        height: widget.height.get(
          context: context,
          isWidth: false,
          forPlay: widget.state.forPlay,
        ),
        decoration: TetaBoxDecoration.get(
          context: context,
          fill: widget.fill.get(context),
          borderRadius: widget.borderRadius,
          shadow: widget.shadows,
          borders: widget.borders,
        ),
        child: ChildConditionBuilder(
          ValueKey(widget.state.toKey),
          state: widget.state,
          child: widget.child,
        ),
      ),
    );
    if (mustBeWrappedInExpanded) {
      return Expanded(
        child: container,
      );
    }
    return container;
  }
}
