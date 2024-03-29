// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:tinycolor/tinycolor.dart';
import 'package:teta_front_end/teta_front_end.dart';

// ignore: import_of_legacy_library_into_null_safe

class ScaffoldMobile extends StatelessWidget {
  /// Returns a [Scaffold] widget for page
  const ScaffoldMobile({
    required this.state,
    required this.children,
    required this.fill,
    required this.width,
    required this.height,
    required this.showAppBar,
    required this.showBottomBar,
    required this.showDrawer,
    required this.isScrollable,
    required this.isClipped,
    required this.bodyExtended,
    final Key? key,
    this.index,
    this.appBar,
    this.bottomBar,
    this.drawer,
  }) : super(key: key);

  final TetaWidgetState state;
  final List<CNode> children;
  final FFill fill;
  final FSize width;
  final FSize height;
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

  @override
  Widget build(final BuildContext context) {
    final isPage = state.isPage;
    if (!isPage ||
        children.indexWhere(
              (final element) => element.globalType == NType.appBar,
            ) ==
            -1) {
      return state.forPlay
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

    return state.forPlay
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            drawer: drawerNode != null
                ? Drawer(
                    child: drawerNode.toWidget(state: state),
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
    final isPage = state.isPage;
    if (!isPage) return childWids(context);
    return Stack(
      children: [
        childWids(context),
        if (showAppBar)
          Positioned(
            child: (appBar != null)
                ? appBar.toWidget(state: state)
                : const SizedBox(),
          ),
        if (showBottomBar)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: (bottomBar != null)
                ? bottomBar.toWidget(state: state)
                : const SizedBox(),
          ),
        if (showDrawer && !state.forPlay)
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
                        state: state,
                      )
                    : const SizedBox(),
              ),
            ),
          ),
        if (state.forPlay)
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
          ? e.toWidget(state: state)
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
          (final e) => e.toWidget(state: state),
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
          THeadline3(
            'New section',
            color: TinyColor(
              HexColor(fill.levels![0].color),
            ).isLight()
                ? Colors.black
                : Colors.white,
          ),
        ],
      ),
    );
  }
}
