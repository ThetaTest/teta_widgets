// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:theta_models/theta_models.dart';

// Project imports:

// ignore_for_file: public_member_api_docs

class WLoginSection extends StatelessWidget {
  /// Returns a [Align] widget in Teta
  const WLoginSection(
    final Key? key, {
    required this.node,
    required this.title,
    required this.description,
    required this.isAppleEnabled,
    required this.isGitHubEnabled,
    required this.isGoogleEnabled,
    required this.textStyle,
    required this.width,
    required this.height,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final FTextTypeInput title;
  final FTextTypeInput description;
  final bool isAppleEnabled;
  final bool isGoogleEnabled;
  final bool isGitHubEnabled;
  final FSize width;
  final FSize height;
  final FTextStyle textStyle;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(final BuildContext context) {
    return const SizedBox();
    /*
    final w = width.get(context: context, isWidth: true);
    final h = height.get(context: context, isWidth: true);
    return NodeSelectionBuilder(
      state: state,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextBuilder(
            textStyle: textStyle,
            value: title,
            params: params,
            states: states,
            dataset: dataset,
            forPlay: forPlay,
            loop: loop,
          ),
          if (description
              .get(params, states, dataset, forPlay, loop, context)
              .isNotEmpty)
            const Gap(4),
          if (description
              .get(params, states, dataset, forPlay, loop, context)
              .isNotEmpty)
            TextBuilder(
              textStyle: textStyle,
              value: description,
              params: params,
              states: states,
              dataset: dataset,
              forPlay: forPlay,
              loop: loop,
            ),
          const Gap(Grid.medium),
          if (isAppleEnabled)
            AppleAuthButton(
              style: AuthButtonStyle(width: w, height: h),
            ),
          if (isGoogleEnabled)
            AppleAuthButton(
              style: AuthButtonStyle(width: w, height: h),
            ),
          if (isGitHubEnabled)
            AppleAuthButton(
              style: AuthButtonStyle(width: w, height: h),
            ),
        ],
      ),
    );*/
  }
}
