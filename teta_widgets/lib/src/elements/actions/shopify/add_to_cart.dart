// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/src/cubits/local_shopify_cart/cubit.dart';

class FActionShopifyAddToCart {
  Future makeAction(BuildContext context, String value) async {
    try {
      BlocProvider.of<LocalShopifyCart>(context).add(value);
    } catch (e) {
      debugPrint('$e');
    }
  }

  String toCode() {
    return '''
      try {
        final value = params.firstWhere((e) => element.name == "id");
        BlocProvider.of<LocalShopifyCart>(context).add(value);
      } catch(e) {}
    ''';
  }
}