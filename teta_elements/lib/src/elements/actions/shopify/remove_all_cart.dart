// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
// Project imports:
import 'package:teta_core/src/cubits/local_shopify_cart/cubit.dart';

class FActionShopifyRemoveAllFromCart {
  Future makeAction(BuildContext context, String value) async {
    try {
      BlocProvider.of<LocalShopifyCart>(context).removeAll(value);
    } catch (e) {
      debugPrint('$e');
    }
  }

  String toCode() {
    return '''
      try {
        final value = params.firstWhere((e) => element.name == "id");
        BlocProvider.of<LocalShopifyCart>(context).removeAll(value);
      } catch(e) {}
    ''';
  }
}
