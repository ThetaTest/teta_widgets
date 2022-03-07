/*import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_editor/src/blocs/focus/bloc.dart';
import 'package:mobile_editor/src/design_system/text.dart';
import 'package:mobile_editor/src/design_system/textfield/minitextfield.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';

class Margins extends StatefulWidget {
  final CNode node;
  final
  final Function(List<double>, List<double>) callBack;
  Margins({
    Key? key,
    required this.node,
    required this.callBack,
  }) : super(key: key);

  @override
  _MarginsState createState() => _MarginsState();
}

class _MarginsState extends State<Margins> {
  EdgeInsets? margins;

  @override
  void initState() {
    margins = widget.node.margins!.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FocusBloc, List<CNode>>(
      builder: (context, state) {
        updateState(state);
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CText('Borders'),
              Row(
                children: [
                  CMiniTextField(
                    controller: TextEditingController(),
                    text: margins!.left.toString(),
                    hpadding: 4,
                    callBack: (text) {
                      /*margins[0] = double.parse(text);
                      widget.callBack(margins);*/
                    },
                  ),
                  CMiniTextField(
                    controller: TextEditingController(),
                    text: margins!.top.toString(),
                    hpadding: 4,
                    callBack: (text) {
                      /*margins[1] = double.parse(text);
                      widget.callBack(margins);*/
                    },
                  ),
                  CMiniTextField(
                    controller: TextEditingController(),
                    text: margins!.right.toString(),
                    hpadding: 4,
                    callBack: (text) {
                      /*margins[2] = double.parse(text);
                      widget.callBack(margins);*/
                    },
                  ),
                  CMiniTextField(
                    controller: TextEditingController(),
                    text: margins!.bottom.toString(),
                    hpadding: 4,
                    callBack: (text) {
                      /*margins[3] = double.parse(text);
                      widget.callBack(margins);*/
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  updateState(CNode node) async {
    /*await Future<void>.delayed(const Duration(milliseconds: 100));
    setState(() {
      margins = node.margins;
    });*/
  }
}
*/
