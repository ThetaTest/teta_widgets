// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:hovering/hovering.dart';
import 'package:teta_front_end/src/design_system/palette.dart';

class SelectionTab extends StatelessWidget {
  const SelectionTab({
    required this.isSelected,
    required this.onTap,
    required this.icon,
    final Key? key,
  }) : super(key: key);

  final bool isSelected;
  final Function() onTap;
  final IconData icon;

  @override
  Widget build(final BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: HoverWidget(
          hoverChild: body(isHovered: !isSelected),
          onHover: (final e) {},
          child: body(isHovered: false),
        ),
      ),
    );
  }

  Widget body({required final bool isHovered}) => Container(
        margin: const EdgeInsets.only(right: 4),
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? Palette.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            style: isHovered ? BorderStyle.solid : BorderStyle.none,
            color: Colors.white,
          ),
        ),
        child: Center(
          child: Icon(
            icon,
            size: 20,
            color: Colors.white,
          ),
        ),
      );
}
