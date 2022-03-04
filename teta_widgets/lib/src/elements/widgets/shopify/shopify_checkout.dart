/// FIXME: Need fixes

/*

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';

class WShopifyCheckout extends StatefulWidget {
  final CNode node;
  final CNode? child;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  WShopifyCheckout({
    Key? key,
    this.child,
    required this.node,
    required this.forPlay,
    this.loop,
    required this.params,
    required this.states,
    required this.dataset,
  }) : super(key: key);

  @override
  _WShopifyCheckoutState createState() => _WShopifyCheckoutState();
}

class _WShopifyCheckoutState extends State<WShopifyCheckout> {
  bool flagCheckout = true;
  bool isLoading = true;
  String? webUrl;

  Widget build(BuildContext context) {
    if (flagCheckout) checkout(context);
    return isLoading ? Center(child: CircularProgressIndicator()) : SizedBox();
    /*PlatformInfo().isWeb()
            ? Container(
                width: double.maxFinite,
                child: Column(
                  children: [
                    const Icon(
                      Icons.info_outline_rounded,
                      size: 32,
                    ),
                    const CText(
                      "Shopify Checkout will be avaible in final app",
                      size: 12,
                    ),
                  ],
                ),
              )
            : Container(
                child: EasyWebView(
                  src: webUrl!,
                  onLoaded: () {},
                  width: double.maxFinite,
                  height: 500,
                  headers: {
                    "Access-Control-Allow-Origin": "*",
                  },
                ),
              );*/
  }

  Future<void> checkout(BuildContext context) async {
    try {
      if (mounted) {
        setState(() {
          flagCheckout = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
*/
