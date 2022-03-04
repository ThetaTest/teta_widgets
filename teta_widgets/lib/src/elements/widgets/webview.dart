// Flutter imports:

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:webviewx/webviewx.dart';

// ignore_for_file: public_member_api_docs

class WWebViewXPage extends StatefulWidget {
  /// Returns a [Map] widget in Teta
  const WWebViewXPage({
    Key? key,
    required this.node,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    required this.controller,
    required this.url,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final bool forPlay;
  final int? loop;
  final FTextTypeInput controller;
  final FTextTypeInput url;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  State<WWebViewXPage> createState() => _WWebViewXPageState();
}

class _WWebViewXPageState extends State<WWebViewXPage> {
  Size get screenSize => MediaQuery.of(context).size;
  VariableObject? variable;

  @override
  void initState() {
    final page = BlocProvider.of<FocusPageBloc>(context).state;

    if (widget.controller.type == FTextTypeEnum.param) {
      variable = page.params
          .firstWhereOrNull((e) => e.name == widget.controller.paramName);
    } else {
      variable = page.states
          .firstWhereOrNull((e) => e.name == widget.controller.stateName);
    }

    super.initState();
  }

  @override
  void dispose() {
    variable?.webViewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebViewX(
      key: const ValueKey('webviewx'),
      onWebViewCreated: (controller) {
        variable?.webViewController = controller;
        _setUrl();
      },
      height: double.maxFinite,
      width: double.maxFinite,
    );
  }

  void _setUrl() {
    variable?.webViewController?.loadContent(
      widget.url.get(
        widget.params,
        widget.states,
        widget.dataset,
        widget.forPlay,
        widget.loop,
      ),
      SourceType.url,
    );
  }
}
