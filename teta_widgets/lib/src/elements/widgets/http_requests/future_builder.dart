// Flutter imports:

// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:http/http.dart' as http;
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:theta_models/theta_models.dart';

// ignore_for_file: public_member_api_docs

class WHTTPRequestFutureBuilder extends StatefulWidget {
  /// Construct
  const WHTTPRequestFutureBuilder(
    final Key? key, {
    required this.state,
    required this.from,
    required this.children,
  }) : super(key: key);

  final TetaWidgetState state;

  /// The from's value
  final FTextTypeInput from;

  /// The opzional child of this widget
  final List<CNode> children;

  @override
  _WHTTPRequestFutureBuilderState createState() =>
      _WHTTPRequestFutureBuilderState();
}

class _WHTTPRequestFutureBuilderState extends State<WHTTPRequestFutureBuilder>
    with AfterLayoutMixin {
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
  FutureOr<void> afterFirstLayout(final BuildContext context) {
    calc();
  }

  Future calc() async {
    final from = widget.from.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );

    _future = posts(from);
  }

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      state: widget.state,
      child: FutureBuilder(
        future: _future,
        builder: (final context, final snapshot) {
          if (!snapshot.hasData) {
            if (widget.children.isNotEmpty) {
              return widget.children.last.toWidget(
                state: widget.state,
              );
            } else {
              return const CircularProgressIndicator();
            }
          }
          final dataset = snapshot.data as DatasetObject?;
          var datasets = <DatasetObject>[];
          if (dataset != null) {
            datasets = addDataset(context, dataset);
          }

          // Returns child
          if (widget.children.isNotEmpty) {
            return widget.children.first.toWidget(
              state: widget.state.copyWith(
                dataset: widget.state.dataset.isEmpty
                    ? datasets
                    : widget.state.dataset,
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Future<DatasetObject?> posts(final String url) async {
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

  Future postsFromJson(final List<dynamic> json) async {
    for (final element in json) {
      final keys = element as Map;
      getValues('', data, keys, 0, loop);
      loop++;
    }
    loaded = true;
  }

  void getValues(
    final String prefix,
    final TreeObject parent,
    final Map<dynamic, dynamic> map,
    final double level,
    final int loop,
  ) {
    map.forEach((final dynamic key, final dynamic value) {
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
