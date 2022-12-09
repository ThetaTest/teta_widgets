// Flutter imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

// Flutter imports:
import 'package:device_frame/device_frame.dart';
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
    return BlocListener<DeviceModeCubit, DeviceInfo>(
      listener: (final context, final device) {
        flag =
            widget.size.get(context: context, isWidth: widget.isWidth) != null;
        String? size;
        if (device.identifier.type == DeviceType.phone) {
          size = widget.size.size;
        } else if (device.identifier.type == DeviceType.tablet) {
          size = widget.size.sizeTablet;
        } else {
          size = widget.size.sizeDesktop;
        }
        final unit = widget.size.getUnit(context);
        for (var i = 0; i < 2; i++) {
          controller.text = (size == 'max' ||
                  size == 'inf' && size == '100%' && unit == SizeUnit.pixel)
              ? 'max'
              : (size == 'max' ||
                      size == 'inf' &&
                          size == '100%' &&
                          unit == SizeUnit.percent)
                  ? '100%'
                  : (widget.size.size == 'auto')
                      ? 'auto'
                      : '${widget.size.get(context: context, isWidth: widget.isWidth)}';
        }
      },
      child: BlocBuilder<DeviceModeCubit, DeviceInfo>(
        builder: (final context, final device) =>
            BlocBuilder<FocusBloc, List<CNode>>(
          builder: (final context, final state) {
            if (state.isNotEmpty) {
              if (state.first.nid != nodeId) {
                if (mounted) {
                  nodeId = state.first.nid;
                  flag = widget.size
                          .get(context: context, isWidth: widget.isWidth) !=
                      null;
                  var size = widget.size.size;
                  if (device.identifier.type == DeviceType.phone) {
                    size = widget.size.size;
                  } else if (device.identifier.type == DeviceType.tablet) {
                    size = widget.size.sizeTablet;
                  } else {
                    size = widget.size.sizeDesktop;
                  }
                  final unit = widget.size.getUnit(context);
                  for (var i = 0; i < 2; i++) {
                    controller.text = (size == 'max' ||
                            size == 'inf' &&
                                size == '100%' &&
                                unit == SizeUnit.pixel)
                        ? 'max'
                        : (size == 'max' ||
                                size == 'inf' &&
                                    size == '100%' &&
                                    unit == SizeUnit.percent)
                            ? '100%'
                            : (size == 'auto')
                                ? 'auto'
                                : '${widget.size.get(context: context, isWidth: widget.isWidth) ?? 0.0}';
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
                          BounceSmall(
                            message: 'Change device',
                            onTap: () {
                              showDialog<void>(
                                context: context,
                                builder: (final ctx) =>
                                    DevicesDialog(ctx: context),
                              );
                            },
                            child: Image.asset(
                              device.identifier.type == DeviceType.phone
                                  ? Assets.icons.devices.smartphone.path
                                  : device.identifier.type == DeviceType.tablet
                                      ? Assets.icons.devices.tablet.path
                                      : Assets.icons.devices.monitor.path,
                              width: 20,
                              height: 20,
                            ),
                          ),
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
                              szs.updateSize(value, context);
                              widget.node.body.attributes[widget.keyAttr] = szs;
                              widget.callBack(szs.toJson(), old.toJson());
                            },
                            value: flag,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: TParagraph(
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
                          ignoring: widget.size.get(
                                context: context,
                                isWidth: widget.isWidth,
                              ) ==
                              null,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  final old =
                                      FSize.fromJson(widget.size.toJson());
                                  widget.size
                                      .updateUnit(SizeUnit.pixel, context);
                                  final szs = widget.size;
                                  widget.node.body.attributes[widget.keyAttr] =
                                      szs;
                                  widget.callBack(szs.toJson(), old.toJson());
                                },
                                child: unitIcon(
                                  unit: SizeUnit.pixel,
                                  unitFromNode: widget.size.getUnit(context),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  final old =
                                      FSize.fromJson(widget.size.toJson());
                                  widget.size
                                      .updateUnit(SizeUnit.percent, context);
                                  final szs = widget.size;
                                  widget.node.body.attributes[widget.keyAttr] =
                                      szs;
                                  widget.callBack(szs.toJson(), old.toJson());
                                },
                                child: unitIcon(
                                  unit: SizeUnit.percent,
                                  unitFromNode: widget.size.getUnit(context),
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
                  visible: widget.size
                          .get(context: context, isWidth: widget.isWidth) !=
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
                                    callBack: (final value) {
                                      final szs = widget.size;
                                      final old =
                                          FSize.fromJson(widget.size.toJson());
                                      value.replaceAll('%', '');
                                      szs.updateSize(value, context);
                                      widget.node.body
                                          .attributes[widget.keyAttr] = szs;
                                      widget.callBack(
                                        szs.toJson(),
                                        old.toJson(),
                                      );
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
                                          widget.size.updateSize(
                                            widget.size.unit == SizeUnit.pixel
                                                ? 'max'
                                                : '100%',
                                            context,
                                          );
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
        ),
      ),
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
          unit == SizeUnit.pixel
              ? 'px'
              : unit == SizeUnit.percent
                  ? '%'
                  : unit == SizeUnit.width
                      ? '.w'
                      : '.h',
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
          unit == SizeUnit.pixel
              ? 'px'
              : unit == SizeUnit.percent
                  ? '%'
                  : unit == SizeUnit.width
                      ? '.w'
                      : '.h',
        ),
      ),
    ),
  );
}
