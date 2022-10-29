// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/controls/atoms/cms_collections.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
import 'package:teta_widgets/src/elements/index.dart';

class TetaCmsFetchControl extends StatelessWidget {
  const TetaCmsFetchControl({
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
        CMSCollectionControl(
          node: node,
          collectionId: action.cmsCollectionId,
          callBack: (final value, final old) {
            action.cmsCollectionId = value;
            callback();
          },
        ),
        TextControl(
          valueType: VariableType.string,
          node: node,
          value: action.cmsLimit ?? FTextTypeInput(),
          page: page,
          title: 'Limit',
          callBack: (final value, final old) {
            action.cmsLimit = value;
            callback();
          },
        ),
        TextControl(
          valueType: VariableType.string,
          node: node,
          value: action.cmsPage ?? FTextTypeInput(),
          page: page,
          title: 'Page',
          callBack: (final value, final old) {
            action.cmsPage = value;
            callback();
          },
        ),
        TextControl(
          valueType: VariableType.string,
          node: node,
          value: action.cmsKeyName ?? FTextTypeInput(),
          page: page,
          title: 'Key Name',
          callBack: (final value, final old) {
            action.cmsKeyName = value;
            callback();
          },
        ),
        TextControl(
          valueType: VariableType.string,
          node: node,
          value: action.cmsKeyValue ?? FTextTypeInput(),
          page: page,
          title: 'Key Value',
          callBack: (final value, final old) {
            action.cmsKeyValue = value;
            callback();
          },
        ),
      ],
    );
  }
}
