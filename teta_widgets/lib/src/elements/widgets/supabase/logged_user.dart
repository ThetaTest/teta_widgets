// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:supabase/supabase.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:theta_models/theta_models.dart';

// ignore_for_file: public_member_api_docs

class WSupabaseLoggedUser extends StatefulWidget {
  /// Construct
  const WSupabaseLoggedUser(
    final Key? key, {
    required this.state,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;

  /// The optional child of this widget
  final CNode? child;

  @override
  _WSupabaseLoggedUserState createState() => _WSupabaseLoggedUserState();
}

class _WSupabaseLoggedUserState extends State<WSupabaseLoggedUser> {
  DatasetObject _map = const DatasetObject(
    name: 'Supabase User',
    map: [<String, dynamic>{}],
  );
  bool isLoaded = true;
  SupabaseClient? client;
  List<DatasetObject> datasets = [];
  late final Future<Map<String, dynamic>> _future;

  @override
  void initState() {
    super.initState();
    _future = load();
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
        child: THeadline3(
          'Supabase is not initialized yet',
        ),
      );
    }
    return FutureBuilder<Map<String, dynamic>>(
      future: _future,
      builder: (final context, final snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }

        final map = snapshot.data;
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
        datasets = addDataset(context, _map);
        if (widget.child != null) {
          return widget.child!.toWidget(
            state: widget.state.copyWith(
              dataset: widget.state.dataset.isEmpty
                  ? datasets
                  : widget.state.dataset,
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
