// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

import 'package:collection/collection.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_cms/teta_cms.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_front_end/teta_front_end.dart';

//pk_test_51KqdzMGPvMnMI31y86lGM16w4HD9XITvjxuBMiQ7c74Q2lo8g9M94nU2W149XcM0Nb86rzWxik0AdIHsyBuHayqh000Jvu5Te7
//sk_test_51KqdzMGPvMnMI31yeQ2EIzATq6JtLElCHJuWoDp9JC8cxXSpVWZfOdQHdqdCO4Us4nlQYY8cVRx1lisCRk5zU2og00HM2MhVWL
class FActionTetaStoreAddProductsListItemToCart {
  static Future action(
    final BuildContext context,
    final List<VariableObject> states,
    final String? stateName,
    final List<DatasetObject> datasets,
    final int? loop,
  ) async {
    final dataset = (context.read<PageCubit>().state as PageLoaded)
        .datasets
        .firstWhereOrNull((final element) => element.getName == 'products');
    Logger.printWarning('${dataset?.getMap}');
    final prodId = dataset?.getMap[loop ?? 0]['_id'] as String?;
    if (prodId == null) return;
    await TetaCMS.instance.store.cart.insert(prodId);
  }

  static String toCode(
    final BuildContext context,
    final String? stateName,
    final CNode body,
  ) {
    return '''
    try {
      final products = this
          .datasets['products'] as List?;
      if (products != null &&
          products.length > index) {
      await TetaCMS.instance.store.cart.insert(products[index]['_id']);
      }
    } catch (e) {
      print(e.toString());
    }
    ''';
  }
}
