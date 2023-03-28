// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:theta_widgets/src/elements/code/formatter_test.dart';
import '../../../../../../../../teta_open_classes/lib/src/nodes/dynamic.dart';
// Project imports:
import '../../../../../../../../teta_open_classes/lib/src/nodes/node.dart';

/// Generates the code for RevenueCat product list widget, unclassified for now
class RevenueCatProductsListCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NDynamic node,
    final CNode? child,
    final int? loop,
  ) async {
    var childString = 'const SizedBox()';
    if (child != null) {
      childString = await child.toCode(context);
    }

    final code = '''
  TetaFutureBuilder<List<Product>>(
    future: Future<List<Product>>.sync(() async {
      var products = <Product>[];
      if (UniversalPlatform.isIOS || UniversalPlatform.isAndroid) {
        try {
          final offerings = await Purchases.getOfferings();
          if (offerings.current != null &&
              (offerings.current?.availablePackages ?? []).isNotEmpty) {
            final prods = <Product>[];
            for (final product
                in offerings.current?.availablePackages ?? <Package>[]) {
              prods.add(product.product);
            }
            products = prods;
          }
        } catch (e) {
          print('\$e');
        }
      }
      return products;
    }),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final prods = snapshot.data;
        datasets['${node.name ?? node.intrinsicState.displayName}'] = prods != null ? prods.map((e) => e.toJson()).toList() : const <Product>[];
        return ListView.builder(
          itemCount: prods?.length ?? 0,
          itemBuilder: (context, index) {
            return $childString;
          },
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    }
  )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      return 'const SizedBox()';
    }
  }

  static void testCode() {}
}
