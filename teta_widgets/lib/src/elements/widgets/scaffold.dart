// Flutter imports:
// ignore_for_file: public_member_api_docs

// Package imports:
import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:collection/collection.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import '../../core/teta_widget/index.dart';
// Project imports:
import '../index.dart';
import 'package:teta_front_end/teta_front_end.dart';

class WScaffold extends StatefulWidget {
  /// Returns a Scaffold
  const WScaffold(
    final Key? key, {
    required this.state,
    required this.children,
    required this.fill,
    required this.width,
    required this.height,
    required this.action,
    required this.showAppBar,
    required this.showBottomBar,
    required this.showDrawer,
    required this.isScrollable,
    required this.isClipped,
    required this.bodyExtended,
    required this.isBoxed,
    required this.flag,
    this.appBar,
    this.bottomBar,
    this.drawer,
  }) : super(key: key);

  final TetaWidgetState state;
  final List<CNode> children;
  final bool isBoxed;
  final FFill fill;
  final FSize width;
  final FSize height;
  final NodeGestureActions action;
  final CNode? appBar;
  final CNode? bottomBar;
  final CNode? drawer;
  final bool showAppBar;
  final bool showBottomBar;
  final bool showDrawer;
  final bool isScrollable;
  final bool isClipped;
  final bool bodyExtended;
  final bool flag;

  @override
  State<WScaffold> createState() => _WScaffoldState();
}

class _WScaffoldState extends State<WScaffold> with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(final BuildContext context) {
    if (widget.state.forPlay) {
      GestureBuilder.get(
        context: context,
        state: widget.state,
        gesture: ActionGesture.initState,
        actionValue: null,
        nodeGestureActions: widget.action,
      );
    }
  }

  @override
  Widget build(final BuildContext context) {
    final isPage = widget.state.isPage;
    if (!isPage && !widget.state.forPlay) {
      return SizedBox(
        child: Center(
          child: _childWids(context),
        ),
      );
    } else if (!isPage && widget.state.forPlay) {
      return _childWids(context);
    } else {
      return _scaffold(context);
    }
  }

  Widget _scaffold(final BuildContext context) {
    CNode? drawerNode;
    drawerNode = widget.children.firstWhereOrNull(
      (final element) => element.globalType == NType.drawer,
    );

    CNode? appBar;
    appBar = widget.children.firstWhereOrNull(
      (final element) => element.globalType == NType.appBar,
    );

    return widget.state.forPlay
        ? Scaffold(
            backgroundColor: HexColor(widget.fill.getHexColor(context)),
            resizeToAvoidBottomInset: widget.flag,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(120),
              child: widget.showAppBar && appBar != null
                  ? appBar.toWidget(state: widget.state)
                  : const SizedBox(),
            ),
            drawer: drawerNode != null
                ? Drawer(
                    child: drawerNode.toWidget(state: widget.state),
                  )
                : null,
            body: SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: _stack(context),
            ),
          )
        : Scaffold(
            backgroundColor: HexColor(widget.fill.getHexColor(context)),
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(120),
              child: widget.showAppBar && appBar != null
                  ? appBar.toWidget(state: widget.state)
                  : const SizedBox(),
            ),
            body: SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: IntrinsicHeight(
                child: _stack(context),
              ),
            ),
          );
  }

  /// Returns the body of Scaffold,
  /// which consists in a Stack with widget.appBar and widget.bottomBar.
  /// Eventualy, if !forPlay, also widget.drawer
  Widget _stack(final BuildContext context) {
    CNode? bottomBar;
    bottomBar = widget.children.firstWhereOrNull(
      (final element) => element.globalType == NType.bottomBar,
    );

    CNode? drawerNode;
    drawerNode = widget.children.firstWhereOrNull(
      (final element) => element.globalType == NType.drawer,
    );

    final isPage = widget.state.isPage;
    if (!isPage) return _childWids(context);
    return Stack(
      children: [
        Positioned.fill(
          child: _childWids(context),
        ),
        if (widget.showDrawer && !widget.state.forPlay)
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(right: 50),
              decoration: const BoxDecoration(color: Colors.black38),
              child: Drawer(
                child: drawerNode != null
                    ? drawerNode.toWidget(state: widget.state)
                    : const SizedBox(),
              ),
            ),
          ),
        /*if (!forPlay)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 134,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                margin: const EdgeInsets.only(
                  top: 21,
                  bottom: 8,
                ),
              ),
            ),
          ),*/
        if (widget.showBottomBar)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: (bottomBar != null)
                ? bottomBar.toWidget(state: widget.state)
                : const SizedBox(),
          ),
      ],
    );
  }

  Widget _childWids(final BuildContext context) {
    final widgets = widget.children
        .where(
          (final e) =>
              e.intrinsicState.type != NType.bottomBar &&
              e.intrinsicState.type != NType.appBar &&
              e.intrinsicState.type != NType.drawer,
        )
        .map(
          (final e) => e.toWidget(state: widget.state),
        )
        .toList();
    return widgets.isNotEmpty
        ? widget.isBoxed
            ? Center(
                child: WrapperContainer(
                  child: Stack(
                    children: [widgets.first],
                  ),
                ),
              )
            : Stack(
                children: [widgets.first],
              )
        : _placeholder(context);
  }

  Widget _placeholder(final BuildContext context) {
    return PlaceholderChildBuilder(
      name: widget.state.node.intrinsicState.displayName,
      node: widget.state.node,
      forPlay: widget.state.forPlay,
    );
  }
}
