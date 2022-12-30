// Flutter imports:
// ignore_for_file: public_member_api_docs, use_key_in_widget_constructors, lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WNumericStepButton extends StatefulWidget {
  const WNumericStepButton(
    final Key? key, {
    required this.state,
  }) : super(key: key);

  final TetaWidgetState state;

  @override
  _WNumericStepButtonState createState() => _WNumericStepButtonState();
}

class _WNumericStepButtonState extends State<WNumericStepButton> {
  int counter = 0;
  int maxValue = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      state: widget.state,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(
              Icons.remove,
              color: Theme.of(context).colorScheme.secondary,
            ),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 18),
            iconSize: 32,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          Text(
            '$counter',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.secondary,
            ),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 18),
            iconSize: 32,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              if (mounted) {
                setState(() {
                  if (counter < maxValue) {
                    counter++;
                  }
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
