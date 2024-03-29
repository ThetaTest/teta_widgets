// Flutter imports:
// ignore_for_file: overridden_fields

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
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
    this.nid = 0,
  }) : super(childrenIds: FChildrenIds());

  ///
  final String type = globalType;

  @override
  int? parent;
  @override
  int nid;

  /// fromJson
  static NNull fromJson(
    final Map<String, dynamic> doc,
  ) =>
      NNull();

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{};

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final bool isVertical = true,
  }) =>
      const SizedBox();

  @override
  String toString() => 'NNull { nid: $nid }';

  @override
  Future<String> toCode(final BuildContext context) =>
      Future.value('const SizedBox(),');
}
