// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
import 'package:teta_widgets/src/elements/features/actions/element.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class SupabaseStorageUploadControl extends StatelessWidget {
  const SupabaseStorageUploadControl({
    required this.prj,
    required this.page,
    required this.node,
    required this.action,
    required this.callback,
    final Key? key,
  }) : super(key: key);

  final ProjectObject prj;
  final PageObject page;
  final CNode node;
  final FActionElement action;
  final Function() callback;

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextControl(
          valueType: VariableType.string,
          node: node,
          value: action.dbFrom ?? FTextTypeInput(),
          page: page,
          title: 'Bucket ID',
          callBack: (final value, final old) {
            action.dbFrom = value;
            callback();
          },
        ),
        TextControl(
          valueType: VariableType.string,
          node: node,
          value: action.valueTextTypeInput ?? FTextTypeInput(),
          page: page,
          title: 'File path',
          callBack: (final value, final old) {
            action.valueTextTypeInput = value;
            callback();
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
          value: page.states
                      .map((final e) => e.name)
                      .where((final element) => element != 'null')
                      .toList()
                      .indexWhere(
                        (final e) => e == action.stateName,
                      ) !=
                  -1
              ? action.stateName
              : null,
          items: page.states
              .where(
                (final element) => element.type == VariableType.file,
              )
              .map((final e) => e.name)
              .where((final element) => element != 'null')
              .toList(),
          onChange: (final newValue) {
            if (newValue != null) {
              final old = action;
              action.stateName = newValue;
              callback();
            }
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
          value: page.states
                      .map((final e) => e.name)
                      .where((final element) => element != 'null')
                      .toList()
                      .indexWhere(
                        (final e) => e == action.stateName2,
                      ) !=
                  -1
              ? action.stateName2
              : null,
          items: page.states
              .where(
                (final element) => element.type == VariableType.string,
              )
              .map((final e) => e.name)
              .where((final element) => element != 'null')
              .toList(),
          onChange: (final newValue) {
            if (newValue != null) {
              final old = action;
              action.stateName2 = newValue;
              callback();
            }
          },
        ),
      ],
    );
  }
}
