/// FIXME: This widget is deprecated

/*import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_editor/src/blocs/focus/index.dart';
import 'package:mobile_editor/src/cubits/zoomable/cubit.dart';
import 'package:mobile_editor/src/design_system/hex_color.dart';
import 'package:mobile_editor/src/design_system/palette.dart';
import 'package:mobile_editor/src/design_system/text.dart';
import 'package:mobile_editor/src/elements/drag_target.dart';
import 'package:mobile_editor/src/elements/features/features.dart';
import 'package:mobile_editor/src/elements/nodes/navigation/appbar.dart';
import 'package:mobile_editor/src/elements/nodes/navigation/bottombar.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';
import 'package:nil/nil.dart';
import 'package:tinycolor/tinycolor.dart';

//ignore: must_be_immutable
class ScaffoldDesktop extends StatelessWidget {
  CNode node;
  String? name;
  List<CNode> children;
  FFill fill;
  FSize sizes;
  bool forPlay;
  double? index;
  NAppBar? appBar;
  NBottomBar? bottomBar;
  bool showAppBar;
  bool showBottomBar;
  bool isScrollable;
  bool isClipped;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  ScaffoldDesktop({
    required this.node,
    this.name,
    required this.fill,
    required this.sizes,
    required this.children,
    required this.forPlay,
    this.index,
    this.appBar,
    this.bottomBar,
    required this.showAppBar,
    required this.showBottomBar,
    required this.isScrollable,
    required this.isClipped,
    required this.params,
    required this.states,
    required this.dataset,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          minHeight: 1080,
        ),
        width: 1920,
        height: isClipped || forPlay ? 1080 : null,
        child: ClipRect(
          child: GestureDetector(
            onTap: () {
              if (!forPlay) {
                BlocProvider.of<FocusBloc>(context)..add(OnFocus(node: node));
              }
            },
            child: children.length == 0 || isScrollable
                ? DragTargetWidget(
                    node: node,
                    child: mouseRegion(context),
                  )
                : mouseRegion(context),
          ),
        ),
      ),
    );
  }

  Widget mouseRegion(BuildContext context) {
    return MouseRegion(
      onEnter: (v) {
        if (isScrollable && (isClipped || forPlay))
          BlocProvider.of<ZoomableCubit>(context).changeZoomableFlag(false);
      },
      onExit: (v) {
        if (isScrollable && (isClipped || forPlay))
          BlocProvider.of<ZoomableCubit>(context).changeZoomableFlag(true);
      },
      child: scaffold(context),
    );
  }

  Widget scaffold(BuildContext context) {
    return (forPlay || isClipped)
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: (appBar != null && showAppBar)
                ? AppBar(
                    title: appBar!.toWidget(
                      forPlay: forPlay,
                      params: params,
                      states: states,
                      dataset: dataset,
                    ),
                  )
                : PreferredSize(
                    preferredSize: Size.fromHeight(0.0), child: const SizedBox()
                    ),
            drawer: Drawer(
              child: Text('Hey'),
            ),
            bottomNavigationBar: (bottomBar != null && showBottomBar)
                ? bottomBar!.toWidget(
                    forPlay: forPlay,
                    params: params,
                    states: states,
                    dataset: dataset,
                  )
                : BottomAppBar(),
            body: containerStyle(context),
          )
        : containerStyle(context);
  }

  Widget containerStyle(BuildContext context) {
    return (children.isNotEmpty)
        ? Container(
            decoration: fill.type == FFillType.solid
                ? BoxDecoration(
                    color: HexColor(fill.levels![0].color),
                    border: Border.all(
                        color: DarkPalette().colors["Palette.accent"] as Color,
                        style: BorderStyle.solid,
                        width: BlocProvider.of<FocusBloc>(context).state == node
                            ? 2
                            : 0),
                  )
                : fill.type == FFillType.linearGradient
                    ? BoxDecoration(
                        gradient: LinearGradient(
                          colors: fill.levels!
                              .map((e) => HexColor(e.color))
                              .toList(),
                          begin: fill.begin!,
                          end: fill.end!,
                          stops: fill.levels!.map((e) => e.stop).toList(),
                        ),
                        border: Border.all(
                            color:
                                DarkPalette().colors["Palette.accent"] as Color,
                            style: BorderStyle.solid,
                            width: BlocProvider.of<FocusBloc>(context).state ==
                                    node
                                ? 2
                                : 0),
                      )
                    : fill.type == FFillType.radialGradient
                        ? BoxDecoration(
                            gradient: RadialGradient(
                              colors: fill.levels!
                                  .map((e) => HexColor(e.color))
                                  .toList(),
                              center: fill.center!,
                              radius: fill.radius!,
                              stops: fill.levels!.map((e) => e.stop).toList(),
                            ),
                            border: Border.all(
                                color: DarkPalette().colors["Palette.accent"]
                                    as Color,
                                style: BorderStyle.solid,
                                width:
                                    BlocProvider.of<FocusBloc>(context).state ==
                                            node
                                        ? 2
                                        : 0),
                          )
                        : BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                fill.levels![0].color,
                              ),
                              fit: fill.boxFit!.get(context),
                            ),
                          ),
            child: body(context),
          )
        : Container(
            decoration: fill.type == FFillType.solid
                ? BoxDecoration(
                    color: HexColor(fill.levels![0].color),
                    border: Border.all(
                        color: DarkPalette().colors["Palette.accent"] as Color,
                        style: BorderStyle.solid,
                        width: BlocProvider.of<FocusBloc>(context).state == node
                            ? 2
                            : 0),
                  )
                : fill.type == FFillType.linearGradient
                    ? BoxDecoration(
                        gradient: LinearGradient(
                          colors: fill.levels!
                              .map((e) => HexColor(e.color))
                              .toList(),
                          begin: fill.begin!,
                          end: fill.end!,
                          stops: fill.levels!.map((e) => e.stop).toList(),
                        ),
                        border: Border.all(
                            color:
                                DarkPalette().colors["Palette.accent"] as Color,
                            style: BorderStyle.solid,
                            width: BlocProvider.of<FocusBloc>(context).state ==
                                    node
                                ? 2
                                : 0),
                      )
                    : fill.type == FFillType.radialGradient
                        ? BoxDecoration(
                            gradient: RadialGradient(
                              colors: fill.levels!
                                  .map((e) => HexColor(e.color))
                                  .toList(),
                              center: fill.center!,
                              radius: fill.radius!,
                              stops: fill.levels!.map((e) => e.stop).toList(),
                            ),
                            border: Border.all(
                                color: DarkPalette().colors["Palette.accent"]
                                    as Color,
                                style: BorderStyle.solid,
                                width:
                                    BlocProvider.of<FocusBloc>(context).state ==
                                            node
                                        ? 2
                                        : 0),
                          )
                        : BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                fill.levels![0].color,
                              ),
                              fit: fill.boxFit!.get(context),
                            ),
                          ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Color(0xFF0A84FF),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                  const CText(
                    'New section',
                    size: 16,
                    color: Palette.black,
                  ),
                ],
              ),
            ),
          );
  }

  Widget body(BuildContext context) {
    return isScrollable
        ? isClipped || forPlay
            ? ListView(
                children: childrenWidgets(context, false),
              )
            : Column(
                children: childrenWidgets(context, true),
              )
        : childrenWids(context);
  }

  List<Widget> childrenWidgets(
      BuildContext context, bool withNewSectionButton) {
    return !withNewSectionButton
        ? children
            .map(
              (e) => e.intrinsicState.type != "BottomBar" &&
                      e.intrinsicState.type != "AppBar"
                  ? e.toWidget(
                      forPlay: forPlay,
                      params: params,
                      states: states,
                      dataset: dataset,
                    )
                  : const SizedBox(),
            )
            .toList()
        : [
            ...children
                .map(
                  (e) => e.intrinsicState.type != "BottomBar" &&
                          e.intrinsicState.type != "AppBar"
                      ? e.toWidget(
                          forPlay: forPlay,
                          params: params,
                          states: states,
                          dataset: dataset,
                        )
                      : const SizedBox(),
                )
                .toList(),
            Container(
              margin: const EdgeInsets.all(16),
              width: double.maxFinite,
              height: 150,
              decoration: BoxDecoration(color: Colors.white54),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Color(0xFF0A84FF),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                  CText(
                    'New section',
                    size: 16,
                    color: TinyColor(HexColor(fill.levels![0].color)).isLight()
                        ? Palette.black
                        : Palette.white,
                  ),
                ],
              ),
            ),
          ];
  }

  Widget childrenWids(BuildContext context) {
    return children
        .map((e) => e.intrinsicState.type != "BottomBar" &&
                e.intrinsicState.type != "AppBar"
            ? e.toWidget(
                forPlay: forPlay,
                params: params,
                states: states,
                dataset: dataset,
              )
            : const SizedBox())
        .toList()[0];
  }
}
*/
