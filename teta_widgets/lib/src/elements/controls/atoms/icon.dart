// Dart imports:

// ignore_for_file: import_of_legacy_library_into_null_safe, public_member_api_docs, avoid_equals_and_hash_code_on_mutable_classes, lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/icon_map.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:teta_core/src/cubits/google_fonts/cubit.dart';
import 'package:teta_core/src/design_system/text.dart';
import 'package:teta_core/src/design_system/textfield/minitextfield.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/nodes/node.dart';

class IconControl extends StatefulWidget {
  const IconControl({
    required this.node,
    required this.icon,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final CNode node;
  final String icon;
  final Function(String, String) callBack;

  @override
  IconControlState createState() => IconControlState();
}

class IconControlState extends State<IconControl> {
  double? height;
  String? iconState;
  String textToFind = '';

  @override
  void initState() {
    iconState = widget.icon;
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CText(
          'Icon',
          typography: Headline3(),
        ),
        TextButton(
          onPressed: showPicker,
          child: Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.symmetric(vertical: 14),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(
                MdiIcons.fromString(widget.icon),
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }

  void updateFont(final MapEntry style) {
    widget.callBack(
      style.key as String,
      widget.icon,
    );
    Navigator.of(context, rootNavigator: true).pop(null);
    setState(() {
      iconState = style.key as String;
    });
  }

  void showPicker() {
    showDialog<void>(
      context: context,
      builder: (final context) {
        final icons = iconMap.keys.map(IconDefinition.new).toList();
        final editingController = TextEditingController();
        var filteredIcons = icons.sublist(0, 64);
        var after = 0;
        var query = '';
        final scrollController = ScrollController();
        var index = 0;

        final cubit = GoogleFontsCubit()..updateTextToFind('');
        return StatefulBuilder(
          builder: (final context, final setState) =>
              BlocProvider<GoogleFontsCubit>(
            create: (final context) => cubit,
            child: AlertDialog(
              backgroundColor: const Color(0xFF222222),
              title: CupertinoSegmentedControl(
                children: const <int, Widget>{
                  0: CText(
                    'Material',
                    typography: Headline3(),
                  ),
                  1: CText(
                    'Material',
                    typography: Headline3(),
                  ),
                },
                onValueChanged: (final i) {},
              ),
              content: BlocBuilder<GoogleFontsCubit, String>(
                bloc: cubit,
                builder: (final context, final state) {
                  scrollController.addListener(() {
                    if (scrollController.position.atEdge) {
                      if (scrollController.position.pixels == 0) {
                      } else {
                        setState(
                          () {
                            after += 48;
                            filteredIcons.addAll(
                              loadIcons(
                                query,
                                64,
                                after,
                                icons,
                              ),
                            );
                          },
                        ); // Load next documents
                      }
                    }
                  });
                  return SizedBox(
                    height: 380,
                    width: 400,
                    child: Column(
                      children: [
                        CMiniTextField(
                          controller: editingController,
                          placeholder: 'Write here',
                          color: Colors.white,
                          callBack: (final text) {
                            cubit.updateTextToFind(text);
                            setState(() {
                              query = text;
                              after = 0;
                              filteredIcons = loadIcons(
                                query,
                                64,
                                after,
                                icons,
                              );
                            });
                          },
                        ),
                        const Divider(
                          height: 1,
                          color: Colors.black12,
                        ),
                        SizedBox(
                          height: 326,
                          child: GridView.builder(
                            controller: scrollController,
                            itemCount: filteredIcons.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 8,
                            ),
                            itemBuilder: (final context, final index) {
                              final icon = filteredIcons[index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    iconState = icon.title;
                                  });
                                  final old = widget.icon;
                                  final newIcon = icon.title;
                                  widget.callBack(newIcon!, old);
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(null);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Center(
                                    child: Icon(
                                      icon.iconData,
                                      size: 32,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    //setState(() => fill = pickerColor);
                    Navigator.of(context, rootNavigator: true).pop(null);
                  },
                  child: const CText(
                    'Cancel',
                    typography: ActionLabel(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

List<IconDefinition> loadIcons(
  final String query,
  final int limit,
  final int after,
  final Iterable<IconDefinition> icons,
) {
  var list = icons
      .where(
        (final icon) => icon.title!.toLowerCase().contains(
              query.toLowerCase(),
            ),
      )
      .skip(after)
      .toList();

  if (list.length > limit) list = list.sublist(0, limit);
  return list;
}

final _iconLib = MdiIcons();

class IconDefinition implements Comparable<IconDefinition> {
  IconDefinition(final String key) {
    iconData = _iconLib[key];
    title = toKebabCase(key);
  }

  IconData? iconData;
  String? title;

  String toKebabCase(final String str) {
    return str
        .replaceAllMapped(
          RegExp(
            r'[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+',
          ),
          (final Match m) => '${m[0]!.toLowerCase()}_',
        )
        .split(RegExp(r'(_|\s)+'))
        .takeWhile((final value) => value != '')
        .join('-');
  }

  @override
  String toString() => 'IconDefinition{iconData: $iconData, title: $title}';

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is IconDefinition &&
          runtimeType == other.runtimeType &&
          iconData == other.iconData &&
          title == other.title;

  @override
  int get hashCode => iconData.hashCode ^ title.hashCode;

  @override
  int compareTo(final IconDefinition other) =>
      title!.compareTo(other.title ?? '');
}
