// Dart imports:
// ignore_for_file: public_member_api_docs

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:teta_core/src/design_system/textfield/textfield.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/controls/atoms/size.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class FontSizeControl extends StatefulWidget {
  const FontSizeControl({
    required this.textStyle,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final FTextStyle textStyle;
  final Function(Map<String, dynamic>, Map<String, dynamic>) callBack;

  @override
  FontSizeState createState() => FontSizeState();
}

class FontSizeState extends State<FontSizeControl> {
  TextEditingController controller = TextEditingController();
  Timer? searchOnStoppedTyping;

  @override
  void initState() {
    controller.text = '${widget.textStyle.fontSize?.get(context)}';
    super.initState();
  }

  void onChangeHandler(final FTextStyle value, final FTextStyle old) {
    const duration = Duration(milliseconds: 400);
    if (searchOnStoppedTyping != null) {
      setState(() => searchOnStoppedTyping!.cancel());
    }
    setState(
      () => searchOnStoppedTyping = Timer(
        duration,
        () => setValue(value, old),
      ),
    );
  }

  void setValue(final FTextStyle value, final FTextStyle old) {
    widget.callBack(
      value.toJson(),
      old.toJson(),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<DeviceModeCubit, DeviceState>(
      listener: (final context, final state) {
        controller.text = '${widget.textStyle.fontSize!.get(context)}';
      },
      child: BlocBuilder<DeviceModeCubit, DeviceState>(
        builder: (final context, final device) =>
            BlocListener<FocusBloc, List<int>>(
          listener: (final context, final state) {
            if (state.isNotEmpty) {
              controller.text = '${widget.textStyle.fontSize!.get(context)}';
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      BounceSmall(
                        message: 'Change device',
                        onTap: () {
                          showDialog<void>(
                            context: context,
                            builder: (final ctx) => const DevicesDialog(),
                          );
                        },
                        child: Image.asset(
                          device.info.identifier.type == DeviceType.phone
                              ? Assets.icons.devices.smartphone.path
                              : device.info.identifier.type == DeviceType.tablet
                                  ? Assets.icons.devices.tablet.path
                                  : Assets.icons.devices.monitor.path,
                          width: 24,
                          height: 24,
                        ),
                      ),
                      const Gap(Grid.small),
                      const TParagraph(
                        'Font Size',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          final old = widget.textStyle;
                          widget.textStyle.fontSize!.unit = SizeUnit.pixel;
                          onChangeHandler(widget.textStyle, old);
                        },
                        child: unitIcon(
                          unit: SizeUnit.pixel,
                          unitFromNode: widget.textStyle.fontSize!.unit,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          final old = widget.textStyle;
                          widget.textStyle.fontSize!.unit = SizeUnit.width;
                          onChangeHandler(widget.textStyle, old);
                        },
                        child: unitIcon(
                          unit: SizeUnit.width,
                          unitFromNode: widget.textStyle.fontSize!.unit,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          final old = widget.textStyle;
                          widget.textStyle.fontSize!.unit = SizeUnit.height;
                          onChangeHandler(widget.textStyle, old);
                        },
                        child: unitIcon(
                          unit: SizeUnit.height,
                          unitFromNode: widget.textStyle.fontSize!.unit,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(Grid.small),
              CTextField(
                controller: controller,
                text: '${widget.textStyle.fontSize?.get(context)}',
                callBack: (final value) {
                  final old = widget.textStyle;
                  widget.textStyle.fontSize!
                      .update(double.parse(value), context);
                  onChangeHandler(widget.textStyle, old);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
