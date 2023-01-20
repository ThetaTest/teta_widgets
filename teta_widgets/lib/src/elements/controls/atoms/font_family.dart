// Dart imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teta_core/src/design_system/textfield/minitextfield.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/text_style.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class FontFamilyControl extends StatefulWidget {
  const FontFamilyControl({
    required this.textStyle,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final FTextStyle textStyle;
  final Function(Map<String, dynamic>, Map<String, dynamic>) callBack;

  @override
  FontFamilyState createState() => FontFamilyState();
}

class FontFamilyState extends State<FontFamilyControl> {
  double? height;
  String textToFind = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TParagraph(
          'Font Family',
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: CButton(
            callback: showPicker,
            label: widget.textStyle.fontFamily,
          ),
        )
      ],
    );
  }

  void updateFont(final MapEntry style) {
    final old = FTextStyle.fromJson(widget.textStyle.toJson());
    widget.textStyle.fontFamily = style.key as String;
    widget.callBack(
      widget.textStyle.toJson(),
      old.toJson(),
    );
    Navigator.of(context, rootNavigator: true).pop(null);
  }

  void showPicker() {
    showDialog<void>(
      context: context,
      builder: (final context) {
        final editingController = TextEditingController();
        final list = GoogleFonts.asMap().entries.toList();
        var filteredFontFamily = list.sublist(0, 8);
        var after = 0;
        var query = '';
        final scrollController = ScrollController();
        final cubit = GoogleFontsCubit();
        return StatefulBuilder(
          builder: (final context, final setState) =>
              BlocProvider<GoogleFontsCubit>(
            create: (final context) => cubit,
            child: AlertDialog(
              backgroundColor: const Color(0xFF333333),
              title: const TAlertTitle(
                'Choose yout font family',
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
                            after += 8;
                            filteredFontFamily.addAll(
                              loadIcons(
                                query,
                                8,
                                after,
                                list,
                              ),
                            );
                          },
                        ); // Load next documents
                      }
                    }
                  });
                  return SizedBox(
                    height: 400,
                    width: height! - 200,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: CMiniTextField(
                            controller: editingController,
                            placeholder: widget.textStyle.fontFamily,
                            callBack: (final text) {
                              cubit.updateTextToFind(text);
                              setState(() {
                                query = text;
                                after = 0;
                                filteredFontFamily = loadIcons(
                                  query,
                                  64,
                                  after,
                                  list,
                                );
                              });
                            },
                          ),
                        ),
                        const Divider(
                          height: 1,
                          color: Colors.black12,
                        ),
                        SizedBox(
                          height: 326,
                          child: BlocBuilder<GoogleFontsCubit, String>(
                            bloc: cubit,
                            builder: (final context, final state) {
                              return ListView.builder(
                                addAutomaticKeepAlives: false,
                                addRepaintBoundaries: false,
                                controller: scrollController,
                                itemCount: filteredFontFamily.length,
                                itemBuilder: (final context, final index) {
                                  return GestureDetector(
                                    onTap: () {
                                      updateFont(filteredFontFamily[index]);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            filteredFontFamily[index].key,
                                            style: const TextStyle(
                                              fontSize: 24,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: Text(
                                              'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
                                              style: TextStyle(
                                                fontFamily:
                                                    filteredFontFamily[index]
                                                        .value()
                                                        .fontFamily,
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Divider(
                                              height: 1,
                                              color: Colors.black12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                shrinkWrap: true,
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
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

List<
    MapEntry<
        String,
        TextStyle Function({
  Paint? background,
  Color? backgroundColor,
  Color? color,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
  List<FontFeature>? fontFeatures,
  double? fontSize,
  FontStyle? fontStyle,
  FontWeight? fontWeight,
  Paint? foreground,
  double? height,
  double? letterSpacing,
  Locale? locale,
  List<Shadow>? shadows,
  TextBaseline? textBaseline,
  TextStyle? textStyle,
  double? wordSpacing,
})>> loadIcons(
  final String query,
  final int limit,
  final int after,
  final List<
          MapEntry<
              String,
              TextStyle Function({
    Paint? background,
    Color? backgroundColor,
    Color? color,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    List<FontFeature>? fontFeatures,
    double? fontSize,
    FontStyle? fontStyle,
    FontWeight? fontWeight,
    Paint? foreground,
    double? height,
    double? letterSpacing,
    Locale? locale,
    List<Shadow>? shadows,
    TextBaseline? textBaseline,
    TextStyle? textStyle,
    double? wordSpacing,
  })>>
      listFonFamily,
) {
  var list = listFonFamily
      .where(
        (final fontFamily) => fontFamily.key.toLowerCase().contains(
              query.toLowerCase(),
            ),
      )
      .skip(after)
      .toList();

  if (list.length > limit) list = list.sublist(0, limit);
  return list;
}
