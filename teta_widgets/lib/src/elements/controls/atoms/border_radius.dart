// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hovering/hovering.dart';
import 'package:teta_core/src/design_system/textfield/minitextfield.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/border_radius.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class BorderRadiusControl extends StatefulWidget {
  const BorderRadiusControl({
    required this.borderRadius,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final FBorderRadius borderRadius;
  final Function(Map<String, dynamic>, Map<String, dynamic>) callBack;

  @override
  BorderRadiusControlState createState() => BorderRadiusControlState();
}

class BorderRadiusControlState extends State<BorderRadiusControl> {
  List<double>? radius;
  List<TextEditingController> controllers = [];
  bool isLinked = true;

  @override
  void initState() {
    radius = widget.borderRadius.radius;
    for (var i = 0; i < 4; i++) {
      controllers.add(TextEditingController());
    }
    for (var i = 0; i < 4; i++) {
      controllers[i].text = '${radius![i]}';
    }
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<DeviceModeCubit, DeviceInfo>(
      listener: (final context, final device) {
        if (device.identifier.type == DeviceType.phone) {
          radius = widget.borderRadius.radius;
        } else if (device.identifier.type == DeviceType.tablet) {
          radius = widget.borderRadius.radiusTablet;
        } else {
          radius = widget.borderRadius.radiusDesktop;
        }
        for (var i = 0; i < 4; i++) {
          controllers[i].text = '${radius![i]}';
        }
      },
      child: BlocBuilder<DeviceModeCubit, DeviceInfo>(
        builder: (final context, final device) =>
            BlocListener<FocusBloc, List<CNode>>(
          listener: (final context, final state) {
            if (state.isNotEmpty) {
              if (device.identifier.type == DeviceType.phone) {
                radius = widget.borderRadius.radius;
              } else if (device.identifier.type == DeviceType.tablet) {
                radius = widget.borderRadius.radiusTablet;
              } else {
                radius = widget.borderRadius.radiusDesktop;
              }
              for (var i = 0; i < 4; i++) {
                controllers[i].text = '${radius![i]}';
              }
            }
          },
          child: BlocBuilder<FocusBloc, List<CNode>>(
            builder: (final context, final state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12, left: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              BounceSmall(
                                message: 'Change device',
                                onTap: () {
                                  showDialog<void>(
                                    context: context,
                                    builder: (final ctx) => DevicesDialog(),
                                  );
                                },
                                child: Image.asset(
                                  device.identifier.type == DeviceType.phone
                                      ? Assets.icons.devices.smartphone.path
                                      : device.identifier.type ==
                                              DeviceType.tablet
                                          ? Assets.icons.devices.tablet.path
                                          : Assets.icons.devices.monitor.path,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                              const Gap(Grid.small),
                              const TParagraph(
                                'Border radius',
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isLinked = !isLinked;
                            });
                          },
                          child: HoverWidget(
                            hoverChild: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                              ),
                              child: Icon(
                                isLinked ? Icons.link : Icons.link_off,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                            onHover: (final e) {},
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.transparent,
                                ),
                              ),
                              child: Icon(
                                isLinked ? Icons.link : Icons.link_off,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CMiniTextField(
                          title: (!isLinked) ? 'T. L.' : 'ALL',
                          controller: controllers[0],
                          text: widget.borderRadius.radius![0].toString(),
                          hpadding: 4,
                          withSwipe: true,
                          callBack: (final text) {
                            radius![0] = double.parse(text);
                            if (isLinked) {
                              radius![1] = double.parse(text);
                              controllers[1].text = text;
                              radius![2] = double.parse(text);
                              controllers[2].text = text;
                              radius![3] = double.parse(text);
                              controllers[3].text = text;
                            }
                            final old = FBorderRadius.fromJson(
                              widget.borderRadius.toJson(),
                            );
                            final bR = widget.borderRadius;
                            widget.callBack(
                              bR.update(context: context, value: radius!),
                              old.toJson(),
                            );
                          },
                        ),
                      ),
                      if (!isLinked)
                        Expanded(
                          child: CMiniTextField(
                            title: 'T. R.',
                            controller: controllers[1],
                            text: widget.borderRadius.radius![1].toString(),
                            hpadding: 4,
                            withSwipe: true,
                            callBack: (final text) {
                              radius![1] = double.parse(text);
                              if (isLinked) {
                                radius![0] = double.parse(text);
                                controllers[0].text = text;
                                radius![2] = double.parse(text);
                                controllers[2].text = text;
                                radius![3] = double.parse(text);
                                controllers[3].text = text;
                              }
                              final old = FBorderRadius.fromJson(
                                widget.borderRadius.toJson(),
                              );
                              final bR = widget.borderRadius;
                              widget.callBack(
                                bR.update(context: context, value: radius!),
                                old.toJson(),
                              );
                            },
                          ),
                        ),
                      if (!isLinked)
                        Expanded(
                          child: CMiniTextField(
                            title: 'B. R.',
                            controller: controllers[2],
                            text: widget.borderRadius.radius![2].toString(),
                            hpadding: 4,
                            withSwipe: true,
                            callBack: (final text) {
                              radius![2] = double.parse(text);
                              if (isLinked) {
                                radius![0] = double.parse(text);
                                controllers[0].text = text;
                                radius![1] = double.parse(text);
                                controllers[1].text = text;
                                radius![3] = double.parse(text);
                                controllers[3].text = text;
                              }
                              final old = FBorderRadius.fromJson(
                                widget.borderRadius.toJson(),
                              );
                              final bR = widget.borderRadius;
                              widget.callBack(
                                bR.update(context: context, value: radius!),
                                old.toJson(),
                              );
                            },
                          ),
                        ),
                      if (!isLinked)
                        Expanded(
                          child: CMiniTextField(
                            title: 'B. L.',
                            controller: controllers[3],
                            text: widget.borderRadius.radius![3].toString(),
                            hpadding: 4,
                            withSwipe: true,
                            callBack: (final text) {
                              radius![3] = double.parse(text);
                              if (isLinked) {
                                radius![0] = double.parse(text);
                                controllers[0].text = text;
                                radius![1] = double.parse(text);
                                controllers[1].text = text;
                                radius![2] = double.parse(text);
                                controllers[2].text = text;
                              }
                              final old = FBorderRadius.fromJson(
                                widget.borderRadius.toJson(),
                              );
                              final bR = widget.borderRadius;
                              widget.callBack(
                                bR.update(context: context, value: radius!),
                                old.toJson(),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future updateState() async {
    setState(() {
      radius = widget.borderRadius.radius;
    });
    for (var i = 0; i < 4; i++) {
      controllers[i].text = '${radius![i]}';
    }
  }
}
