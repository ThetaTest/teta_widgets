// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:theta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:theta_widgets/src/elements/index.dart';

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
    required this.state,
    required this.path,
    required this.orderBy,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;

  /// The path of firestore db
  final FFirestorePath path;

  /// The filter orderBy, to customize firestore queries
  final FTextTypeInput orderBy;

  /// The opzional child of this widget
  final CNode? child;

  @override
  WFirestorePaginationState createState() => WFirestorePaginationState();
}

class WFirestorePaginationState extends State<WFirestorePagination> {
  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      state: widget.state,
      child: const SizedBox(),
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
