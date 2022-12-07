// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WFirebaseStreamBuilder extends StatefulWidget {
  /// Returns a real time query from Firestore
  /// Needs a [FFirestorePath] to connect to the coll / doc
  const WFirebaseStreamBuilder(
    final Key? key, {
    required this.state,
    required this.path,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FFirestorePath path;

  @override
  WFirebaseStreamBuilderState createState() => WFirebaseStreamBuilderState();
}

class WFirebaseStreamBuilderState extends State<WFirebaseStreamBuilder> {
  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.state.node,
      forPlay: widget.state.forPlay,
      child: const SizedBox(),
    );
  }

  Widget body(final BuildContext context) {
    return const SizedBox();

    /*StreamBuilder(
      stream: widget.path.values!.length.isEven
          ? FirebaseFirestore.instanceFor(
              app: Firebase.app(prj.prj.name),
            ).doc(finalPath != '' ? finalPath : ' ').snapshots()
          : FirebaseFirestore.instanceFor(
              app: Firebase.app(prj.prj.name),
            ).collection(finalPath != '' ? finalPath : ' ').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (widget.path.values!.length.isEven) {
            final doc = snapshot.data as DocumentSnapshot?;
            final list = <DatasetObject>[];
            if (doc != null) {
              _map = _map.copyWith(
                  name: 'Stream $finalPath',
                  map: [doc.data()! as Map<String, dynamic>]);
              list.addAll(addDataset(context, widget.dataset, _map));
            }

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
            final coll = snapshot.data as QuerySnapshot?;
            final list = <DatasetObject>[];
            if (coll != null) {
              _map = _map.copyWith(
                  name: 'Stream $finalPath',
                  map: coll.docs
                      .map((e) => e.data()! as Map<String, dynamic>)
                      .toList());
              list.addAll(addDataset(context, widget.dataset, _map));
            }

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
      },
    );*/
  }
}
