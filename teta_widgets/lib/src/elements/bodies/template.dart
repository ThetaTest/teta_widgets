// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs, overridden_fields, prefer_constructors_over_static_methods, lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
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

  static NTemplate fromJson(
    final Map<String, dynamic> doc,
    final BuildContext context,
  ) {
    return NTemplate();
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{};
  }

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final bool isVertical = true,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      const SizedBox();

  @override
  String toString() => 'NNull { nid: $nid }';

  @override
  Future<String> toCode(final BuildContext context) =>
      Future.value('Container(),');
}
