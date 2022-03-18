// Flutter imports:
// Package imports:
// ignore_for_file: iterable_contains_unrelated_type

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WFirebaseFutureBuilder extends StatefulWidget {
  /// Construct
  const WFirebaseFutureBuilder(
    final Key? key, {
    required this.node,
    required this.path,
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
  WFirebaseFutureBuilderState createState() => WFirebaseFutureBuilderState();
}

class WFirebaseFutureBuilderState extends State<WFirebaseFutureBuilder> {
  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: const Center(
        child: THeadline3(
          'Firebase is not initialized yet',
        ),
      ),
    );
  }

  /*Widget body(final BuildContext context) {
    FutureBuilder(
        future: widget.path.values!.length.isEven
            ? FirebaseFirestore.instanceFor(
                app: Firebase.app(prj.prj.name),
              ).doc(finalPath != '' ? finalPath : ' ').get()
            : FirebaseFirestore.instanceFor(
                app: Firebase.app(prj.prj.name),
              ).collection(finalPath != '' ? finalPath : ' ').get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (widget.path.values!.length.isEven) {
              final doc = snapshot.data! as DocumentSnapshot;
              _map = _map.copyWith(
                  name: 'Query $finalPath',
                  map: [doc.data()! as Map<String, dynamic>]);
              final list = addDataset(context, widget.dataset, _map);

              // Returns child
              return ChildConditionBuilder(
                  name: widget.node.intrinsicState.displayName,
                  child: widget.child,
                  params: widget.params,
                  states: widget.states,
                  dataset: list,
                  forPlay: widget.forPlay,
                  loop: widget.loop);
            } else {
              final coll = snapshot.data! as QuerySnapshot;
              _map = _map.copyWith(
                  name: 'Query $finalPath',
                  map: coll.docs
                      .map((e) => e.data()! as Map<String, dynamic>)
                      .toList());
              final list = addDataset(context, widget.dataset, _map);

              // Returns child
              return ChildConditionBuilder(
                  name: widget.node.intrinsicState.displayName,
                  child: widget.child,
                  params: widget.params,
                  states: widget.states,
                  dataset: list,
                  forPlay: widget.forPlay,
                  loop: widget.loop);
            }
          }
          return const CircularProgressIndicator();
        });
  }*/
}
