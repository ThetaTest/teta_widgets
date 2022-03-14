// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:supabase/supabase.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WSupabaseLoggedUser extends StatefulWidget {
  /// Construct
  const WSupabaseLoggedUser(
    final Key? key, {
    required this.node,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.child,
    this.loop,
  }) : super(key: key);

  /// The original CNode
  final CNode node;

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
  _WSupabaseLoggedUserState createState() => _WSupabaseLoggedUserState();
}

class _WSupabaseLoggedUserState extends State<WSupabaseLoggedUser> {
  DatasetObject _map = DatasetObject(
    name: 'Supabase User',
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
    final box = await Hive.openBox<dynamic>('social_login');
    final result =
        box.get('key') as Map<String, dynamic>? ?? <String, dynamic>{};
    return result;
  }

  @override
  Widget build(final BuildContext context) {
    client = BlocProvider.of<SupabaseCubit>(context).state;
    if (client == null) {
      return const Center(
        child: CText(
          'Supabase is not initialized yet',
          typography: Headline3(),
        ),
      );
    }
    return FutureBuilder(
      future: load(),
      builder: (final context, final snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }

        final map = snapshot.data as Map<String, dynamic>?;
        if ((map?.keys ?? <String>[]).isNotEmpty) {
          _map = _map.copyWith(
            name: 'Supabase User',
            map: [
              <String, dynamic>{
                'Is Logged': true,
                'Email': map?['email'],
              },
            ],
          );
        } else {
          _map = _map.copyWith(
            name: 'Supabase User',
            map: [
              <String, dynamic>{
                'Is Logged': false,
                'Email': 'null',
              },
            ],
          );
        }
        datasets = addDataset(context, widget.dataset, _map);
        if (widget.child != null) {
          return widget.child!.toWidget(
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
