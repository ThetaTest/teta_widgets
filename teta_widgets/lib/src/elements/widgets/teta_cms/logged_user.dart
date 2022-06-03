// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:supabase/supabase.dart';
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
  DatasetObject _map = DatasetObject(
    name: 'Teta Auth User',
    map: [<String, dynamic>{}],
  );
  bool isLoaded = true;
  SupabaseClient? client;
  List<DatasetObject> datasets = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<Map<String, dynamic>> load() async {
    final user = await TetaCMS.instance.auth.user.get;
    return <String, dynamic>{
      'isLogged': user.keys.isNotEmpty,
      'uid': user['uid'],
      'name': user['name'],
      'email': user['email'],
      'locale': user['locale'],
      'provider': user['provider'],
    };
  }

  @override
  Widget build(final BuildContext context) {
    return FutureBuilder(
      future: load(),
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

        final map = snapshot.data as Map<String, dynamic>?;
        _map = _map.copyWith(
          name: 'Teta Auth User',
          map: [
            map ??
                <String, dynamic>{
                  'isLogged': false,
                  'uid': null,
                  'name': null,
                  'email': null,
                  'locale': null,
                  'provider': null,
                },
          ],
        );
        datasets = addDataset(context, widget.dataset, _map);
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
    );
  }
}
