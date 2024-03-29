// Dart imports:
// ignore_for_file: public_member_api_docs

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:teta_front_end/src/design_system/textfield/textfield.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';

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
    controller.text = '${widget.textStyle.fontSize?.get(
      context,
      forPlay: false,
    )}';
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
        controller.text = '${widget.textStyle.fontSize!.get(
          context,
          forPlay: false,
        )}';
      },
      child: BlocBuilder<DeviceModeCubit, DeviceState>(
        builder: (final context, final device) =>
            BlocListener<FocusBloc, List<int>>(
          listener: (final context, final state) {
            if (state.isNotEmpty) {
              controller.text = '${widget.textStyle.fontSize!.get(
                context,
                forPlay: false,
              )}';
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      DeviceIndicatorForControls(),
                      Gap(Grid.small),
                      TParagraph(
                        'Font Size',
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(Grid.small),
              CTextField(
                controller: controller,
                text: '${widget.textStyle.fontSize?.get(
                  context,
                  forPlay: false,
                )}',
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
