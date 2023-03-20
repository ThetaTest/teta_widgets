// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_front_end/teta_front_end.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({
    required this.control,
    required this.divider,
    final Key? key,
  }) : super(key: key);

  final Widget control;
  final bool divider;

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: [
        const Gap(Grid.medium),
        Container(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(
            children: [
              control,
            ],
          ),
        ),
        if (divider)
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Divider(height: 1, color: Colors.white38),
          ),
      ],
    );
  }
}
