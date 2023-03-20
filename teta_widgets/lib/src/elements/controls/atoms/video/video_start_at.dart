// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_front_end/src/design_system/textfield/textfield.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_front_end/teta_front_end.dart';

class VideoStartAtControl extends StatefulWidget {
  const VideoStartAtControl({
    required this.startAt,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final int startAt;
  final Function(int, int) callBack;

  @override
  VideoStartAtControlState createState() => VideoStartAtControlState();
}

class VideoStartAtControlState extends State<VideoStartAtControl> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = '${widget.startAt}';

    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            TParagraph(
              'Start at',
            ),
            Icon(
              Icons.help_outline,
              color: Colors.white,
            ),
          ],
        ),
        CTextField(
          text: '${widget.startAt}',
          controller: controller,
          placeholder: 'insert the seconds',
          callBack: (final value) {
            final old = widget.startAt;
            if (int.tryParse(value) != null && int.tryParse(value) != null) {
              if (int.parse(value) >= 0) widget.callBack(int.parse(value), old);
            }
          },
        ),
      ],
    );
  }
}
