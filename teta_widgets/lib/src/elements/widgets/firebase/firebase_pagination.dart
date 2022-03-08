// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

//import 'package:paginate_firestore/paginate_firestore.dart';

// ignore_for_file: public_member_api_docs

class WFirestorePagination extends StatefulWidget {
  /// Makes a infinite list of Firestore data.
  ///
  /// Can be used for static lists (called 1 time) or real time lists.
  ///
  /// Requires a path to connect to the right collection / doc
  /// and a orderBy filter to correctly sort the results.
  const WFirestorePagination(
    final Key? key, {
    required this.node,
    required this.path,
    required this.orderBy,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.child,
    this.loop,
  }) : super(key: key);

  /// The original CNode
  final CNode node;

  /// The path of firestore db
  final FFirestorePath path;

  /// The filter orderBy, to customize firestore queries
  final FTextTypeInput orderBy;

  /// The opzional child of this widget
  final CNode? child;

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
  WFirestorePaginationState createState() => WFirestorePaginationState();
}

class WFirestorePaginationState extends State<WFirestorePagination> {
  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: body(context),
    );
  }

  Widget body(final BuildContext context) {
    return const SizedBox(); /*PaginateFirestore(
      itemBuilder: (index, context, documentSnapshot) {
        final data = documentSnapshot.data() as Map<String, dynamic>?;
        data?['id'] = documentSnapshot.id;
        final tempMap = <Map<String, dynamic>>[];
        if (_map.getMap.indexWhere((e) => e['id'] == documentSnapshot.id) ==
            -1) {
          tempMap.add(data!);
        }
        _map = _map.copyWith(map: tempMap);
        final list = addDataset(context, widget.dataset, _map);
        return ChildConditionBuilder(
            name: widget.node.intrinsicState.displayName,
            child: widget.child,
            params: widget.params,
            states: widget.states,
            dataset: list,
            forPlay: widget.forPlay,
            loop: widget.loop);
      },
      query: FirebaseFirestore.instanceFor(
        app: Firebase.app(prj.prj.name),
      ).collection(finalPath != '' ? finalPath : ' ').orderBy(widget.orderBy
          .get(widget.params, widget.states, widget.dataset, widget.forPlay,
              widget.loop)),
      itemBuilderType: PaginateBuilderType.gridView,
      isLive: true,
      itemsPerPage: 10,
      shrinkWrap: true,
    );*/
  }
}
