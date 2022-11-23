// Flutter imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars, avoid_dynamic_calls

// Package imports:
import 'package:camera/camera.dart';
import 'package:collection/collection.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/src/rendering/nodes_original.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_repositories/src/node_repository.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/builder/gesture_detector_base.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:webviewx/webviewx.dart';

class WComponent extends StatefulWidget {
  /// Returns a Component
  const WComponent(
    final Key? key, {
    required this.state,
    required this.componentName,
    this.child,
    this.paramsToSend,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final String componentName;
  final Map<String, dynamic>? paramsToSend;

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
    prjState = BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded;
    if (componentName != widget.componentName) {
      calc();
    }
    super.initState();
  }

  Future<void> calc() async {
    prjState = BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded;
    PageObject? _component;
    _component = prjState!.prj.pages!.firstWhereOrNull(
      (final element) => element.name == widget.componentName,
    );

    if (_component != null) {
      _component = _component.copyWith(
        states: [
          ..._component.states.map((final e) => e.toJson()).map(VariableObject.fromJson).toList()
        ],
      );
      final nodes = await fetch(_component, context);
    }
    if (_component != null && !_component.isHardCoded) {
      Logger.printMessage('enter here');
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

  @override
  Widget build(final BuildContext context) {
    if (!isLoaded && component == null) {
      return const SizedBox();
    }
    if (component?.isHardCoded ?? false) {
      return hardCoded(component!);
    } else {
      return body(context);
    }
  }

  Future<List<CNode>> fetch(
    final PageObject page,
    final BuildContext context,
  ) async {
    final list = await NodeRepository.fetchNodesByPage(page.id);
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

  Widget body(final BuildContext context) {
    return component != null
        ? BlocProvider<PageCubit>(
            create: (final context) => PageCubit()
              ..onFocus(
                prj: prjState!.prj,
                page: component!,
                context: context,
                forPlay: widget.state.forPlay,
                isComponent: true,
              ),
            child: BlocBuilder<PageCubit, PageObject>(
              builder: (final context, final page) {
                return (page.scaffold == null)
                    ? const SizedBox()
                    : NodeSelection(
                        node: widget.state.node,
                        forPlay: widget.state.forPlay,
                        nid: widget.state.node.nid,
                        child: GestureBuilderBase.get(
                          context: context,
                          state: widget.state,
                          child: IgnorePointer(
                            ignoring: !widget.state.forPlay,
                            child: page.scaffold!.toWidget(
                              state: widget.state.copyWith(
                                params: (widget.paramsToSend != null)
                                    ? getVariableObjectsFromParams(page)
                                    : page.params,
                                states: page.states,
                                dataset: page.datasets,
                              ),
                            ),
                          ),
                        ),
                      );
              },
            ),
          )
        : PlaceholderChildBuilder(
            name: widget.state.node.intrinsicState.displayName,
            node: widget.state.node,
            forPlay: widget.state.forPlay,
          );
  }

  String initializeParamsForUri(
    final List<VariableObject> listVariableObjectParams,
  ) {
    var parametersString = '';
    for (final element in listVariableObjectParams) {
      final rc = ReCase(element.name);
      final value = element.typeDeclaration(rc.camelCase) == 'String'
          ? '${element.get}'
          : element.firstValueForInitialization();
      if (listVariableObjectParams.length > 1) {
        if (listVariableObjectParams.indexOf(element) == listVariableObjectParams.length - 1) {
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

  List<VariableObject> getVariableObjectsFromParams(final PageObject page) {
    return page.params.map((final e) {
      if (widget.paramsToSend?[e.id] != null) {
        if (widget.paramsToSend?[e.id]['dataset'] == 'Text') {
          e.value = widget.paramsToSend?[e.id]['label'];
        } else {
          final list = <DatasetObject>[
            DatasetObject(
              name: 'Parameters',
              map: widget.state.params.map((final e) => <String, dynamic>{e.name: e.get}).toList(),
            ),
            DatasetObject(
              name: 'States',
              map: widget.state.states.map((final e) => <String, dynamic>{e.name: e.get}).toList(),
            ),
            ...widget.state.dataset,
          ];
          Map<String, dynamic>? selectedDataset;
          for (final element in list) {
            if (element.getName == widget.paramsToSend?[e.id]['dataset']) {
              selectedDataset = <String, dynamic>{'name': element.getName, 'map': element.getMap};
            }
          }
          VariableObject? variable;
          if (selectedDataset?['name'] == 'Parameters' || selectedDataset?['name'] == 'States') {
            final map = selectedDataset!['map'] as List<Map<String, dynamic>>;
            for (final element in map) {
              if (element.keys.toList()[widget.state.loop ?? 0] ==
                  widget.paramsToSend?[e.id]?['label']) {
                if (element[element.keys.toList()[widget.state.loop ?? 0]] is String ||
                    element[element.keys.toList()[widget.state.loop ?? 0]] is int ||
                    element[element.keys.toList()[widget.state.loop ?? 0]] is double) {
                  variable = VariableObject(
                    name: element.keys.toList()[widget.state.loop ?? 0],
                    value: element[element.keys.toList()[widget.state.loop ?? 0]],
                  );
                }
                if (element[element.keys.toList()[widget.state.loop ?? 0]] is CameraController) {
                  variable = VariableObject(
                    name: element.keys.toList()[widget.state.loop ?? 0],
                    type: VariableType.cameraController,
                    controller:
                        element[element.keys.toList()[widget.state.loop ?? 0]] as CameraController,
                  );
                }
                if (element[element.keys.toList()[widget.state.loop ?? 0]] is XFile) {
                  debugPrint('is XFile');
                  variable = VariableObject(
                    name: element.keys.toList()[widget.state.loop ?? 0],
                    type: VariableType.file,
                    file: element[element.keys.toList()[widget.state.loop ?? 0]] as XFile,
                  );
                }
              }
            }
          } else {
            final el = selectedDataset!['map'] as List<Map<String, dynamic>>;
            final map = el[widget.state.loop ?? 0];
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

  //! this in the editor need to be in a sizedBox
  Widget hardCoded(final PageObject page) {
    final _paramsString = initializeParamsForUri(getVariableObjectsFromParams(page));
    return WebViewX(
      width: double.maxFinite,
      height: double.maxFinite,
      onWebViewCreated: (final controller) {
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
