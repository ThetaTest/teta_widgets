// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/src/design_system/palette.dart';
import 'package:teta_core/src/design_system/text.dart';

class SliderControls extends StatelessWidget {
  const SliderControls({
    required this.title,
    required this.value,
    required this.maxAndMin,
    required this.callBack,
    Key? key,
  }) : super(key: key);

  final String title;
  final double value;
  final List<double> maxAndMin;
  final Function(double, bool, double) callBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.maxFinite,
            child: SliderTheme(
              data: SliderThemeData(
                trackShape: CustomTrackShape(),
              ),
              child: CupertinoSlider(
                value: value,
                max: maxAndMin[0],
                min: maxAndMin[1],
                onChanged: (val) {
                  callBack(val, false, value);
                },
                onChangeEnd: (val) {
                  callBack(val, true, value);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: CText(
              title,
              size: 9,
              color: Palette.white,
              weight: FontWeight.w300,
            ),
          )
        ],
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    Offset offset = Offset.zero,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight!;
    const trackLeft = 0.0;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
