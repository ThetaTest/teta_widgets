// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for StripeCartItems widget
class TetaStoreCartItemsBuilderTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
  ) async {
    final _scrollDirection =
        !(body.attributes[DBKeys.isVertical] as bool? ?? false)
            ? 'scrollDirection: Axis.horizontal,'
            : '';
    final shrinkWrap = body.attributes[DBKeys.flag] as bool? ?? false;

    var childCode = 'const SizedBox();';
    if (child != null) {
      childCode = await child.toCode(context);
    }
    final code = '''
   FutureBuilder<TetaProductsResponse>(
      future: TetaCMS.instance.store.cart.get(),
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final r = snapshot.data?.data;
          if(r != null) {
          this.datasets['cart'] = r.map((final e) => e.toJson()).toList(growable: true);
          return ListView.builder(
            $_scrollDirection
            shrinkWrap: $shrinkWrap,
            itemCount: this.datasets['cart'].length,
            itemBuilder: (context, index) {
              return $childCode;
            },
          );
          } else {
          return Container();
        }
      }
      }
      ),
    )
    ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      return 'const SizedBox()';
    }
  }

  static void testCode() {
    group('Stripe Cart Items Builder toCode test', () {
      test(
        'Stripe Cart Items Builder: default code',
        () {
          final body = NodeBody.get(NType.tetaStoreCartItemsBuilder);
          final _scrollDirection =
              !(body.attributes[DBKeys.isVertical] as bool? ?? false)
                  ? 'scrollDirection: Axis.horizontal,'
                  : '';
          final shrinkWrap = body.attributes[DBKeys.flag] as bool? ?? false;

          const childCode = 'const SizedBox();';
          expect(
            FormatterTest.format('''
FutureBuilder<TetaProductsResponse>(
      future: TetaCMS.instance.store.getCartProducts(),
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final r = snapshot.data?.data;
          if(r != null) {
          this.datasets['cart'] = r.map((final e) => e.toJson()).toList(growable: true);
          return ListView.builder(
            $_scrollDirection
            shrinkWrap: $shrinkWrap,
            itemCount: this.datasets['cart'].length,
            itemBuilder: (context, index) {
              return $childCode;
            },
          );
          } else {
          return Container();
        }
      }
      }
      ),
    )
            '''),
            true,
          );
        },
      );
    });
  }
}
