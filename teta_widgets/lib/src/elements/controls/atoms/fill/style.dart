// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/src/blocs/focus/bloc.dart';
import 'package:teta_core/src/blocs/palette/index.dart';
import 'package:teta_core/src/design_system/dropdowns/dropdown.dart';
import 'package:teta_core/src/models/palette.dart';

// Project imports:
import 'package:teta_widgets/src/elements/features/features.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

//ignore: must_be_immutable
class StyleFillControl extends StatefulWidget {
  const StyleFillControl({
    required this.onlySolid,
    required this.node,
    required this.model,
    required this.fill,
    required this.callBack,
    Key? key,
  }) : super(key: key);

  final bool onlySolid;
  final CNode node;
  final PaletteModel model;
  final FFill fill;
  final Function(FFill, bool, FFill) callBack;

  @override
  StyleFillControlState createState() => StyleFillControlState();
}

class StyleFillControlState extends State<StyleFillControl> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FocusBloc, List<CNode>>(
      builder: (context, state) {
        //updateState(state);
        return BlocBuilder<PaletteBloc, List<PaletteModel>>(
          builder: (context, paletteStyles) {
            //updateState(state);
            return Row(
              children: [
                Expanded(
                  child: CDropdown(
                    value: widget.model.name,
                    items: paletteStyles
                        .where(
                          (element) =>
                              (widget.onlySolid &&
                                  (element.fill!.type == FFillType.solid ||
                                      element.fill!.type == FFillType.none)) ||
                              !widget.onlySolid,
                        )
                        .map((e) => e.name!)
                        .toList(),
                    onChange: (value) {
                      PaletteModel? model;
                      BlocProvider.of<PaletteBloc>(context)
                          .state
                          .forEach((element) {
                        if (element.name == value) model = element;
                      });
                      final old = FFill().fromJson(widget.fill.toJson());
                      widget.fill.paletteStyle = model!.id;
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
