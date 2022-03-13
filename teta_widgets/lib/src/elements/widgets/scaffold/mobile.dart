// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:tinycolor/tinycolor.dart';

// ignore: import_of_legacy_library_into_null_safe

class ScaffoldMobile extends StatelessWidget {
  /// Returns a [Scaffold] widget for page
  const ScaffoldMobile({
    required this.children,
    required this.node,
    required this.fill,
    required this.width,
    required this.height,
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
    final Key? key,
    this.index,
    this.appBar,
    this.bottomBar,
    this.drawer,
  }) : super(key: key);

  final CNode node;
  final List<CNode> children;
  final FFill fill;
  final FSize width;
  final FSize height;
  final bool forPlay;
  final double? index;
  final CNode? appBar;
  final CNode? drawer;
  final CNode? bottomBar;
  final bool showAppBar;
  final bool showBottomBar;
  final bool showDrawer;
  final bool isScrollable;
  final bool isClipped;
  final bool bodyExtended;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(final BuildContext context) {
    final isPage = BlocProvider.of<FocusPageBloc>(context).state.isPage;
    if (!isPage ||
        children.indexWhere(
                (final element) => element.globalType == NType.appBar) ==
            -1) {
      return forPlay
          ? SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: childrenWidgets(
                  context,
                  withNewSectionButton: false,
                ),
              ),
            )
          : childWids(context);
    }
    return _scaffold(context);
  }

  Widget _scaffold(final BuildContext context) {
    CNode? drawerNode;
    try {
      drawerNode = children.firstWhere(
        (final element) => element.globalType == NType.drawer,
        // ignore: null_closures
        orElse: null,
      );
    } catch (e) {
      if (kDebugMode) {
        // ignore: avoid_print
        print(
          'Drawer not found: widgets/scaffold/mobile.dart, line: 83, error: $e',
        );
      }
    }

    return forPlay
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            drawer: drawerNode != null
                ? Drawer(
                    child: drawerNode.toWidget(
                      params: params,
                      states: states,
                      dataset: dataset,
                      forPlay: forPlay,
                    ),
                  )
                : null,
            body: stack(context),
          )
        : stack(context);
  }

  /// Returns the body of Scaffold,
  /// which consists in a [Stack] with [appBar] and [bottomBar].
  /// Eventualy, if !forPlay, also [drawer]
  Widget stack(final BuildContext context) {
    CNode? appBar;
    try {
      appBar = children.firstWhere(
        (final element) => element.globalType == NType.appBar,
        // ignore: null_closures
        orElse: null,
      );
    } catch (e) {
      if (kDebugMode) {
        // ignore: avoid_print
        print(
          'AppBar not found: widgets/scaffold/mobile.dart, line: 115, error: $e',
        );
      }
    }
    CNode? bottomBar;
    try {
      bottomBar = children.firstWhere(
        (final element) => element.globalType == NType.bottomBar,
        // ignore: null_closures
        orElse: null,
      );
    } catch (e) {
      if (kDebugMode) {
        // ignore: avoid_print
        print(
          'BottomBar not found: widgets/scaffold/mobile.dart, line: 128, error: $e',
        );
      }
    }
    CNode? drawerNode;
    try {
      drawerNode = children.firstWhere(
        (final element) => element.globalType == NType.drawer,
        // ignore: null_closures
        orElse: null,
      );
    } catch (e) {
      if (kDebugMode) {
        // ignore: avoid_print
        print(
          'Drawer not found: widgets/scaffold/mobile.dart, line: 141, error: $e',
        );
      }
    }
    final isPage = BlocProvider.of<FocusPageBloc>(context).state.isPage;
    if (!isPage) return childWids(context);
    return Stack(
      children: [
        childWids(context),
        if (showAppBar)
          Positioned(
            child: (appBar != null)
                ? appBar.toWidget(
                    forPlay: forPlay,
                    params: params,
                    states: states,
                    dataset: dataset,
                  )
                : const SizedBox(),
          ),
        if (showBottomBar)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: (bottomBar != null)
                ? bottomBar.toWidget(
                    forPlay: forPlay,
                    params: params,
                    states: states,
                    dataset: dataset,
                  )
                : const SizedBox(),
          ),
        if (showDrawer && !forPlay)
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
                        params: params,
                        states: states,
                        dataset: dataset,
                        forPlay: forPlay,
                      )
                    : const SizedBox(),
              ),
            ),
          ),
        if (forPlay)
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
          ),
      ],
    );
  }

  List<Widget> childrenWidgets(
    final BuildContext context, {
    required final bool withNewSectionButton,
  }) {
    return children.map((final e) {
      return e.intrinsicState.type != NType.bottomBar &&
              e.intrinsicState.type != NType.appBar &&
              e.intrinsicState.type != NType.drawer
          ? e.toWidget(
              forPlay: forPlay,
              params: params,
              states: states,
              dataset: dataset,
            )
          : const SizedBox();
    }).toList();
  }

  Widget childWids(final BuildContext context) {
    final widgets = children
        .where(
          (final e) =>
              e.intrinsicState.type != NType.bottomBar &&
              e.intrinsicState.type != NType.appBar &&
              e.intrinsicState.type != NType.drawer,
        )
        .map(
          (final e) => e.toWidget(
            forPlay: forPlay,
            params: params,
            states: states,
            dataset: dataset,
          ),
        )
        .toList();
    return widgets.isNotEmpty ? widgets.first : placeholder(context);
  }

  Widget placeholder(final BuildContext context) {
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
          CText(
            'New section',
            typography: const CTypo.extraBold16(),
            color: TinyColor(HexColor(fill.levels![0].color)).isLight()
                ? Colors.black
                : Colors.white,
          ),
        ],
      ),
    );
  }
}
