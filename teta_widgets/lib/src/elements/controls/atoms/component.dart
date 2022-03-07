/*import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hovering/hovering.dart';
import 'package:mobile_editor/src/blocs/text_styles/index.dart';
import 'package:mobile_editor/src/cubits/device_mode/cubit.dart';
import 'package:mobile_editor/src/design_system/palette.dart';
import 'package:mobile_editor/src/design_system/text.dart';
import 'package:mobile_editor/src/design_system/textfield/minitextfield.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/models/page.dart';
import 'package:mobile_editor/src/models/project.dart';
import 'package:mobile_editor/src/repositories/project.dart';
import 'package:nil/nil.dart';

class ComponentControl extends StatefulWidget {
  final ProjectObject prj;
  final CNode node;
  final PageObject page;
  final Function(String, String) callBack;
  ComponentControl(
      {Key? key,
      required this.node,
      required this.prj,
      required this.page,
      required this.callBack})
      : super(key: key);

  @override
  _ComponentControlState createState() => _ComponentControlState();
}

class _ComponentControlState extends State<ComponentControl> {
  double? height;
  String? componentModel;
  String componentToFind = '';

  @override
  void initState() {
    componentModel = widget.node.componentModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CText(
                'Create Component',
                color: Palette.white,
                size: 16,
                weight: FontWeight.w500,
              ),
              Row(
                children: [
                  if (widget.node.textStyleModel == null)
                    GestureDetector(
                      onTap: () {},
                      child: HoverWidget(
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              style: BorderStyle.solid,
                              color: Colors.transparent,
                            ),
                          ),
                          child: Icon(
                            Icons.grid_view,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                        hoverChild: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              style: BorderStyle.solid,
                              color: Colors.white,
                            ),
                          ),
                          child: Icon(
                            Icons.grid_view,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                        onHover: (e) => {},
                      ),
                    ),
                  GestureDetector(
                    onTap: () {
                      if (widget.node.componentModel == null)
                        newTextStylePicker(
                            context, BlocProvider.of<TextStylesBloc>(context));
                      else {
                        widget.node.componentModel = null;
                        //widget.callBack(null, widget.node.componentModel);
                      }
                    },
                    child: HoverWidget(
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            style: BorderStyle.solid,
                            color: Colors.transparent,
                          ),
                        ),
                        child: Icon(
                          (widget.node.textStyleModel == null)
                              ? Icons.add
                              : Icons.remove,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                      hoverChild: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            style: BorderStyle.solid,
                            color: Colors.white,
                          ),
                        ),
                        child: Icon(
                          (widget.node.textStyleModel == null)
                              ? Icons.add
                              : Icons.remove,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                      onHover: (e) => {},
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (widget.node.textStyleModel != null)
            TextButton(
              onPressed: () {},
              child: Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.symmetric(vertical: 14),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(
                    "$componentModel",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  updateComponentModel(String name) {
    //widget.callBack(name, "");
    Navigator.of(context, rootNavigator: true).pop(null);
    setState(() {
      componentModel = name;
    });
  }

  newTextStylePicker(BuildContext context, TextStylesBloc textStylesBloc) {
    TextEditingController editingController = TextEditingController();
    String title = '';
    showDialog<void>(
      context: context,
      builder: (context) {
        return BlocProvider<DeviceModeCubit>(
          create: (BuildContext context) => DeviceModeCubit(),
          child: AlertDialog(
            backgroundColor: Color(0xFF333333),
            title: const CText('Create new component',
                customColor: Colors.white, size: 16),
            content: Container(
              height: 100,
              width: (height! - 200),
              child: Column(
                children: [
                  CMiniTextField(
                    controller: editingController,
                    placeholder: "Text Style",
                    color: Colors.white,
                    callBack: (text) => title = text,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const CText('Cancel', size: 12),
                onPressed: () {
                  //setState(() => fill = pickerColor);
                  Navigator.of(context, rootNavigator: true).pop(null);
                },
              ),
              TextButton(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFF3285FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CText('Create', color: Palette.white, size: 12),
                ),
                onPressed: () {
                  //setState(() => fill = pickerColor);
                  updateComponentModel(title);
                  ProjectRepository().addNewComponents(
                    prj: widget.prj,
                    page: widget.page,
                    node: widget.node,
                    name: title,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}*/
