// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Project imports:

// ignore_for_file: public_member_api_docs

class WStripeProductsList extends StatefulWidget {
  const WStripeProductsList(
    final Key? key, {
    required this.node,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    required this.children,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;

  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  /// The opzional child of this widget
  final List<CNode> children;

  @override
  State<WStripeProductsList> createState() => _WStripeProductsListState();
}

class _WStripeProductsListState extends State<WStripeProductsList> {
  @override
  void initState() {
    calc();
    super.initState();
  }

  Future calc() async {
    final prj =
        (BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded).prj;
    debugPrint('prj id: ${prj.id}');

    final baseUrl = 'https://builder.teta.so:8402/product/${prj.id}/list';

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'stripe-api-key': prj.config!.stripePrivateKey!,
      },
    );

    if (response.statusCode == 200) {
      debugPrint('get body: ${response.body}');

      final jsonData = json.decode(response.body) as List<dynamic>;
      final map =
          jsonData.map((final dynamic e) => e as Map<String, dynamic>).toList();

      final datasetObject = DatasetObject(
        name: 'products',
        map: map,
      );

      widget.dataset.clear();
      widget.dataset.add(datasetObject);
    }else{
      debugPrint('Error in calc WStripeProductsList -> ${response.body.toString()}');
    }
  }

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: Column(
        children: widget.children.isNotEmpty
            ? widget.children
                .map(
                  (final e) => e.toWidget(
                    loop: widget.loop,
                    forPlay: widget.forPlay,
                    params: widget.params,
                    states: widget.states,
                    dataset: widget.dataset,
                  ),
                )
                .toList()
            : [
                PlaceholderChildBuilder(
                  name: widget.node.intrinsicState.displayName,
                ),
              ],
      ),
    );
  }
}
