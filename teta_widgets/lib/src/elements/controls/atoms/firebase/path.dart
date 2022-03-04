// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/src/design_system/palette.dart';
import 'package:teta_core/src/design_system/text.dart';
import 'package:teta_core/src/models/page.dart';
import 'package:teta_core/src/models/project.dart';
import 'package:teta_widgets/src/elements/controls/atoms/firebase/parameter.dart';
import 'package:teta_widgets/src/elements/features/firestore_path.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';

class FirestorePathControl extends StatefulWidget {
  const FirestorePathControl({
    required this.prj,
    required this.page,
    required this.path,
    required this.isForAddData,
    required this.callBack,
    Key? key,
  }) : super(key: key);

  final ProjectObject prj;
  final PageObject page;
  final FFirestorePath path;
  final bool isForAddData;
  final Function(FFirestorePath, FFirestorePath) callBack;

  @override
  FirestorePathControlState createState() => FirestorePathControlState();
}

class FirestorePathControlState extends State<FirestorePathControl> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: !widget.isForAddData ? 0 : 16),
      decoration: BoxDecoration(
        color: !widget.isForAddData ? Colors.black : null,
        borderRadius: !widget.isForAddData ? BorderRadius.circular(8) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CText(
                !widget.isForAddData ? 'Query' : 'Path',
                color: Palette.white,
                size: 16,
                weight: FontWeight.w700,
              ),
            ],
          ),
          Column(
            children: widget.path.values!
                .map(
                  (e) => FirestoreParameterControl(
                    page: widget.page,
                    title: widget.path.values!.indexOf(e).isEven
                        ? 'Collection'
                        : 'Doc',
                    value: e,
                    callBack: (value, old) {
                      final old = widget.path;
                      widget.path.values![widget.path.values!.indexOf(e)] =
                          value;
                      widget.callBack(widget.path, old);
                    },
                  ),
                )
                .toList(),
          ),
          Row(
            children: [
              Expanded(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      final old = widget.path;
                      widget.path.values!.add(FTextTypeInput());
                      widget.path.isDoc = !widget.path.isDoc!;
                      widget.callBack(widget.path, old);
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
                    final old = widget.path;
                    widget.path.values!.removeLast();
                    widget.path.isDoc = !widget.path.isDoc!;
                    widget.callBack(widget.path, old);
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
