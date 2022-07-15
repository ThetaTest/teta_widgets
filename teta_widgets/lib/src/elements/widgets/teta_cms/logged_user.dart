// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WCMSLoggedUser extends StatefulWidget {
  /// Construct
  const WCMSLoggedUser(
    final Key? key, {
    required this.node,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    required this.children,
    this.loop,
  }) : super(key: key);

  /// The original CNode
  final CNode node;

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
  _WCMSLoggedUserState createState() => _WCMSLoggedUserState();
}

class _WCMSLoggedUserState extends State<WCMSLoggedUser> {
  bool isInitialized = false;
  DatasetObject _map = DatasetObject(
    name: 'Teta Auth User',
    map: [<String, dynamic>{}],
  );

  @override
  void initState() {
    super.initState();
    load();
  }

  Future load() async {
      final data = await TetaCMS.instance.auth.user.get;
    setState(() {
      _addFetchDataToDataset(data);
      isInitialized = true;
    });
  }

  @override
  Widget build(final BuildContext context) {
    Widget? child;
    if(isInitialized) {
      if (widget.children.isNotEmpty) {
        child = widget.children.first.toWidget(
          params: widget.params,
          states: widget.states,
          dataset: widget.dataset,
          forPlay: widget.forPlay,
        );
      } else {
        child = const SizedBox();
      }
    }

    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: RepaintBoundary(
        child: child,
      ),
    );
  }

  List<DatasetObject> _addFetchDataToDataset(final TetaUser? data) {
    final map = <String, dynamic>{
      'isLogged': data?.isLogged,
      'uid': data?.uid,
      'name': data?.name,
      'email': data?.email,
      'provider': data?.provider,
      'created_at': data?.createdAt,
    };
    _map = _map.copyWith(
      name: 'Teta Auth User',
      map: [map],
    );

    final datasets = addDataset(context, widget.dataset, _map);

    return widget.dataset.isEmpty ? datasets : widget.dataset;
  }
}
