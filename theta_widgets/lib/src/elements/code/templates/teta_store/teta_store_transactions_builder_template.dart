// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:theta_widgets/src/elements/controls/key_constants.dart';
import '../../../../../../../../teta_open_classes/lib/src/nodes/enum.dart';
import '../../../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';

/// Generates the code for StripeProductsBuilder widget
class TetaStoreTransactionsBuilderCodeTemplate {
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
   FutureBuilder<TetaTransactionsResponse>(
      future: TetaCMS.instance.store.transactions(),
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final r = snapshot.data?.data;
          if(r != null) {
          this.datasets['transactions'] = r.map((final e) => e.toJson()).toList(growable: true);
          return ListView.builder(
            $_scrollDirection
            shrinkWrap: $shrinkWrap,
            itemCount: this.datasets['transactions'].length,
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
    group('Stripe Products Builder toCode test', () {
      test(
        'Stripe Products Builder: default code',
        () {
          final body = NodeBody.get(NType.tetaStoreProductsBuilder);
          final _scrollDirection =
              !(body.attributes[DBKeys.isVertical] as bool? ?? false)
                  ? 'scrollDirection: Axis.horizontal,'
                  : '';
          final shrinkWrap = body.attributes[DBKeys.flag] as bool? ?? false;

          const childCode = 'const SizedBox();';
          expect(
            FormatterTest.format('''
FutureBuilder<TetaProductsResponse>(
      future: TetaCMS.instance.store.products.getAll(),
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final r = snapshot.data?.data;
          if(r != null) {
          this.datasets['products'] = r.map((final e) => e.toJson()).toList(growable: true);
          return ListView.builder(
            $_scrollDirection
            shrinkWrap: $shrinkWrap,
            itemCount: this.datasets['products'].length,
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
