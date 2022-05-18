// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Package imports:
import 'package:teta_core/teta_core.dart';

// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WStripeProductsBuilder extends StatefulWidget {
  /// Returns a ListView.builder in Teta
  const WStripeProductsBuilder(
    final Key? key, {
    required this.child,
    required this.node,
    required this.forPlay,
    required this.value,
    required this.shrinkWrap,
    required this.isVertical,
    required this.params,
    required this.states,
    required this.dataset,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final bool forPlay;
  final bool shrinkWrap;
  final bool isVertical;
  final FDataset value;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  WStripeProductsBuilderState createState() => WStripeProductsBuilderState();
}

class WStripeProductsBuilderState extends State<WStripeProductsBuilder> {
  bool isLoading = true;

  @override
  void initState() {
    _getStripeProducts();
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    _getStripeProducts();
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: ListView.builder(
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        shrinkWrap: widget.shrinkWrap,
        scrollDirection: widget.isVertical ? Axis.vertical : Axis.horizontal,
        itemCount: widget.dataset
            .firstWhere(
              (final element) => element.getName.contains('products'),
              orElse: DatasetObject.empty,
            )
            .getMap
            .length,
        itemBuilder: (final context, final index) => widget.child != null
            ? widget.child!.toWidget(
                forPlay: widget.forPlay,
                params: widget.params,
                states: widget.states,
                dataset: widget.dataset,
                loop: index,
              )
            : PlaceholderChildBuilder(
                name: widget.node.intrinsicState.displayName,
              ),
      ),
    );
  }

  Future _getStripeProducts() async {
    final prj =
        (BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded).prj;

    final baseUrl = 'https://builder.teta.so:8402/product/${prj.id}/list';

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'stripe-api-key': prj.config!.stripePrivateKey!,
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;
      final map =
          jsonData.map((final dynamic e) => e as Map<String, dynamic>).toList();

      final datasetObject = DatasetObject(
        name: 'products',
        map: map,
      );

      addDataset(context, [], datasetObject);
    } else {
      debugPrint('Error in calc WStripeProductsList -> ${response.body}');
    }
  }
}
