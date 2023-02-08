// ignore_for_file: avoid_dynamic_calls

// Flutter imports:
import 'dart:async';
import 'dart:convert';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WCustomHttpRequest extends StatefulWidget {
  /// Construct

  const WCustomHttpRequest(
    final Key? key, {
    required this.state,
    required this.url,
    required this.children,
    this.addParams,
    this.addHeaders,
  }) : super(key: key);

  final TetaWidgetState state;
  final List<CNode> children;
  final FTextTypeInput url;
  final List<MapElement>? addParams;
  final List<MapElement>? addHeaders;

  @override
  State<WCustomHttpRequest> createState() => _WCustomHttpRequestState();
}

class _WCustomHttpRequestState extends State<WCustomHttpRequest>
    with AfterLayoutMixin {
  bool isInitialized = false;
  List<dynamic> list = <dynamic>[];
  DatasetObject _map = const DatasetObject(
    name: 'Custom HTTP Request URL',
    map: [<String, dynamic>{}],
  );

  @override
  FutureOr<void> afterFirstLayout(final BuildContext context) {
    getDataFromURL();
  }

  Future<void> getDataFromURL() async {
    final url = widget.url.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    try {
      var newURL = url;
      for (var i = 0; i < widget.addParams!.length; i++) {
        if (i == 0) {
          newURL =
              '$url?${widget.addParams![i].key.toString()}=${widget.addParams![i].value.value.toString()}';
        } else {
          newURL =
              '$newURL&${widget.addParams![i].key.toString()}=${widget.addParams![i].value.value.toString()}';
        }
      }
      // print("new URL : " + newURL);

      final headers = {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers':
            'Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale',
        'Access-Control-Allow-Methods': 'POST, OPTIONS'
      };

      for (var i = 0; i < widget.addHeaders!.length; i++) {
        headers[widget.addHeaders![i].key.toString()] =
            widget.addHeaders![i].value.value.toString();
      }

      final response = await http.get(Uri.parse(newURL), headers: headers);

      final json = response.body;

      final dynamic resp = jsonDecode(json);
      if (resp is List) {
        final data = resp;
        if (mounted) {
          setState(() {
            list = data;
            isInitialized = true;
          });
        }
      } else {
        final data = <dynamic>[];
        data.add(resp);
        if (mounted) {
          setState(() {
            list = data;
            isInitialized = true;
          });
        }
      }
    } catch (e) {
      print('error: ${e.toString()}');
    }
  }

  @override
  Widget build(final BuildContext context) {
    final datasets = _addFetchDataToDataset(list);

    if (list.isEmpty) {
      if (widget.children.length > 1) {
        return RepaintBoundary(
          child: widget.children.last.toWidget(
            state: widget.state.copyWith(dataset: datasets),
          ),
        );
      } else {
        return const THeadline3(
          'Custom Http Request returned an empty list. Add children to customize this message,',
          isCentered: true,
        );
      }
    }
    return NodeSelectionBuilder(
      state: widget.state,
      child: widget.children.isEmpty
          ? const THeadline3('Custom Http Request requires at least one child')
          : RepaintBoundary(
              child: widget.children.first.toWidget(
                state: widget.state.copyWith(dataset: datasets),
              ),
            ),
    );
  }

  List<DatasetObject> _addFetchDataToDataset(final List<dynamic>? list) {
    _map = _map.copyWith(
      name: widget.state.node.name ??
          widget.state.node.intrinsicState.displayName,
      map: (list ?? const <dynamic>[])
          .map((final dynamic e) => e as Map<String, dynamic>)
          .toList(),
    );

    final datasets = addDataset(context, widget.state.dataset, _map);

    return widget.state.dataset.isEmpty ? datasets : widget.state.dataset;
  }
}
