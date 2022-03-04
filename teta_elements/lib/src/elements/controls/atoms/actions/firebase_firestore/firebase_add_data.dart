/*
// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
// Project imports:
import 'package:mobile_editor/src/blocs/focus_page/index.dart';
import 'package:mobile_editor/src/design_system/palette.dart';
import 'package:mobile_editor/src/design_system/text.dart';
import 'package:mobile_editor/src/elements/controls/atoms/actions/firebase_firestore/widgets/add_data_element.dart';
import 'package:mobile_editor/src/elements/features/action.dart';

class FirebaseFirestoreAddDataActionElementBody extends StatelessWidget {
  /// Constructor
  const FirebaseFirestoreAddDataActionElementBody({
    Key? key,
    required this.element,
    required this.callback,
  }) : super(key: key);

  final FActionElement element;
  final Function(FActionElement, FActionElement) callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              CText(
                'Add Data',
                color: Palette.white,
                size: 16,
                weight: FontWeight.w700,
              ),
            ],
          ),
          if (element.paramsToSend != null)
            Column(
              children: element.paramsToSend!.keys
                  .map(
                    (e) => AddDataElement(
                      name: e,
                      value: element.paramsToSend![e] as Map<String, dynamic>,
                      page: BlocProvider.of<FocusPageBloc>(context).state,
                      callback: (value, old) {},
                    ),
                  )
                  .toList(),
            ),
          if (element.paramsToSend == null)
            const CText(
              'There are no params to send yet. Add a new one.',
              color: Palette.white,
              size: 12,
              weight: FontWeight.w400,
            ),
          Row(
            children: [
              Expanded(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      /*final old = widget.path;
                    widget.path.values!.add(
                        FTextTypeInput(type: FTextTypeEnum.text, value: ''));
                    widget.path.isDoc = !widget.path.isDoc!;
                    widget.callBack(widget.path, old);*/
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 16),
                      width: double.maxFinite,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3285FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: CText(
                          'Add Parameter',
                          color: Palette.white,
                          size: 14,
                          weight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    /*final old = widget.path;
                  widget.path.values!.removeLast();
                  widget.path.isDoc = !widget.path.isDoc!;
                  widget.callBack(widget.path, old);*/
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 16, left: 8),
                    width: 48,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.delete,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
*/
