// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:teta_core/src/design_system/textfield/minitextfield.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import '../../features/border_radius.dart';

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
    return BlocListener<DeviceModeCubit, DeviceState>(
      listener: (final context, final device) {
        if (device.info.identifier.type == DeviceType.phone) {
          radius = widget.borderRadius.radius;
        } else if (device.info.identifier.type == DeviceType.tablet) {
          radius = widget.borderRadius.radiusTablet;
        } else {
          radius = widget.borderRadius.radiusDesktop;
        }
        for (var i = 0; i < 4; i++) {
          controllers[i].text = '${radius![i]}';
        }
      },
      child: BlocBuilder<DeviceModeCubit, DeviceState>(
        builder: (final context, final device) =>
            BlocListener<FocusBloc, List<int>>(
          listener: (final context, final state) {
            if (state.isNotEmpty) {
              if (device.info.identifier.type == DeviceType.phone) {
                radius = widget.borderRadius.radius;
              } else if (device.info.identifier.type == DeviceType.tablet) {
                radius = widget.borderRadius.radiusTablet;
              } else {
                radius = widget.borderRadius.radiusDesktop;
              }
              for (var i = 0; i < 4; i++) {
                controllers[i].text = '${radius![i]}';
              }
            }
          },
          child: BlocBuilder<FocusBloc, List<int>>(
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
                            children: const [
                              DeviceIndicatorForControls(),
                              Gap(Grid.small),
                              TParagraph(
                                'Border radius',
                              ),
                            ],
                          ),
                        ),
                        BounceSmall(
                          key: ValueKey('toggle $isLinked'),
                          message: 'Link or unlink values',
                          onTap: () {
                            setState(() {
                              isLinked = !isLinked;
                            });
                          },
                          child: isLinked
                              ? Row(
                                  children: [
                                    const Icon(
                                      Icons.link,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                    const Gap(4),
                                    TDetailLabel(
                                      'Linked',
                                      color:
                                          Palette.txtPrimary.withOpacity(0.6),
                                    )
                                  ],
                                )
                              : Row(
                                  children: [
                                    const Icon(
                                      Icons.link_off,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                    const Gap(4),
                                    TDetailLabel(
                                      'Unlinked',
                                      color:
                                          Palette.txtPrimary.withOpacity(0.6),
                                    )
                                  ],
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
                      const Gap(4),
                      Expanded(
                        child: Opacity(
                          opacity: isLinked ? 0.3 : 1,
                          child: CMiniTextField(
                            title: 'T. R.',
                            controller: controllers[1],
                            text: widget.borderRadius.radius![1].toString(),
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
                      ),
                      const Gap(4),
                      Expanded(
                        child: Opacity(
                          opacity: isLinked ? 0.3 : 1,
                          child: CMiniTextField(
                            title: 'B. R.',
                            controller: controllers[2],
                            text: widget.borderRadius.radius![2].toString(),
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
                      ),
                      const Gap(4),
                      Expanded(
                        child: Opacity(
                          opacity: isLinked ? 0.3 : 1,
                          child: CMiniTextField(
                            title: 'B. L.',
                            controller: controllers[3],
                            text: widget.borderRadius.radius![3].toString(),
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
