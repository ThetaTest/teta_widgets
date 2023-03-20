// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/align.dart';
import 'package:teta_front_end/teta_front_end.dart';

class AlignsControl extends StatefulWidget {
  const AlignsControl({
    required this.align,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final FAlign align;
  final Function(FAlign, FAlign) callBack;

  @override
  AlignsControlState createState() => AlignsControlState();
}

class AlignsControlState extends State<AlignsControl> {
  String? dropdown;

  @override
  void initState() {
    super.initState();
    dropdown = 'Top Left';
  }

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<DeviceModeCubit, DeviceState>(
      builder: (final context, final device) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: const [
                DeviceIndicatorForControls(),
                Gap(Grid.small),
                TParagraph(
                  'Align with the parent',
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CDropdown(
                  value: widget.align.getStringForDropDown(context),
                  items: FAlign.dropdownList,
                  onChange: (final newValue) {
                    if (newValue != null) {
                      setState(() {
                        dropdown = newValue;
                      });
                      final old = FAlign.fromJson(widget.align.toJson());
                      final device =
                          BlocProvider.of<DeviceModeCubit>(context).state;
                      Logger.printMessage('${device.info.identifier.type}');
                      final align = widget.align.copyWith(
                        align: device.info.identifier.type == DeviceType.phone
                            ? FAlign.convertDropDownToValue(newValue)
                            : null,
                        alignTablet:
                            device.info.identifier.type == DeviceType.tablet
                                ? FAlign.convertDropDownToValue(newValue)
                                : null,
                        alignDesktop:
                            device.info.identifier.type == DeviceType.laptop ||
                                    device.info.identifier.type ==
                                        DeviceType.desktop
                                ? FAlign.convertDropDownToValue(newValue)
                                : null,
                      );
                      widget.callBack(align, old);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
