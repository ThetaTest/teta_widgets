// ignore_for_file: avoid_dynamic_calls

// Flutter imports:
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_cms/teta_cms.dart';

// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WCustomHttpRequest extends StatefulWidget {
  /// Construct

  const WCustomHttpRequest(
    final Key? key, {
    required this.node,
    required this.url,
    this.addParams,
    this.addHeaders,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    required this.children,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final List<CNode> children;
  final bool forPlay;
  final int? loop;
  final FTextTypeInput url;
  final List<MapElement>? addParams;
  final List<MapElement>? addHeaders;
  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  State<WCustomHttpRequest> createState() => _WCustomHttpRequestState();
}

class _WCustomHttpRequestState extends State<WCustomHttpRequest> {
  bool isInitialized = false;
  List<dynamic> list = <dynamic>[];
  DatasetObject _map = DatasetObject(
    name: 'Custom HTTP Request URL',
    map: [<String, dynamic>{}],
  );

  Future<void> getDataFromURL() async {
    final url = widget.url.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
      context,
    );
    try {
      var newURL = url;
      for (var i = 0; i < widget.addParams!.length; i++) {
        if (i == 0) {
          newURL = url +
              "?${widget.addParams![i].key.toString()}=${widget.addParams![i].value.value.toString()}";
        } else {
          newURL = newURL +
              "&${widget.addParams![i].key.toString()}=${widget.addParams![i].value.value.toString()}";
        }
      }
      // print("new URL : " + newURL);

      var headers = {
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
      final data = jsonDecode(json) as List<dynamic>;

      if (mounted) {
        setState(() {
          list = data;
          isInitialized = true;
        });
      }
    } catch (e) {
      print("error:" + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getDataFromURL();
  }

  @override
  Widget build(BuildContext context) {
    final datasets = _addFetchDataToDataset(list);

    if (list.isEmpty) {
      if (widget.children.length > 1) {
        return RepaintBoundary(
          child: widget.children.last.toWidget(
            params: widget.params,
            states: widget.states,
            dataset: datasets,
            forPlay: widget.forPlay,
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
      node: widget.node,
      forPlay: widget.forPlay,
      child: widget.children.isEmpty
          ? const THeadline3('Custom Http Request requires at least one child')
          : RepaintBoundary(
              child: widget.children.first.toWidget(
                params: widget.params,
                states: widget.states,
                dataset: datasets,
                forPlay: widget.forPlay,
              ),
            ),
    );
  }

  List<DatasetObject> _addFetchDataToDataset(final List<dynamic>? list) {
    _map = _map.copyWith(
      name: widget.node.name ?? widget.node.intrinsicState.displayName,
      map: (list ?? const <dynamic>[])
          .map((final dynamic e) => e as Map<String, dynamic>)
          .toList(),
    );

    final datasets = addDataset(context, widget.dataset, _map);

    return widget.dataset.isEmpty ? datasets : widget.dataset;
  }
}
