// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
// Package imports:
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_core/teta_core.dart';
import 'package:theta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:theta_widgets/src/elements/index.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:theta_models/theta_models.dart';

class WCMSLoggedUser extends StatefulWidget {
  /// Construct
  const WCMSLoggedUser(
    final Key? key, {
    required this.state,
    required this.children,
  }) : super(key: key);

  final TetaWidgetState state;

  /// The optional child of this widget
  final List<CNode> children;

  @override
  _WCMSLoggedUserState createState() => _WCMSLoggedUserState();
}

class _WCMSLoggedUserState extends State<WCMSLoggedUser> {
  DatasetObject _map = const DatasetObject(
    name: 'Teta Auth User',
    map: [<String, dynamic>{}],
  );
  late Future<TetaUser> _future;

  Future<TetaUser> load() async {
    final user = await TetaCMS.instance.auth.user.get;
    if ((context.read<ConfigCubit>().state as ConfigStateLoaded)
            .config
            .revenuecat
            .isEnabled &&
        UniversalPlatform.isAndroid) {
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
      state: widget.state,
      child: FutureBuilder(
        future: _future,
        builder: (final context, final snapshot) {
          if (!snapshot.hasData) {
            if (widget.children.isNotEmpty) {
              return widget.children.last.toWidget(state: widget.state);
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
          final datasets = addDataset(context, _map);
          if (widget.children.isNotEmpty) {
            return widget.children.first.toWidget(
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
      ),
    );
  }
}
