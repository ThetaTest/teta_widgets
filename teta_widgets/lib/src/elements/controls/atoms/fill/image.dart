// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/src/blocs/focus/bloc.dart';
import 'package:teta_core/src/design_system/textfield/minitextfield.dart';

// Project imports:
import 'package:teta_widgets/src/elements/controls/atoms/box_fit.dart';
import 'package:teta_widgets/src/elements/features/features.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class ImageFillControl extends StatefulWidget {
  /// Constructor
  const ImageFillControl({
    required this.title,
    required this.fill,
    required this.node,
    required this.isStyled,
    required this.callBack,
    Key? key,
  }) : super(key: key);

  final FFill fill;
  final String title;
  final CNode node;
  final bool isStyled;
  final Function(FFill, bool, FFill) callBack;

  @override
  ImageFillControlState createState() => ImageFillControlState();
}

class ImageFillControlState extends State<ImageFillControl> {
  int? nodeId;
  bool? isUpdated;
  String? value;
  bool isVisible = true;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    nodeId = widget.node.nid;
    controller.text = widget.fill.levels!.first.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FocusBloc, List<CNode>>(
      listener: (context, state) {
        if (state.isNotEmpty) {
          if (state.first.nid != nodeId) {
            setState(() {
              isUpdated = true;
              controller.text = widget.fill.levels!.first.color;
            });
            nodeId = state.first.nid;
          }
        }
      },
      child: BlocBuilder<FocusBloc, List<CNode>>(
        builder: (context, state) {
          //updateState(state);
          return Column(
            children: [
              Container(
                width: double.maxFinite,
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.fill.levels!.first.color,
                    ),
                    fit: widget.fill.boxFit?.get ?? BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: CMiniTextField(
                        placeholder: controller.text,
                        controller: controller,
                        title: 'IMAGE URL',
                        hpadding: 0,
                        callBack: (text) {
                          final old = FFill().fromJson(widget.fill.toJson());
                          widget.fill.get(context).levels!.first.color = text;
                          widget.callBack(widget.fill, false, old);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              BoxFitControl(
                boxFit: widget.fill.boxFit!,
                callBack: (fit, old) {
                  final old = FFill().fromJson(widget.fill.toJson());
                  widget.fill.boxFit = fit;
                  widget.callBack(widget.fill, false, old);
                },
              )
            ],
          );
        },
      ),
    );
  }
}
