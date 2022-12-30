// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

/// Key to identify the dataset generated by this node.
const key = 'Firebase Is Logged';

/// Key to identify the main property of dataset.
/// It will be bool.
const keyAttr = 'value';

class WFirebaseIsAuthenticatedBuilder extends StatefulWidget {
  /// Constructor
  const WFirebaseIsAuthenticatedBuilder(
    final Key? key, {
    required this.state,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;

  /// The opzional child of this widget
  final CNode? child;

  @override
  WFirebaseIsAuthenticatedBuilderState createState() =>
      WFirebaseIsAuthenticatedBuilderState();
}

class WFirebaseIsAuthenticatedBuilderState
    extends State<WFirebaseIsAuthenticatedBuilder> {
  DatasetObject _map = DatasetObject(
    name: key,
    map: [
      <String, dynamic>{keyAttr: false}
    ],
  );

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      state: widget.state,
      child: BlocBuilder<FirebaseCubit, bool>(
        builder: (final context, final state) => state
            ? FutureBuilder(
                future: isUserLogged(),
                builder: (final context, final snapshot) {
                  if (snapshot.hasData) {
                    _map = _map.copyWith(
                      map: [
                        <String, dynamic>{keyAttr: snapshot.data}
                      ],
                    );

                    final list =
                        addDataset(context, widget.state.dataset, _map);
                    ChildConditionBuilder(
                      ValueKey('${widget.state.node.nid} ${widget.state.loop}'),
                      state: widget.state.copyWith(
                        dataset: list,
                      ),
                      child: widget.child,
                    );
                  }
                  return const CircularProgressIndicator();
                },
              )
            : ChildConditionBuilder(
                ValueKey('${widget.state.node.nid} ${widget.state.loop}'),
                state: widget.state,
                child: widget.child,
              ),
      ),
    );
  }

  Future<bool> isUserLogged() async {
    /*final prj =
        BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded;
    if (FirebaseAuth.instanceFor(
          app: Firebase.app(prj.prj.name),
        ).currentUser?.uid ==
        null) {
      return false;
    } else {
      return true;
    }*/
    return false;
  }
}
