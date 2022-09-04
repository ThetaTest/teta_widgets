// Flutter imports:
// ignore_for_file: overridden_fields

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/children_ids.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

/// constant type
const globalType = 'Null';

/// constant name
const globalName = 'Null';

///
// ignore: must_be_immutable
class NNull extends CNode {
  /// construct
  NNull({
    required this.context,
    this.nid = 0,
  }) : super(childrenIds: FChildrenIds());

  ///
  final String type = globalType;

  @override
  int? parent;
  @override
  int nid;

  BuildContext? context;

  /// fromJson
  static NNull fromJson(
    final Map<String, dynamic> doc,
    final BuildContext context,
  ) =>
      NNull(context: context);

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{};

  @override
  Widget toWidget({
    required final List<VariableObject> params,
    required final List<VariableObject> states,
    required final List<DatasetObject> dataset,
    required final bool forPlay,
    final int? loop,
  }) =>
      const SizedBox();

  @override
  String toString() => 'NNull { nid: $nid }';

  @override
  Future<String> toCode(final BuildContext context) =>
      Future.value('const SizedBox(),');
}
