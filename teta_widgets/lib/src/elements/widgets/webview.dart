// Flutter imports:

// Package imports:
import 'package:collection/collection.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/teta_widget_state.dart';
import 'package:teta_widgets/src/elements/builder/gesture_detector_base.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:webviewx/webviewx.dart';
import 'package:teta_front_end/teta_front_end.dart';
// ignore_for_file: public_member_api_docs

class WWebViewXPage extends StatefulWidget {
  /// Returns a WebView widget in Teta
  const WWebViewXPage(
    final Key? key, {
    required this.controller,
    required this.url,
    required this.state,
  }) : super(key: key);

  final TetaWidgetState state;
  final FTextTypeInput controller;
  final FTextTypeInput url;

  @override
  State<WWebViewXPage> createState() => _WWebViewXPageState();
}

class _WWebViewXPageState extends State<WWebViewXPage> {
  Size get screenSize => MediaQuery.of(context).size;
  VariableObject? variable;

  @override
  void initState() {
    final page = BlocProvider.of<PageCubit>(context).state as PageLoaded;

    if (widget.controller.type == FTextTypeEnum.param) {
      variable = page.params
          .firstWhereOrNull((final e) => e.name == widget.controller.paramName);
    } else {
      variable = page.states
          .firstWhereOrNull((final e) => e.name == widget.controller.stateName);
    }

    super.initState();
  }

  @override
  void dispose() {
    variable?.webViewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return GestureBuilderBase.get(
      context: context,
      state: widget.state,
      child: WebViewX(
        key: const ValueKey('webviewx'),
        onWebViewCreated: (final controller) {
          variable = variable!.copyWith(
            webViewController: controller,
          );

          _setUrl();
        },
        height: double.maxFinite,
        width: double.maxFinite,
      ),
    );
  }

  void _setUrl() {
    variable?.webViewController?.loadContent(
      widget.url.get(
        widget.state.params,
        widget.state.states,
        widget.state.dataset,
        widget.state.forPlay,
        widget.state.loop,
        context,
      ),
      SourceType.url,
    );
  }
}
