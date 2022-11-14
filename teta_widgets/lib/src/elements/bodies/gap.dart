import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/features.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/gap.dart';

class GapBody extends NodeBody {
  @override
  Map<String, dynamic> get attributes => <String, dynamic>{
        DBKeys.mainAxisExtend: FSize(size: '0', unit: SizeUnit.pixel),
        DBKeys.crossAxisExtend: FSize(size: '0', unit: SizeUnit.pixel),
        DBKeys.isExpandedGap: bool,
      };

  @override
  Widget toWidget({
    required final List<VariableObject> params,
    required final List<VariableObject> states,
    required final List<DatasetObject> dataset,
    required final bool forPlay,
    required final CNode node,
    final int? loop,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WGap(
        ValueKey(
          '''
            ${node.nid}
            $loop
            ${child ?? children}
            ${(attributes[DBKeys.mainAxisExtend] as FSize? ?? FSize()).toJson()}
            ${(attributes[DBKeys.crossAxisExtend] as FSize? ?? FSize()).toJson()}
            ''',
        ),
        node: node,
        params: params,
        states: states,
        dataset: dataset,
        forPlay: forPlay,
        mainAxisExtent: attributes[DBKeys.mainAxisExtend] as FSize,
        crossAxisExtent: attributes[DBKeys.crossAxisExtend] as FSize,
        isExpanded: attributes[DBKeys.isExpandedGap] as bool,
      );
}
