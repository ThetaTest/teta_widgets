// Flutter imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars, avoid_dynamic_calls

import 'package:camera/camera.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/src/rendering/nodes_original.dart';
import 'package:teta_core/src/repositories/queries/node.dart';
// Project imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:webviewx/webviewx.dart';

class WComponent extends StatefulWidget {
  /// Returns a Component
  const WComponent({
    Key? key,
    this.child,
    required this.node,
    this.componentName,
    this.paramsToSend,
    this.nid,
    this.parent,
    required this.forPlay,
    this.index,
    this.component,
    this.loop,
    required this.params,
    required this.states,
    required this.dataset,
  }) : super(key: key);

  final CNode node;
  final String? nid;
  final String? parent;
  final CNode? child;
  final String? componentName;
  final Map<String, dynamic>? paramsToSend;
  final bool forPlay;
  final double? index;
  final String? component;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  State<WComponent> createState() => _WComponentState();
}

class _WComponentState extends State<WComponent> {
  PageObject? component;
  String? componentName = '';
  WebViewXController? webViewController;
  ProjectLoaded? prjState;
  bool isLoaded = false;

  @override
  void initState() {
    prjState =
        BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded;
    if (componentName != widget.componentName) {
      debugPrint('calc');
      calc();
      componentName = widget.componentName;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded && component == null) {
      return const SizedBox();
    }
    if (component?.isHardCoded ?? false) {
      return hardCoded(component!);
    } else {
      return body(context);
    }
  }

  Future<List<CNode>> fetch(PageObject page, BuildContext context) async {
    debugPrint('fetching');
    final list = await NodeQueries.fetchNodesByPage(page.id);
    final nodes = <CNode>[];
    for (final e in list) {
      nodes.add(
        CNode.fromJson(
          e as Map<String, dynamic>,
          page.id,
        ),
      );
    }
    return nodes;
  }

  Future<void> calc() async {
    final prjState =
        BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded;
    PageObject? _component;
    _component = prjState.prj.pages!
        .firstWhereOrNull((element) => element.name == widget.componentName);
    if (_component != null) {
      _component = _component.copyWith(
        states: [
          ..._component.states
              .map((e) => e.toJson())
              .map(VariableObject.fromJson)
              .toList()
        ],
      );
    }
    if (_component != null && !_component.isHardCoded) {
      debugPrint('component fetched');
      if (component?.scaffold == null) {
        final nodes = await fetch(_component, context);
        final scaffold = NodeRendering.renderTree(nodes);
        _component = _component.copyWith(flatList: nodes, scaffold: scaffold);
      }
      if (mounted) {
        setState(() {
          component = _component;
          isLoaded = true;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          component = _component;
          isLoaded = true;
        });
      }
    }
  }

  Widget body(BuildContext context) {
    return component != null
        ? BlocProvider<FocusPageBloc>(
            create: (context) => FocusPageBloc()
              ..add(
                OnFocusPage(
                  prj: prjState!.prj,
                  page: component!,
                  context: context,
                  forPlay: widget.forPlay,
                  isComponent: true,
                ),
              ),
            child: BlocBuilder<FocusPageBloc, PageObject>(
              builder: (context, page) {
                return (page.scaffold == null)
                    ? const SizedBox()
                    : page.scaffold!.toWidget(
                        params: (widget.paramsToSend != null)
                            ? getVariableObjectsFromParams(page)
                            : page.params,
                        states: page.states,
                        dataset: page.datasets,
                        forPlay: widget.forPlay,
                        loop: widget.loop,
                      );
              },
            ),
          )
        : PlaceholderChildBuilder(name: widget.node.intrinsicState.displayName);
  }

