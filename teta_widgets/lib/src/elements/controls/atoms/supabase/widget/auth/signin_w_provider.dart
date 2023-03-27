import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_repositories/teta_repositories.dart';
import 'package:teta_widgets/src/elements/actions/supabase/signin_w_provider/action.dart';
import 'package:teta_widgets/src/elements/actions/supabase/signin_w_provider/params.dart';
import 'package:uuid/uuid.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../../../../teta_widgets.dart';
import '../../../destination_page_selector.dart';

class SupabaseSignInWProviderControl extends StatefulWidget {
  const SupabaseSignInWProviderControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TASupabaseSignInWithProvider action;
  final Function(TASupabaseSignInWithProviderParams params) onParamsChanged;

  @override
  State<SupabaseSignInWProviderControl> createState() =>
      SupabaseSignInWProviderControlState();
}

class SupabaseSignInWProviderControlState
    extends State<SupabaseSignInWProviderControl> {
  Provider provider = Provider.google;
  String? pageToOpen;
  Map<String, dynamic>? paramsToSend;

  @override
  void initState() {
    super.initState();
    pageToOpen = widget.action.params.nameOfPage;
    paramsToSend = widget.action.params.paramsToSend;
  }

  void updateParams() {
    widget.onParamsChanged(
      TASupabaseSignInWithProviderParams(
        provider: provider,
        nameOfPage: pageToOpen,
        paramsToSend: paramsToSend,
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const TParagraph('OAuth Provider'),
        const SizedBox(height: 8),
        CDropdown(
          value: provider.name(),
          items: Provider.values.map((final e) => e.name()).toList(),
          onChange: (final provider) {
            this.provider = Provider.values.firstWhere(
              (final e) => e.name() == provider,
            );
            updateParams();
          },
        ),
        const Gap(Grid.medium),
        DestinationPageSelector(
          pageToOpen: pageToOpen,
          paramsToSend: paramsToSend,
          onParamsChanged: (final pageToOpen, final paramsToSend) {
            this.pageToOpen = pageToOpen;
            this.paramsToSend = paramsToSend;
            updateParams();
          },
        ),
      ],
    );
  }
}
