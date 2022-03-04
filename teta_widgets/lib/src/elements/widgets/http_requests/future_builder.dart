// Flutter imports:
// Package imports:
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WHTTPRequestFutureBuilder extends StatefulWidget {
  /// Construct
  const WHTTPRequestFutureBuilder(
    Key? key, {
    required this.node,
    required this.from,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    required this.children,
    this.loop,
  }) : super(key: key);

  /// The original CNode
  final CNode node;

  /// The from's value
  final FTextTypeInput from;

  /// The opzional child of this widget
  final List<CNode> children;

  /// Are we in Play Mode?
  final bool forPlay;

  /// The optional position inside a loop
  /// Widgets can be instantiate inside ListView.builder and other list widgets
  /// [loop] indicates the index position inside them
  final int? loop;

  /// The params of Scaffold
  final List<VariableObject> params;

  /// The states of Scaffold
  final List<VariableObject> states;

  /// The dataset list created by other widgets inside the same page
  final List<DatasetObject> dataset;

  @override
  _WHTTPRequestFutureBuilderState createState() =>
      _WHTTPRequestFutureBuilderState();
}

class _WHTTPRequestFutureBuilderState extends State<WHTTPRequestFutureBuilder> {
  bool isLoaded = true;
  Future<DatasetObject?>? _future;
  String? responseJson;
  TreeObject data = TreeObject(
    id: -1,
    name: 'global_list',
    value: '',
    level: 0,
    loop: -1,
  );
  List<TreeObject> jsonMap = [];
  int loop = 0;
  bool loaded = false;
  int idIndex = 0;

  @override
  void initState() {
    super.initState();
    calc();
  }

  Future calc() async {
    final from = widget.from.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
    );

    _future = posts(from);
  }

  @override
  Widget build(BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            if (widget.children.isNotEmpty) {
              return widget.children.last.toWidget(
                params: widget.params,
                states: widget.states,
                dataset: widget.dataset,
                forPlay: widget.forPlay,
              );
            } else {
              return const CircularProgressIndicator();
            }
          }
          final dataset = snapshot.data as DatasetObject?;
          var datasets = <DatasetObject>[];
          if (dataset != null) {
            datasets = addDataset(context, widget.dataset, dataset);
          }

          // Returns child
          if (widget.children.isNotEmpty) {
            return widget.children.first.toWidget(
              params: widget.params,
              states: widget.states,
              dataset: widget.dataset.isEmpty ? datasets : widget.dataset,
              forPlay: widget.forPlay,
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Future<DatasetObject?> posts(String url) async {
    final response = await http.get(Uri.parse(url));
    final json = jsonDecode(response.body) as List<dynamic>;
    jsonMap = [];
    data = TreeObject(
      id: -1,
      name: 'global_list',
      value: '',
      level: 0,
      loop: -1,
    );
    loop = 0;
    for (final element in json) {
      final keys = element as Map;
      getValues('', data, keys, 0, loop);
      loop++;
    }
    loaded = true;

    final list = <Map<String, dynamic>>[];
    var map = <String, dynamic>{};
    for (final element in jsonMap) {
      if (map[element.name] != null) {
        list.add(map);
        map = <String, dynamic>{};
      } else {
        map[element.name] = element.value;
      }
    }
    if (list.isEmpty && map.keys.isNotEmpty) {
      list.add(map);
    }

    return DatasetObject(
      name: 'HTTP Request',
      map: list,
    );
  }

  Future postsFromJson(List<dynamic> json) async {
    for (final element in json) {
      final keys = element as Map;
      getValues('', data, keys, 0, loop);
      loop++;
    }
    loaded = true;
  }

  void getValues(
    String prefix,
    TreeObject parent,
    Map<dynamic, dynamic> map,
    double level,
    int loop,
  ) {
    map.forEach((dynamic key, dynamic value) {
      try {
        if (value is String ||
            value is int ||
            value is double ||
            value is bool) {
          parent.children.add(
            TreeObject(
              id: idIndex,
              name: '$prefix$key',
              value: '$value',
              level: level,
              loop: loop,
            ),
          );
          jsonMap.add(
            TreeObject(
              id: idIndex,
              name: '$prefix$key',
              value: '$value',
              level: level,
              loop: loop,
            ),
          );
          idIndex++;
        } else if (value is List) {
          for (final element in value) {
            final node = TreeObject(
              id: idIndex,
              name: '$key',
              value: '',
              level: level,
              loop: loop,
            );
            parent.children.add(node);
            jsonMap.add(
              TreeObject(
                id: idIndex,
                name: '$key',
                value: '',
                level: level,
                loop: loop,
              ),
            );
            idIndex++;
            final keys = element as Map;
            getValues('$key/', node, keys, level + 1, loop);
          }
        } else {
          final node = TreeObject(
            id: idIndex,
            name: '$key',
            value: '',
            level: level,
            loop: loop,
          );
          parent.children.add(node);
          jsonMap.add(
            TreeObject(
              id: idIndex,
              name: '$key',
              value: '',
              level: level,
              loop: loop,
            ),
          );
          idIndex++;
          final keys = value as Map;
          getValues('$key/', parent, keys, level + 1, loop);
        }
      } catch (_) {}
    });
  }
}
