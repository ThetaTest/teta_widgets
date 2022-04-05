// Flutter imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hovering/hovering.dart';
import 'package:teta_core/src/design_system/textfield/minitextfield.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/features.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class SizeControl extends StatefulWidget {
  const SizeControl({
    required this.keyAttr,
    required this.node,
    required this.size,
    required this.isWidth,
    required this.title,
    required this.callBack,
    required this.isFromSizesPrefab,
    final Key? key,
  }) : super(key: key);

  final String keyAttr;
  final CNode node;
  final FSize size;
  final bool isWidth;
  final String title;
  final bool isFromSizesPrefab;
  final Function(Map<String, dynamic>, Map<String, dynamic>) callBack;

  @override
  SizeControlsState createState() => SizeControlsState();
}

class SizeControlsState extends State<SizeControl> {
  int? nodeId;
  bool? isUpdated;
  TextEditingController controller = TextEditingController();
  bool flag = false;

  @override
  void initState() {
    nodeId = widget.node.nid;
    controller.text =
        '${widget.size.get(context: context, isWidth: widget.isWidth)}';
    flag = widget.size.get(context: context, isWidth: widget.isWidth) != null;
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<FocusBloc, List<CNode>>(
      builder: (final context, final state) {
        if (state.isNotEmpty) {
          if (state.first.nid != nodeId) {
            if (mounted) {
              nodeId = state.first.nid;
              flag =
                  widget.size.get(context: context, isWidth: widget.isWidth) !=
                      null;
              for (var i = 0; i < 2; i++) {
                controller.text = (widget.size.size == 'max' ||
                        widget.size.size == 'inf' &&
                            widget.size.size == '100%' &&
                            widget.size.unit == SizeUnit.pixel)
                    ? 'max'
                    : (widget.size.size == 'max' ||
                            widget.size.size == 'inf' &&
                                widget.size.size == '100%' &&
                                widget.size.unit == SizeUnit.percent)
                        ? '100%'
                        : (widget.size.size == 'auto')
                            ? 'auto'
                            : '${widget.size.get(context: context, isWidth: widget.isWidth)}';
              }
            }
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8, right: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CSwitch(
                        callback: (final v) {
                          final value = v
                              ? widget.isWidth
                                  ? 'max'
                                  : '150'
                              : 'null';
                          setState(() {
                            flag = v;
                          });
                          final szs = widget.size;
                          final old = FSize.fromJson(widget.size.toJson());
                          value.replaceAll('%', '');
                          szs.size = value;
                          widget.node.body.attributes[widget.keyAttr] = szs;
                          widget.callBack(szs.toJson(), old.toJson());
                        },
                        value: flag,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: THeadline3(
                          widget.title,
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: widget.size.get(
                          context: context,
                          isWidth: widget.isWidth,
                        ) !=
                        null,
                    child: IgnorePointer(
                      ignoring: widget.size
                              .get(context: context, isWidth: widget.isWidth) ==
                          null,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              final old = FSize.fromJson(widget.size.toJson());
                              widget.size.unit = SizeUnit.pixel;
                              final szs = widget.size;
                              widget.node.body.attributes[widget.keyAttr] = szs;
                              widget.callBack(szs.toJson(), old.toJson());
                            },
                            child: unitIcon(
                              unit: SizeUnit.pixel,
                              unitFromNode: widget.size.unit,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              final old = FSize.fromJson(widget.size.toJson());
                              widget.size.unit = SizeUnit.percent;
                              final szs = widget.size;
                              widget.node.body.attributes[widget.keyAttr] = szs;
                              widget.callBack(szs.toJson(), old.toJson());
                            },
                            child: unitIcon(
                              unit: SizeUnit.percent,
                              unitFromNode: widget.size.unit,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible:
                  widget.size.get(context: context, isWidth: widget.isWidth) !=
                      null,
              child: IgnorePointer(
                ignoring: widget.size
                        .get(context: context, isWidth: widget.isWidth) ==
                    null,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width >= 600
                          ? 300
                          : MediaQuery.of(context).size.width - 20,
                      height: 60,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: CMiniTextField(
                                controller: controller,
                                text: widget.size.size,
                                hpadding: 0,
                                callBack: (final value) {
                                  final szs = widget.size;
                                  final old =
                                      FSize.fromJson(widget.size.toJson());
                                  value.replaceAll('%', '');
                                  szs.size = value;
                                  widget.node.body.attributes[widget.keyAttr] =
                                      szs;
                                  widget.callBack(szs.toJson(), old.toJson());
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 12,
                            bottom: 18,
                            child: Container(
                              color: Palette.bgTertiary,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      final old = FSize.fromJson(
                                        widget.size.toJson(),
                                      );
                                      widget.size.size =
                                          widget.size.unit == SizeUnit.pixel
                                              ? 'max'
                                              : '100%';
                                      widget.node.body
                                              .attributes[widget.keyAttr] =
                                          widget.size;
                                      widget.callBack(
                                        widget.size.toJson(),
                                        old.toJson(),
                                      );
                                      controller.text =
                                          widget.size.unit == SizeUnit.pixel
                                              ? 'max'
                                              : '100%';
                                    },
                                    child: maxIcon(
                                      unit: widget.size.unit,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget maxIcon({final SizeUnit? unit}) {
    return TContainer(
      key: UniqueKey(),
      width: 32,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          style: BorderStyle.none,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Center(
        child: TDetailLabel(
          'Max',
          color: Palette.txtGrey,
        ),
      ),
    );
  }

  Widget unitIcon({final SizeUnit? unit, final SizeUnit? unitFromNode}) {
    return HoverWidget(
      hoverChild: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: unitFromNode == unit ? Colors.white24 : Colors.transparent,
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: TDetailLabel(
            unit == SizeUnit.pixel ? 'PX' : '%',
          ),
        ),
      ),
      onHover: (final event) {},
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: unitFromNode == unit ? Colors.white24 : Colors.transparent,
          border: Border.all(
            color: Colors.white,
            style: BorderStyle.none,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: TDetailLabel(
            unit == SizeUnit.pixel ? 'PX' : '%',
          ),
        ),
      ),
    );
  }
}
