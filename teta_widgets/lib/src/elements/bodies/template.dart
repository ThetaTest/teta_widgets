// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs, overridden_fields, prefer_constructors_over_static_methods, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/children_ids.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/templates/template.dart';

const _globalType = 'Null';

//ignore: must_be_immutable
class NTemplate extends CNode {
  /// Constructor
  NTemplate() : super(childrenIds: FChildrenIds());

  CTemplate? template;
  final String type = _globalType;
  @override
  int? parent;

  static NTemplate fromJson(Map<String, dynamic> doc, BuildContext context) {
    return NTemplate();
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{};
  }

  @override
  Widget toWidget({
    required List<VariableObject> params,
    required List<VariableObject> states,
    required List<DatasetObject> dataset,
    int? loop,
    required bool forPlay,
  }) =>
      const SizedBox();

  @override
  String toString() => 'NNull { nid: $nid }';

  @override
  String toCode(BuildContext context) => 'Container(),';
}
