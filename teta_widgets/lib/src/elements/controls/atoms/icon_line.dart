// Dart imports:

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
// ignore_for_file: import_of_legacy_library_into_null_safe, public_member_api_docs, avoid_equals_and_hash_code_on_mutable_classes, lines_longer_than_80_chars

import 'package:line_icons/line_icons.dart';
import 'package:teta_core/src/design_system/textfield/textfield.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:universal_platform/universal_platform.dart';

class IconLineControl extends StatefulWidget {
  const IconLineControl({
    required this.icon,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final String icon;
  final Function(String, String) callBack;

  @override
  IconLineControlState createState() => IconLineControlState();
}

class IconLineControlState extends State<IconLineControl> {
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
        const TParagraph(
          'Line Icon',
        ),
        BounceSmall(
          message: 'Change icon',
          onTap: showPicker,
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
                LineIcons.byName(iconState ?? 'plus'),
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
        final icons =
            LineIcons.values.keys.map(LineIconDefinition.new).toList();
        final editingController = TextEditingController();
        var filteredIcons = icons.sublist(0, 64);
        var after = 0;
        var query = '';
        final scrollController = ScrollController();

        final cubit = GoogleFontsCubit()..updateTextToFind('');
        return StatefulBuilder(
          builder: (final context, final setState) =>
              BlocProvider<GoogleFontsCubit>(
            create: (final context) => cubit,
            child: AlertDialog(
              backgroundColor: Palette.bgDialog,
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
                        );
                      }
                    }
                  });
                  return SizedBox(
                    height: 400,
                    width: 400,
                    child: Column(
                      children: [
                        CTextField(
                          controller: editingController,
                          placeholder: 'Write here',
                          autofocus: UniversalPlatform.isDesktopOrWeb,
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
                        const Gap(Grid.small),
                        SizedBox(
                          height: 340,
                          child: GridView.builder(
                            controller: scrollController,
                            itemCount: filteredIcons.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemBuilder: (final context, final index) {
                              final icon = filteredIcons[index];
                              return BounceSmall(
                                message: icon.title,
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
                                  height: 32,
                                  width: 32,
                                  padding: EI.smA,
                                  decoration: const BoxDecoration(
                                    color: Palette.bgTertiary,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      icon.iconData,
                                      size: 28,
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
                CButton(
                  label: 'Cancel',
                  maxWidth: 80,
                  isPrimary: false,
                  callback: () {
                    Navigator.of(context, rootNavigator: true).pop(null);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

List<LineIconDefinition> loadIcons(
  final String query,
  final int limit,
  final int after,
  final Iterable<LineIconDefinition> icons,
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

class LineIconDefinition implements Comparable<LineIconDefinition> {
  LineIconDefinition(final String key) {
    iconData = LineIcons.byName(key);
    title = key;
  }

  IconData? iconData;
  String? title;

  @override
  String toString() => 'LineIconDefinition{iconData: $iconData, title: $title}';

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is LineIconDefinition &&
          runtimeType == other.runtimeType &&
          iconData == other.iconData &&
          title == other.title;

  @override
  int get hashCode => iconData.hashCode ^ title.hashCode;

  @override
  int compareTo(final LineIconDefinition other) =>
      title!.compareTo(other.title ?? '');
}
