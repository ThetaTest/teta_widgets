// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/controls/atoms/border_radius.dart';
import 'package:teta_widgets/src/elements/controls/atoms/dropdownControl.dart';
import 'package:teta_widgets/src/elements/controls/atoms/fill.dart';
import 'package:teta_widgets/src/elements/controls/atoms/flag.dart';
import 'package:teta_widgets/src/elements/controls/atoms/icon_feather.dart';
import 'package:teta_widgets/src/elements/controls/atoms/margins.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text_styles.dart';
import 'package:teta_widgets/src/elements/controls/prefabs/text_prefab_control.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class AlertSnackbarControl extends StatelessWidget {
  const AlertSnackbarControl({
    required this.action,
    required this.callback,
    final Key? key,
  }) : super(key: key);

  final FActionElement action;
  final Function() callback;

  @override
  Widget build(final BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(Grid.small),
            FlagControl(
              key: ValueKey('AddTitleSnackbar'),
              title: 'Add title',
              keyValue: 'sAddTitle',
              value: action.addTitle ?? false,
              callBack: (final flag, final old) {
                action.addTitle = flag;
                callback();
              },
            ),
            if (action.addTitle ?? false) const Gap(Grid.medium),
            if (action.addTitle ?? false)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextControl(
                  valueType: VariableType.string,
                  value: action.snackbarTitle as FTextTypeInput,
                  title: 'Title',
                  callBack: (final value, final old) {
                    action.snackbarTitle = value;
                    callback();
                  },
                ),
              ),
            if (action.addTitle ?? false) const Gap(Grid.small),
            if (action.addTitle ?? false)
              TextPrefabControl(
                title: 'Title Style',
                key: ValueKey('TitleSnackbar'),
                textStyle: action.textStyle as FTextStyle,
                keyValue: 'sTxtStl', //textStyle key
              ),
            const Gap(Grid.small),
            TextControl(
              valueType: VariableType.string,
              value: action.snackbarMessage as FTextTypeInput,
              title: 'Message',
              callBack: (final value, final old) {
                action.snackbarMessage = value;
                callback();
              },
            ),
            const Gap(Grid.small),
            TextPrefabControl(
              title: 'Message Style',
              key: ValueKey('Message'),
              textStyle: action.textStyle2 as FTextStyle,
              keyValue: 'sTxtStl2', //textStyle2 key
            ),
            const Gap(Grid.small),
            THeadline3('Snackbar Properties'),
            const Gap(Grid.small),
            ControlBuilder.genericControlBuilder(
              context: context,
              control: ControlObject(
                title: 'Duration',
                type: ControlType.value,
                key: 'sDuration',
                value: action.duration as FTextTypeInput,
                description:
                    'Milliseconds value. Only integers are accepted. E.g. 1000 (= 1s), 2000 (= 2s) etc.',
                valueType: VariableType.int,
              ),
            ),
            const Gap(Grid.small),
            ControlBuilder.sizeControlBuilder(
              context: context,
              control: SizeControlObject(
                title: 'MaxWidth',
                type: ControlType.size,
                key: 'sWidth',
                isWidth: true,
                value: action.width as FSize,
              ),
            ),
            const Gap(Grid.small),
            Margins(
              key: ValueKey('MarginsSnackbar'),
              title: 'Margins',
              value: action.margin as FMargins,
              callBack: (final value, final old) {
                action.margin = FMargins.fromJson(value);
              },
            ),
            BorderRadiusControl(
              key: ValueKey('BorderRadiusSnackbar'),
              borderRadius: action.borderRadius as FBorderRadius,
              callBack: (final value, final old) {
                action.borderRadius = FBorderRadius.fromJson(value);
                callback();
              },
            ),
            const Gap(Grid.small),
            const Gap(Grid.small),
            FillControl(
              title: 'Background Color',
              key: ValueKey('BackgroundColorSnackbar'),
              isImageEnabled: false,
              isNoneEnabled: false,
              type: FillTypeControlType.onlySolid,
              fill: action.fill2 as FFill,
              callBack: (final value, final styled, final old) {
                action.fill2 = value;
                callback();
              },
            ),
            const Gap(Grid.small),
            DropdownControl(
              key: ValueKey('DropDownSnackbar'),
              title: 'Snackbar Style',
              item: action.dropdownItem ?? 'FLOATING',
              list: ['GROUNDED', 'FLOATING'],
              callBack: (final value, final old) {
                action.dropdownItem = value;
                callback();
              },
            ),
            const Gap(Grid.small),
            DropdownControl(
              key: ValueKey('DropDown2Snackbar'),
              title: 'Snackbar Position',
              item: action.dropdownItem2 ?? 'BOTTOM',
              list: ['BOTTOM', 'TOP'],
              callBack: (final value, final old) {
                action.dropdownItem2 = value;
                callback();
              },
            ),
            const Gap(Grid.small),
            FlagControl(
              key: ValueKey('AddIconSnackbar'),
              title: 'Add Icon',
              keyValue: 'sAddIcon',
              value: action.addIcon ?? false,
              callBack: (final flag, final old) {
                action.addIcon = flag;
                callback();
              },
            ),
            if (action.addIcon ?? false)
              IconFeatherControl(
                key: ValueKey('IconSnackbar'),
                icon: action.icon as String,
                callBack: (final value, final old) {
                  action.icon = value;
                  callback();
                },
              ),
            if (action.addIcon ?? false) const Gap(Grid.small),
            if (action.addIcon ?? false)
              FillControl(
                title: 'Icon Color',
                key: ValueKey('IconColorSnackbar'),
                isImageEnabled: false,
                isNoneEnabled: false,
                type: FillTypeControlType.onlySolid,
                fill: action.fill as FFill,
                callBack: (final value, final styled, final old) {
                  action.fill = value;
                  callback();
                },
              ),
          ],
        ),
      ),
    );
  }
}