  String initializeParamsForUri(List<VariableObject> listVariableObjectParams) {
    var parametersString = '';
    for (final element in listVariableObjectParams) {
      final rc = ReCase(element.name);
      final value = element.typeDeclaration(rc.camelCase) == 'String'
          ? '${element.get}'
          : element.firstValueForInitialization();
      if (listVariableObjectParams.length > 1) {
        if (listVariableObjectParams.indexOf(element) ==
            listVariableObjectParams.length - 1) {
          parametersString += '${rc.camelCase}=$value';
        } else {
          parametersString += '${rc.camelCase}=$value&';
        }
      } else {
        parametersString += '${rc.camelCase}=$value';
      }
    }
    return parametersString;
  }

  List<VariableObject> getVariableObjectsFromParams(PageObject page) {
    return page.params.map((e) {
      if (widget.paramsToSend?[e.id] != null) {
        if (widget.paramsToSend?[e.id]['dataset'] == 'Text') {
          e.value = widget.paramsToSend?[e.id]['label'];
        } else {
          final list = <DatasetObject>[
            DatasetObject(
              name: 'Parameters',
              map: widget.params
                  .map((e) => <String, dynamic>{e.name: e.get})
                  .toList(),
            ),
            DatasetObject(
              name: 'States',
              map: widget.states
                  .map((e) => <String, dynamic>{e.name: e.get})
                  .toList(),
            ),
            ...widget.dataset,
          ];
          Map<String, dynamic>? selectedDataset;
          for (final element in list) {
            if (element.getName == widget.paramsToSend?[e.id]['dataset']) {
              selectedDataset = <String, dynamic>{
                'name': element.getName,
                'map': element.getMap
              };
            }
          }
          VariableObject? variable;
          if (selectedDataset?['name'] == 'Parameters' ||
              selectedDataset?['name'] == 'States') {
            final map = selectedDataset!['map'] as List<Map<String, dynamic>>;
            //final element = map[loop ?? 0];
            for (final element in map) {
              if (element.keys.toList()[widget.loop ?? 0] ==
                  widget.paramsToSend?[e.id]?['label']) {
                if (element[element.keys.toList()[widget.loop ?? 0]]
                        is String ||
                    element[element.keys.toList()[widget.loop ?? 0]] is int ||
                    element[element.keys.toList()[widget.loop ?? 0]]
                        is double) {
                  variable = VariableObject(
                    name: element.keys.toList()[widget.loop ?? 0],
                    value: element[element.keys.toList()[widget.loop ?? 0]],
                  );
                }
                if (element[element.keys.toList()[widget.loop ?? 0]]
                    is CameraController) {
                  variable = VariableObject(
                    name: element.keys.toList()[widget.loop ?? 0],
                    type: VariableType.cameraController,
                    controller: element[element.keys.toList()[widget.loop ?? 0]]
                        as CameraController,
                  );
                }
                if (element[element.keys.toList()[widget.loop ?? 0]] is XFile) {
                  debugPrint('is XFile');
                  variable = VariableObject(
                    name: element.keys.toList()[widget.loop ?? 0],
                    type: VariableType.file,
                    file: element[element.keys.toList()[widget.loop ?? 0]]
                        as XFile,
                  );
                }
              }
            }
          } else {
            final el = selectedDataset!['map'] as List<Map<String, dynamic>>;
            final map = el[widget.loop ?? 0];
            for (final key in map.keys) {
              if (key == widget.paramsToSend?[e.id]?['label']) {
                variable = VariableObject(name: key, value: map[key]);
              }
            }
          }
          if (variable != null) {
            e
              ..value = variable.get
              ..file = variable.file
              ..controller = variable.controller;
          }
        }
      }
      return e;
    }).toList();
  }

  Widget hardCoded(PageObject page) {
    final _paramsString =
        initializeParamsForUri(getVariableObjectsFromParams(page));
    debugPrint(
      'run url: ${component!.runUrl}?${Uri.encodeFull(_paramsString)}',
    );
    return WebViewX(
      width: double.maxFinite,
      height: double.maxFinite,
      onWebViewCreated: (controller) {
        webViewController = controller;
        if (component?.runUrl != null) {
          webViewController?.loadContent(
            '${component!.runUrl}?${Uri.encodeFull(_paramsString)}',
            SourceType.url,
          );
        }
      },
    );
  }
}
