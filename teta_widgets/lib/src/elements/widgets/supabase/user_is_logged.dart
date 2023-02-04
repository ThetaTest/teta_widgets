// Flutter imports:
// Package imports:
// ignore_for_file: avoid_dynamic_calls

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase/supabase.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WSupabaseUserIsLogged extends StatefulWidget {
  /// Construct
  const WSupabaseUserIsLogged(
    final Key? key, {
    required this.state,
    required this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  /// The opzional child of this widget
  final CNode? child;

  @override
  _WSupabaseUserIsLoggedState createState() => _WSupabaseUserIsLoggedState();
}

class _WSupabaseUserIsLoggedState extends State<WSupabaseUserIsLogged> {
  bool isLoaded = true;
  Future<Map<String, dynamic>>? _future;
  SupabaseClient? client;

  @override
  void initState() {
    super.initState();
    client = BlocProvider.of<SupabaseCubit>(context).state;
    _future = getUserMap();
  }

  Future<Map<String, dynamic>> getUserMap() async {
    final user = client!.auth.currentUser;
    if (user == null) {
      return <String, dynamic>{};
    }
    return user.toJson();
  }

  @override
  Widget build(final BuildContext context) {
    if (client == null) {
      return const Center(
        child: THeadline3(
          'Supabase is not initialized yet',
        ),
      );
    }

    return NodeSelectionBuilder(
      state: widget.state,
      child: FutureBuilder<Map<String, dynamic>>(
        future: _future,
        builder: (final context, final snapshot) {
         if (snapshot.data == null) {
           if (widget.child != null) {
              return widget.child!.toWidget(state: widget.state);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
         }

         final data = snapshot.data!;
         final datasets = addDataset(context, widget.state.dataset, 
          DatasetObject(name: 'Supabase Auth User', map: [data]),);
          return widget.child!.toWidget(
              state: widget.state.copyWith(
                dataset: widget.state.dataset.isEmpty
                    ? datasets
                    : widget.state.dataset,
              ),
            );
        },
      ),
    );
  }
}
