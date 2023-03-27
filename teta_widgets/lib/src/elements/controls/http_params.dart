import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

import '../features/text_type_input.dart';
import 'http_params_element.dart';

class HttpParamsControl extends StatefulWidget {
  const HttpParamsControl({
    required this.list,
    required this.callBack,
    final Key? key,
    this.title,
  }) : super(key: key);

  final List<MapElement> list;
  final Function(List<MapElement>, List<MapElement>) callBack;
  final String? title;

  @override
  HttpParamsControlState createState() => HttpParamsControlState();
}

class HttpParamsControlState extends State<HttpParamsControl> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: widget.list.isEmpty ? 0 : 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TParagraph(
                  widget.title ?? 'Add Params',
                ),
                Row(
                  children: [
                    BounceSmall(
                      onTap: () {
                        final old = widget.list;
                        widget.list.add(
                          MapElement(
                            key: '',
                            value: FTextTypeInput(),
                          ),
                        );
                        widget.callBack(widget.list, old);
                      },
                      child: HoverWidget(
                        hoverChild: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                            ),
                          ),
                          child: const Icon(
                            Icons.add,
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
                          child: const Icon(
                            Icons.add,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.list
                  .map(
                    (final e) => Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: HttpParamsElementControl(
                        value: e,
                        callBack: (final value, final old) {
                          final old = widget.list;
                          setState(() {
                            final index = widget.list.indexOf(e);
                            widget.list[index] = value;
                          });
                          widget.callBack(widget.list, old);
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
