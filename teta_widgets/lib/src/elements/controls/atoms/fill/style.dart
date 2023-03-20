// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import '../../../features/features.dart';
import 'package:teta_front_end/teta_front_end.dart';

//ignore: must_be_immutable
class StyleFillControl extends StatefulWidget {
  const StyleFillControl({
    required this.onlySolid,
    required this.model,
    required this.fill,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final bool onlySolid;
  final ColorStyleModel model;
  final FFill fill;
  final Function(FFill, bool, FFill) callBack;

  @override
  StyleFillControlState createState() => StyleFillControlState();
}

class StyleFillControlState extends State<StyleFillControl> {
  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<FocusBloc, List<int>>(
      builder: (final context, final state) {
        //updateState(state);
        return BlocBuilder<ColorStylesCubit, List<ColorStyleModel>>(
          builder: (final context, final paletteStyles) {
            //updateState(state);
            return Row(
              children: [
                Expanded(
                  child: CDropdownFillStyles(
                    value: widget.model.name,
                    items: paletteStyles
                        .where(
                          (final element) =>
                              (widget.onlySolid &&
                                  (element.fill.type == FFillType.solid ||
                                      element.fill.type == FFillType.none)) ||
                              !widget.onlySolid,
                        )
                        .toSet()
                        .toList()
                        .unique(),
                    onChange: (final value) {
                      ColorStyleModel? model;
                      for (final element in paletteStyles) {
                        if (element.name == value) model = element;
                      }
                      final old = FFill().fromJson(widget.fill.toJson());
                      widget.fill.paletteStyle = model!.name;
                      widget.callBack(
                        widget.fill,
                        false,
                        old,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
