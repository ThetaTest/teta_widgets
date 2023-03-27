// Flutter imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars, avoid_dynamic_calls

// Package imports:
import 'package:collection/collection.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/src/rendering/nodes.dart';
import 'package:teta_core/teta_core.dart';
import 'package:theta_repositories/src/node_repository.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/builder/gesture_detector_base.dart';
import 'package:teta_widgets/src/elements/builder/get_variable_from_params.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:webviewx/webviewx.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:theta_models/theta_models.dart';

class WComponent extends StatefulWidget {
  /// Returns a Component
  const WComponent(
    final Key? key, {
    required this.state,
    required this.componentName,
    this.paramsToSend,
  }) : super(key: key);

  final TetaWidgetState state;
  final String componentName;
  final Map<String, dynamic>? paramsToSend;

  @override
  State<WComponent> createState() => _WComponentState();
}

class _WComponentState extends State<WComponent> {
  PageObject? component;
  WebViewXController? webViewController;
  late ProjectObject prj;
  bool isLoaded = false;
  String _paramsString = '';

  @override
  void initState() {
    super.initState();
    calc();
  }

  Future<void> calc() async {
    final pages = context.read<PagesCubit>().state;
    PageObject? component;
    component = pages.firstWhereOrNull(
      (final element) => element.name == widget.componentName,
    );
    if (component != null) {
      await fetch(component, context);
      if (component.isHardCoded) {
        if (mounted) {
          setState(() {
            _paramsString = initializeParamsForUri(
              getVariableObjectsFromParams(
                widget.state,
                component!,
                widget.paramsToSend,
              ),
            );
            component = component;
            isLoaded = true;
          });
        }
      } else {
        if (component.scaffold == null) {
          final nodes = await fetch(component, context);
          final scaffold = sl.get<NodeRendering>().renderTree(nodes);
          component = component.copyWith(flatList: nodes, scaffold: scaffold);
        }
        if (mounted) {
          setState(() {
            component = component;
            isLoaded = true;
          });
        }
      }
    }
  }

  Future<List<CNode>> fetch(
    final PageObject page,
    final BuildContext context,
  ) async {
    final list = await sl.get<NodeRepository>().fetchNodesByPage(page.id);
    if (list.error != null) return [];
    return list.data!;
  }

  @override
  Widget build(final BuildContext context) {
    if (!isLoaded && component == null) {
      return const SizedBox();
    }
    if (component?.isHardCoded ?? false) {
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
    } else {
      return component != null
          ? NodeSelection(
              state: widget.state,
              child: _VisualBody(
                component: component!,
                state: widget.state,
                paramsToSend: widget.paramsToSend,
              ),
            )
          : PlaceholderChildBuilder(
              name: widget.state.node.intrinsicState.displayName,
              node: widget.state.node,
              forPlay: widget.state.forPlay,
            );
    }
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
}

class _VisualBody extends StatelessWidget {
  const _VisualBody({
    required this.component,
    required this.state,
    required this.paramsToSend,
    final Key? key,
  }) : super(key: key);

  final PageObject component;
  final TetaWidgetState state;
  final Map<String, dynamic>? paramsToSend;

  @override
  Widget build(final BuildContext context) {
    return BlocProvider<PageCubit>(
      lazy: false,
      create: (final context) => PageCubit(
        sl.get(),
        sl.get(),
        sl.get(),
        sl.get(),
      )..onFocus(
          page: component,
          forPlay: state.forPlay,
        ),
      child: _VBody(
        component: component,
        state: state,
        paramsToSend: paramsToSend,
      ),
    );
  }
}

class _VBody extends StatelessWidget {
  const _VBody({
    required this.component,
    required this.state,
    required this.paramsToSend,
    final Key? key,
  }) : super(key: key);

  final PageObject component;
  final TetaWidgetState state;
  final Map<String, dynamic>? paramsToSend;

  @override
  Widget build(final BuildContext context) {
    final pageState = context.watch<PageCubit>().state;
    if (pageState is! PageLoaded) return const SizedBox();
    return GestureBuilderBase.get(
      context: context,
      state: state,
      child: IgnorePointer(
        ignoring: !state.forPlay,
        child: pageState.page.scaffold.toWidget(
          state: state.copyWith(
            params: (paramsToSend != null)
                ? getVariableObjectsFromParams(
                    state,
                    pageState.page,
                    paramsToSend,
                  )
                : pageState.params,
            states: pageState.states,
            dataset: pageState.datasets,
          ),
        ),
      ),
    );
  }
}
