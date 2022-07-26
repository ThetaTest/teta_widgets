// Flutter imports:
// ignore_for_file: public_member_api_docs

// Package imports:
import 'package:collection/collection.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WScaffold extends StatefulWidget {
  /// Returns a Scaffold
  const WScaffold(
    final Key? key, {
    required this.children,
    required this.node,
    required this.fill,
    required this.width,
    required this.height,
    required this.action,
    required this.forPlay,
    required this.showAppBar,
    required this.showBottomBar,
    required this.showDrawer,
    required this.isScrollable,
    required this.isClipped,
    required this.bodyExtended,
    required this.params,
    required this.states,
    required this.dataset,
    required this.flag,
    this.appBar,
    this.bottomBar,
    this.drawer,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final List<CNode> children;
  final FFill fill;
  final FSize width;
  final FSize height;
  final FAction action;
  final bool forPlay;
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
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  State<WScaffold> createState() => _WScaffoldState();
}

class _WScaffoldState extends State<WScaffold> {
  @override
  void initState() {
    if (widget.forPlay) {
      GestureBuilder.get(
        context: context,
        node: widget.node,
        gesture: ActionGesture.initState,
        actionValue: null,
        action: widget.action,
        params: widget.params,
        states: widget.states,
        dataset: widget.dataset,
        forPlay: widget.forPlay,
        loop: widget.loop,
      );
    }
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    final isPage = BlocProvider.of<FocusPageBloc>(context).state.isPage;
    if (!isPage && !widget.forPlay) {
      return SizedBox(
        child: Center(
          child: _childWids(context),
        ),
      );
    } else if (!isPage && widget.forPlay) {
      return SizedBox(
        child: Center(
          child: _childWids(context),
        ),
      );
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

    return widget.forPlay
        ? Scaffold(
            backgroundColor: BlocProvider.of<PaletteDarkLightCubit>(
              context,
            ).state
                ? Colors.white
                : Colors.black,
            resizeToAvoidBottomInset: widget.flag,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(120),
              child: widget.showAppBar && appBar != null
                  ? appBar.toWidget(
                      forPlay: widget.forPlay,
                      params: widget.params,
                      states: widget.states,
                      dataset: widget.dataset,
                    )
                  : const SizedBox(),
            ),
            drawer: drawerNode != null && widget.showDrawer
                ? Drawer(
                    child: drawerNode.toWidget(
                      params: widget.params,
                      states: widget.states,
                      dataset: widget.dataset,
                      forPlay: widget.forPlay,
                    ),
                  )
                : null,
            body: SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: _stack(context),
            ),
          )
        : Scaffold(
            backgroundColor: BlocProvider.of<PaletteDarkLightCubit>(
              context,
            ).state
                ? Colors.white
                : Colors.black,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(120),
              child: widget.showAppBar && appBar != null
                  ? appBar.toWidget(
                      forPlay: widget.forPlay,
                      params: widget.params,
                      states: widget.states,
                      dataset: widget.dataset,
                    )
                  : const SizedBox(),
            ),
            body: SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: _stack(context),
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

    final isPage = BlocProvider.of<FocusPageBloc>(context).state.isPage;
    if (!isPage) return _childWids(context);
    return Stack(
      children: [
        SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: _childWids(context),
        ),
        if (widget.showDrawer && !widget.forPlay)
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
                    ? drawerNode.toWidget(
                        params: widget.params,
                        states: widget.states,
                        dataset: widget.dataset,
                        forPlay: widget.forPlay,
                      )
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
                ? bottomBar.toWidget(
                    forPlay: widget.forPlay,
                    params: widget.params,
                    states: widget.states,
                    dataset: widget.dataset,
                  )
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
          (final e) => e.toWidget(
            forPlay: widget.forPlay,
            params: widget.params,
            states: widget.states,
            dataset: widget.dataset,
            loop: widget.loop,
          ),
        )
        .toList();
    return widgets.isNotEmpty
        ? Stack(
            children: [widgets.first],
          )
        : _placeholder(context);
  }

  Widget _placeholder(final BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF0A84FF),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
