import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final pageState = context.read<PageCubit>().state as PageLoaded;
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
        DestinationPageSelector(
          pageToOpen: pageToOpen,
          paramsToSend: paramsToSend,
          onParamsChanged: (final pageToOpen, final paramsToSend) {
            this.pageToOpen = pageToOpen;
            this.paramsToSend = paramsToSend;
            updateParams();
          },
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFFFBF2F)),
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.hardEdge,
          child: Wrap(
            children: [
              const Icon(
                Icons.warning,
                color: Color(0xFFFFBF2F),
                size: 24,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 12),
                child: TParagraph(
                  "This action needs the following state variables: 'Email', 'Password', 'Status'",
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: TParagraph(
                  'The names of the variables are not case sensitive',
                ),
              ),
              if (kDebugMode)
                TextButton(
                  onPressed: () {
                    var flag = false;
                    if (pageState.page.defaultStates.indexWhere(
                          (final element) =>
                              element.name.toLowerCase() == 'email',
                        ) ==
                        -1) {
                      pageState.page.defaultStates.add(
                        VariableObject(
                          id: const Uuid().v1(),
                          type: VariableType.string,
                          name: 'Email',
                          defaultValue: '0',
                        ),
                      );
                      flag = true;
                    }
                    if (pageState.page.defaultStates.indexWhere(
                          (final element) =>
                              element.name.toLowerCase() == 'password',
                        ) ==
                        -1) {
                      pageState.page.defaultStates.add(
                        VariableObject(
                          id: const Uuid().v1(),
                          type: VariableType.string,
                          name: 'Password',
                          defaultValue: '0',
                        ),
                      );
                      flag = true;
                    }
                    if (pageState.page.defaultStates.indexWhere(
                          (final element) =>
                              element.name.toLowerCase() == 'status',
                        ) ==
                        -1) {
                      pageState.page.defaultStates.add(
                        VariableObject(
                          id: const Uuid().v1(),
                          type: VariableType.string,
                          name: 'Status',
                          defaultValue: '0',
                        ),
                      );
                      flag = true;
                    }

                    if (flag) {
                      sl.get<NodeRepository>().changeNode(
                            node: pageState.page.scaffold as NDynamic,
                          );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: TActionLabel(
                        'Generate',
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
