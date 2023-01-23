// Dart imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:

class DeleteControl extends StatelessWidget {
  const DeleteControl({
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final Function(bool) callBack;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 4,
        right: 4,
        bottom: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TActionLabel(
            'Delete',
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: CDangerousButton(
              label: 'Delete',
              callback: delete,
            ),
          ),
        ],
      ),
    );
  }

  void delete() => callBack(true);
}
