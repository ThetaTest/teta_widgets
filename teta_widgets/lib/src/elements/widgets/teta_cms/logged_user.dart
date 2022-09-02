// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
// Package imports:
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

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
  DatasetObject _map = DatasetObject(
    name: 'Teta Auth User',
    map: [<String, dynamic>{}],
  );
  late Future<TetaUser> _future;

  Future<TetaUser> load() async {
    final user = await TetaCMS.instance.auth.user.get;
    if ((BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded)
            .prj
            .config
            ?.isRevenueCatEnabled ??
        false) {
      await Purchases.logIn(user.uid!);
    }
    return user;
  }

  @override
  void initState() {
    _future = load();
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: FutureBuilder(
        future: _future,
        builder: (final context, final snapshot) {
          if (!snapshot.hasData) {
            if (widget.children.isNotEmpty) {
              return widget.children.last.toWidget(
                params: widget.params,
                states: widget.states,
                dataset: widget.dataset,
                forPlay: widget.forPlay,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }

          final data = snapshot.data as TetaUser?;
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
}
