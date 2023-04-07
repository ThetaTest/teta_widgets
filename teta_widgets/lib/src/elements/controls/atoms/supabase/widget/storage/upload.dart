import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../../actions/supabase/storage_upload/action.dart';
import '../../../../../actions/supabase/storage_upload/params.dart';
import '../../../../../features/text_type_input.dart';
import '../../../../atoms/text.dart';

class SupabaseStorageUploadControl extends StatefulWidget {
  const SupabaseStorageUploadControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TASupabaseStorageUpload action;
  final Function(TASupabaseStorageUploadParams params) onParamsChanged;

  @override
  State<SupabaseStorageUploadControl> createState() =>
      SupabaseStorageUploadControlState();
}

class SupabaseStorageUploadControlState
    extends State<SupabaseStorageUploadControl> {
  FTextTypeInput? pathFile;
  FTextTypeInput? supabaseFrom;
  String? stateName;
  String? stateName2;

  void updateParams() {
    setState(() {
      widget.onParamsChanged(
        TASupabaseStorageUploadParams(
          pathFile: pathFile,
          supabaseFrom: supabaseFrom,
          stateName: stateName,
          stateName2: stateName2,
        ),
      );
    });
  }

  @override
  Widget build(final BuildContext context) {
    final pageLoaded = context.read<PageCubit>().state as PageLoaded;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextControl(
          valueType: VariableType.string,
          value: widget.action.params.supabaseFrom ?? FTextTypeInput(),
          title: 'Bucket ID',
          callBack: (final value, final old) {
            supabaseFrom = value;
            updateParams();
          },
        ),
        TextControl(
          valueType: VariableType.string,
          value: widget.action.params.pathFile ?? FTextTypeInput(),
          title: 'File path',
          callBack: (final value, final old) {
            pathFile = value;
            updateParams();
          },
        ),
        const Gap(Grid.medium),
        const TParagraph('File state'),
        const TDetailLabel(
          'Choose the state from which you want to obtain the file.',
        ),
        const TDetailLabel(
          'Type: File.',
        ),
        const Gap(Grid.small),
        CDropdown(
          value: pageLoaded.states
                      .map((final e) => e.name)
                      .where((final element) => element != 'null')
                      .toList()
                      .indexWhere(
                        (final e) => e == widget.action.params.stateName,
                      ) !=
                  -1
              ? widget.action.params.stateName
              : null,
          items: pageLoaded.states
              .where(
                (final element) => element.type == VariableType.file,
              )
              .map((final e) => e.name)
              .where((final element) => element != 'null')
              .toList(),
          onChange: (final newValue) {
            if (newValue == null) return;
            stateName = newValue;
            updateParams();
          },
        ),
        const Gap(Grid.medium),
        const TParagraph('Public URL'),
        const TDetailLabel(
          'Choose the state where you want to save the public url retrieved from the uploaded file.',
        ),
        const TDetailLabel(
          'Type: String.',
        ),
        const Gap(Grid.small),
        CDropdown(
          value: pageLoaded.states
                      .map((final e) => e.name)
                      .where((final element) => element != 'null')
                      .toList()
                      .indexWhere(
                        (final e) => e == widget.action.params.stateName2,
                      ) !=
                  -1
              ? widget.action.params.stateName2
              : null,
          items: pageLoaded.states
              .where(
                (final element) => element.type == VariableType.string,
              )
              .map((final e) => e.name)
              .where((final element) => element != 'null')
              .toList(),
          onChange: (final newValue) {
            if (newValue == null) return;
            stateName2 = newValue;
            updateParams();
          },
        ),
      ],
    );
  }
}
