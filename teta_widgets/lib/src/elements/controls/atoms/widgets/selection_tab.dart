// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
// Package imports:
import 'package:hovering/hovering.dart';
// Project imports:
import 'package:teta_core/src/design_system/palette.dart';

class SelectionTab extends StatelessWidget {
  const SelectionTab({
    required this.isSelected,
    required this.onTap,
    required this.icon,
    Key? key,
  }) : super(key: key);

  final bool isSelected;
  final Function() onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: HoverWidget(
          hoverChild: body(isHovered: !isSelected),
          onHover: (e) {},
          child: body(isHovered: false),
        ),
      ),
    );
  }

  Widget body({required bool isHovered}) => Container(
        margin: const EdgeInsets.only(right: 4),
        height: 40,
        decoration: BoxDecoration(
          color: isSelected
              ? DarkPalette().colors['Palette.accent']
              : Colors.transparent,
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
