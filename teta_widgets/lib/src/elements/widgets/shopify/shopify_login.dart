/*import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_editor/src/blocs/focus_project/index.dart';
import 'package:mobile_editor/src/blocs/palette/index.dart';
import 'package:mobile_editor/src/blocs/text_styles/index.dart';
import 'package:mobile_editor/src/cubits/mixpanel/cubit.dart';
import 'package:mobile_editor/src/design_system/hex_color.dart';
import 'package:mobile_editor/src/elements/drag_target.dart';
import 'package:mobile_editor/src/elements/draggable.dart';
import 'package:mobile_editor/src/elements/features/align.dart';
import 'package:mobile_editor/src/elements/features/border_radius.dart';
import 'package:mobile_editor/src/elements/features/fill.dart';
import 'package:mobile_editor/src/elements/features/font_size.dart';
import 'package:mobile_editor/src/elements/features/font_style.dart';
import 'package:mobile_editor/src/elements/features/font_weight.dart';
import 'package:mobile_editor/src/elements/features/keyboard_type.dart';
import 'package:mobile_editor/src/elements/features/margins.dart';
import 'package:mobile_editor/src/elements/features/page_transition.dart';
import 'package:mobile_editor/src/elements/features/sizes.dart';
import 'package:mobile_editor/src/elements/features/text_align.dart';
import 'package:mobile_editor/src/elements/features/text_decoration.dart';
import 'package:mobile_editor/src/elements/features/text_type_input.dart';
import 'package:mobile_editor/src/elements/node_selection.dart';
import 'package:mobile_editor/src/elements/nodes/button.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/elements/nodes/text.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/palette.dart';
import 'package:mobile_editor/src/models/text_style.dart';
import 'package:mobile_editor/src/models/variable.dart';
import 'package:mobile_editor/src/utils/shopify/flutter_simple_shopify.dart';
import 'package:mobile_editor/src/utils/shopify/models/models.dart';
import 'package:nil/nil.dart';

class WShopifyLogin extends StatefulWidget {
  final CNode node;
  final FSize sizes;
  final FMargins margins;
  final FMargins paddings;
  final FFill fill;
  final FFill textFill;
  final String? cursorColor;
  final String? hintTextColor;
  final double? maxLines;
  final double? minLines;
  final double? maxLenght;
  final FKeyboardType keyboardType;
  final bool? showCursor;
  final bool? autoCorrect;
  final bool? obscureText;
  final FFontSize fontSize;
  final String? fontFamily;
  final FFontWeight fontWeight;
  final FTextDecoration textDecoration;
  final FTextAlign textAlign;
  final FFontStyle fontStyle;
  final FBorderRadius borderRadius;
  final FTextTypeInput btnValue;
  final FSize btnSizes;
  final FMargins btnMargins;
  final FMargins btnPaddings;
  final FBorderRadius btnBorderRadius;
  final FFill btnFill;
  final FFill btnTextFill;
  final FFontSize btnFontSize;
  final String? btnFontFamily;
  final FFontWeight btnFontWeight;
  final FTextDecoration btnTextDecoration;
  final FTextAlign btnTextAlign;
  final FFontStyle btnFontStyle;
  final bool? linkOrAction;
  final String? linkToPage;
  final FPageTransition pageTransition;
  final String? textStyleModel;
  final String? btnTextStyleModel;
  final bool forPlay;
  final double? index;
  final String? component;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  WShopifyLogin({
    required this.node,
    required this.sizes,
    required this.margins,
    required this.paddings,
    required this.fill,
    required this.textFill,
    this.cursorColor,
    this.hintTextColor,
    this.maxLines,
    this.minLines,
    this.maxLenght,
    required this.keyboardType,
    this.showCursor,
    this.autoCorrect,
    this.obscureText,
    required this.fontSize,
    this.fontFamily,
    required this.fontWeight,
    required this.textDecoration,
    required this.textAlign,
    required this.fontStyle,
    required this.borderRadius,
    required this.btnValue,
    required this.btnSizes,
    required this.btnMargins,
    required this.btnPaddings,
    required this.btnBorderRadius,
    required this.btnFill,
    required this.btnTextFill,
    required this.btnFontSize,
    this.btnFontFamily,
    required this.btnFontWeight,
    required this.btnTextDecoration,
    required this.btnTextAlign,
    required this.btnFontStyle,
    required this.align,
    this.linkOrAction,
    this.linkToPage,
    required this.pageTransition,
    this.textStyleModel,
    this.btnTextStyleModel,
    required this.forPlay,
    this.index,
    this.component,
    this.loop,
    required this.params,
    required this.states,
    required this.dataset,
  });

  @override
  _WShopifyLoginState createState() => _WShopifyLoginState();
}

class _WShopifyLoginState extends State<WShopifyLogin> {
  bool isLoading = false;
  bool isLoggedError = false;
  String? email;
  String? password;

  Widget build(BuildContext context) {
    return (!widget.forPlay)
        ? DraggableNode(
            node: widget.node,
            child: NodeSelection(
              node: widget.node,
              index: widget.index ?? 0,
              forPlay: widget.forPlay,
              nid: widget.node.nid,
              child: body(context),
            ),
            forPlay: widget.forPlay,
          )
        : body(context);
  }

  Widget body(BuildContext context) {
    return BlocBuilder<PaletteBloc, List<PaletteModel>>(
      builder: (context, state) {
        if (state.isNotEmpty) {
          FFill? accentFill;
          FFill? backgroundSecondaryFill;
          FFill? textFill;
          state.forEach((element) {
            if (element.name == "Accent") accentFill = element.fill!;
            if (element.name == "Background / Secondary")
              backgroundSecondaryFill = element.fill!;
            if (element.name == "Text / Primary") textFill = element.fill!;
          });
          return Center(
            child: DragTargetWidget(
              node: widget.node,
              width: 50,
              height: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NText(
                    nid: 'Ciao',
                    value: FTextTypeInput(
                      type: FTextTypeEnum.text,
                      value: 'Email',
                    ),
                    textStyleModel: "Detail",
                    fontSize: FFontSize(sizes: [16, 20, 20]),
                    fontWeight: FFontWeight(fontWeights: [
                      FontWeight.w400,
                      FontWeight.w400,
                      FontWeight.w400,
                    ]),
                    margins: FMargins(margins: [
                      ["16", "0", "0", "0"],
                      ["16", "0", "0", "0"],
                      ["16", "0", "0", "0"]
                    ]),
                    fill: FFill(paletteStyle: "xXHoXe56355C+p5"),
                    isFullWidth: false,
                  ).toWidget(
                    forPlay: widget.forPlay,
                    params: [...widget.params, ...widget.params],
                    states: widget.states,
                    dataset: widget.dataset,
                    loop: 0,
                  ),
                  textField(context, false, (value) {
                    setState(() {
                      email = value;
                    });
                  }),
                  NText(
                    nid: 'Ciao',
                    value: FTextTypeInput(
                      type: FTextTypeEnum.text,
                      value: 'Password',
                    ),
                    textStyleModel: "Detail",
                    fontSize: FFontSize(sizes: [16, 20, 20]),
                    fontWeight: FFontWeight(fontWeights: [
                      FontWeight.w400,
                      FontWeight.w400,
                      FontWeight.w400,
                    ]),
                    margins: FMargins(margins: [
                      ["16", "8", "0", "0"],
                      ["16", "8", "0", "0"],
                      ["16", "8", "0", "0"]
                    ]),
                    fill: FFill(paletteStyle: "xXHoXe56355C+p5"),
                    isFullWidth: false,
                  ).toWidget(
                    forPlay: widget.forPlay,
                    params: [...widget.params, ...widget.params],
                    states: widget.states,
                    dataset: widget.dataset,
                    loop: 0,
                  ),
                  textField(context, true, (value) {
                    setState(() {
                      password = value;
                    });
                  }),
                  GestureDetector(
                    onTap: () async {
                      if (widget.forPlay) {
                        final res = await login(context);
                        print(res);
                        if (!res) {
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                backgroundColor: HexColor(
                                    backgroundSecondaryFill!
                                        .levels!.first.color),
                                content: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    NText(
                                      nid: 'Ciao',
                                      value: FTextTypeInput(
                                        type: FTextTypeEnum.text,
                                        value: 'Loading',
                                      ),
                                      textStyleModel: "Detail",
                                      fontSize: FFontSize(sizes: [16, 20, 20]),
                                      fontWeight: FFontWeight(fontWeights: [
                                        FontWeight.w400,
                                        FontWeight.w400,
                                        FontWeight.w400,
                                      ]),
                                      margins: FMargins(margins: [
                                        ["16", "8", "0", "0"],
                                        ["16", "8", "0", "0"],
                                        ["16", "8", "0", "0"]
                                      ]),
                                      fill: FFill(
                                          paletteStyle: "xXHoXe56355C+p5"),
                                      isFullWidth: false,
                                    ).toWidget(
                                      forPlay: widget.forPlay,
                                      params: [
                                        ...widget.params,
                                        ...widget.params
                                      ],
                                      states: widget.states,
                                      dataset: widget.dataset,
                                      loop: 0,
                                    ),
                                    CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          HexColor(
                                              accentFill!.levels!.first.color)),
                                    ),
                                  ],
                                ),
                              ),
                            );
                        } else {
                          if (widget.linkToPage != null) {
                            final ProjectLoaded prj =
                                BlocProvider.of<FocusProjectBloc>(context).state
                                    as ProjectLoaded;
                            final page = prj.prj.pages!.firstWhere(
                                (element) => element.id == widget.linkToPage);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => page.scaffold!.toWidget(
                                  forPlay: widget.forPlay,
                                  params: widget.params,
                                  states: widget.states,
                                  dataset: widget.dataset,
                                ),
                              ),
                            );
                          }
                        }
                      }
                    },
                    child: AbsorbPointer(
                      child: NButton(
                        margins: widget.btnMargins,
                        paddings: widget.btnPaddings,
                        fill: widget.btnFill,
                        value: widget.btnValue,
                        sizes: widget.btnSizes,
                        borderRadius: widget.btnBorderRadius,
                        textFill: widget.btnTextFill,
                        fontSize: widget.btnFontSize,
                        fontFamily: widget.btnFontFamily,
                        fontWeight: widget.btnFontWeight,
                        textDecoration: widget.btnTextDecoration,
                        textAlign: widget.btnTextAlign,
                        fontStyle: widget.btnFontStyle,
                        textAlignPosition: FAlign(aligns: [
                          Alignment.center,
                          Alignment.center,
                          Alignment.center,
                        ]),
                        level: -1,
                        linkOrAction: true,
                        textStyleModel: widget.btnTextStyleModel,
                      ).toWidget(
                        loop: 0,
                        params: widget.params,
                        states: widget.states,
                        dataset: widget.dataset,
                        forPlay: widget.forPlay,
                      ),
                    ),
                  ),
                  if (isLoggedError)
                    NText(
                      nid: 'Ciao',
                      value: FTextTypeInput(
                        type: FTextTypeEnum.text,
                        value: 'Login failed',
                      ),
                      textStyleModel: "Detail",
                      fontSize: FFontSize(sizes: [16, 20, 20]),
                      fontWeight: FFontWeight(fontWeights: [
                        FontWeight.w400,
                        FontWeight.w400,
                        FontWeight.w400,
                      ]),
                      margins: FMargins(margins: [
                        ["16", "8", "0", "0"],
                        ["16", "8", "0", "0"],
                        ["16", "8", "0", "0"]
                      ]),
                      fill: FFill(
                        type: FFillType.solid,
                        levels: [
                          FFillElement(
                            color: 'ff0000',
                            stop: 0,
                          )
                        ],
                      ),
                      isFullWidth: false,
                    ).toWidget(
                      forPlay: widget.forPlay,
                      params: [...widget.params, ...widget.params],
                      states: widget.states,
                      dataset: widget.dataset,
                      loop: 0,
                    ),
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget textField(
      BuildContext context, bool isObscure, Function(String) callBack) {
    return BlocBuilder<PaletteBloc, List<PaletteModel>>(
      builder: (context, state) {
        if (state.isNotEmpty) {
          final szs = widget.sizes.get(context);
          final radius = widget.borderRadius.get(context);
          FFill? finalFill;
          if (state.isNotEmpty)
            state.forEach((element) {
              if (element.id == widget.fill.paletteStyle)
                finalFill = element.fill!;
            });
          if (finalFill == null) finalFill = widget.fill;
          final decoration = finalFill!.type == FFillType.solid
              ? BoxDecoration(
                  color: HexColor(finalFill!.levels![0].color),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius[0]),
                    topRight: Radius.circular(radius[1]),
                    bottomRight: Radius.circular(radius[2]),
                    bottomLeft: Radius.circular(radius[3]),
                  ),
                )
              : finalFill!.type == FFillType.linearGradient
                  ? BoxDecoration(
                      gradient: LinearGradient(
                        colors: finalFill!.levels!
                            .map((e) => HexColor(e.color))
                            .toList(),
                        begin: finalFill!.begin!,
                        end: finalFill!.end!,
                        stops: finalFill!.levels!.map((e) => e.stop).toList(),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radius[0]),
                        topRight: Radius.circular(radius[1]),
                        bottomRight: Radius.circular(radius[2]),
                        bottomLeft: Radius.circular(radius[3]),
                      ),
                    )
                  : finalFill!.type == FFillType.radialGradient
                      ? BoxDecoration(
                          gradient: RadialGradient(
                            colors: finalFill!.levels!
                                .map((e) => HexColor(e.color))
                                .toList(),
                            center: finalFill!.center!,
                            radius: finalFill!.radius!,
                            stops:
                                finalFill!.levels!.map((e) => e.stop).toList(),
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radius[0]),
                            topRight: Radius.circular(radius[1]),
                            bottomRight: Radius.circular(radius[2]),
                            bottomLeft: Radius.circular(radius[3]),
                          ),
                        )
                      : BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              finalFill!.levels![0].color,
                            ),
                            fit: finalFill!.boxFit!.get(context),
                          ),
                        );
          return (szs.unit == SizeUnit.percent)
              ? Container(
                  margin: widget.margins.get(context),
                  padding: widget.paddings.get(context),
                  width:
                      widget.sizes.get(context).get(context, widget.forPlay)[0],
                  height:
                      widget.sizes.get(context).get(context, widget.forPlay)[1],
                  decoration: decoration,
                  child: childCondition(radius, isObscure, callBack),
                )
              : Container(
                  width:
                      widget.sizes.get(context).get(context, widget.forPlay)[0],
                  height:
                      widget.sizes.get(context).get(context, widget.forPlay)[1],
                  decoration: decoration,
                  margin: widget.margins.get(context),
                  padding: widget.paddings.get(context),
                  child: childCondition(radius, isObscure, callBack),
                );
        } else
          return const SizedBox();
      },
    );
  }

  Widget childCondition(
      List<double> radius, bool isObscure, Function(String) callBack) {
    return BlocBuilder<PaletteBloc, List<PaletteModel>>(
      builder: (context, state) {
        FFill? finalFill;
        if (state.isNotEmpty)
          state.forEach((element) {
            if (element.id == widget.fill.paletteStyle)
              finalFill = element.fill!;
          });
        if (finalFill == null) finalFill = widget.textFill;
        TextStyleModel? model;
        if (widget.textStyleModel != null) {
          BlocProvider.of<TextStylesBloc>(context).state.forEach((element) {
            if (element.name == widget.textStyleModel) model = element;
          });
        }

        TextStyle? textStyle;
        if (widget.fill.type == FFillType.solid) {
          textStyle = GoogleFonts.getFont(
            (model != null)
                ? model!.fontFamily!
                : (widget.fontFamily != null)
                    ? widget.fontFamily!
                    : "Poppins",
            fontSize: (model != null)
                ? model!.fontSize!.get(context)
                : widget.fontSize.get(context),
            fontWeight: (model != null)
                ? model!.fontWeight!.get(context)
                : widget.fontWeight.get(context),
            color: HexColor(finalFill!.levels![0].color),
            decoration: widget.textDecoration.get(context),
            fontStyle: widget.fontStyle.get(),
          );
        } else if (widget.fill.type == FFillType.linearGradient) {
          textStyle = GoogleFonts.getFont(
            (model != null)
                ? model!.fontFamily!
                : (widget.fontFamily != null)
                    ? widget.fontFamily!
                    : "Poppins",
            fontSize: (model != null)
                ? model!.fontSize!.get(context)
                : widget.fontSize.get(context),
            fontWeight: (model != null)
                ? model!.fontWeight!.get(context)
                : widget.fontWeight.get(context),
            decoration: widget.textDecoration.get(context),
            fontStyle: widget.fontStyle.get(),
            foreground: Paint()
              ..shader = LinearGradient(
                colors:
                    finalFill!.levels!.map((e) => HexColor(e.color)).toList(),
                stops: finalFill!.levels!.map((e) => e.stop).toList(),
                begin: finalFill!.begin!,
                end: finalFill!.end!,
              ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
          );
        } else if (widget.fill.type == FFillType.radialGradient) {
          textStyle = GoogleFonts.getFont(
            (model != null)
                ? model!.fontFamily!
                : (widget.fontFamily != null)
                    ? widget.fontFamily!
                    : "Poppins",
            fontSize: (model != null)
                ? model!.fontSize!.get(context)
                : widget.fontSize.get(context),
            fontWeight: (model != null)
                ? model!.fontWeight!.get(context)
                : widget.fontWeight.get(context),
            decoration: widget.textDecoration.get(context),
            fontStyle: widget.fontStyle.get(),
            foreground: Paint()
              ..shader = RadialGradient(
                colors:
                    finalFill!.levels!.map((e) => HexColor(e.color)).toList(),
                stops: finalFill!.levels!.map((e) => e.stop).toList(),
                center: finalFill!.center!,
                radius: finalFill!.radius!,
              ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
          );
        }

        //TextEditingController textEditingController = TextEditingController();
        return TextField(
          onChanged: (text) {
            setState(() {
              isLoggedError = false;
            });
            callBack(text);
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius[0]),
                topRight: Radius.circular(radius[1]),
                bottomRight: Radius.circular(radius[2]),
                bottomLeft: Radius.circular(radius[3]),
              ),
              borderSide: BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius[0]),
                topRight: Radius.circular(radius[1]),
                bottomRight: Radius.circular(radius[2]),
                bottomLeft: Radius.circular(radius[3]),
              ),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius[0]),
                topRight: Radius.circular(radius[1]),
                bottomRight: Radius.circular(radius[2]),
                bottomLeft: Radius.circular(radius[3]),
              ),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          style: textStyle!,
          textAlign: widget.textAlign.get(context),
          autocorrect: false,
          obscureText: isObscure,
          enabled: widget.forPlay,
        );
      },
    );
  }

  Future<bool> login(BuildContext context) async {
    if (email != null && password != null) {
      try {
        setState(() {
          isLoading = true;
        });
        ShopifyAuth shopifyAuth = ShopifyAuth.instance;
        final ShopifyUser? user = await shopifyAuth.signInWithEmailAndPassword(
            email: email!, password: password!);
        setState(() {
          isLoading = false;
          isLoggedError = user != null ? false : true;
        });
        if (user != null)
          BlocProvider.of<MixPanelCubit>(context).addUser(user.id!);
        return user != null;
      } catch (e) {
        print(e);
        setState(() {
          isLoading = false;
          isLoggedError = true;
        });
        return false;
      }
    }
    return false;
  }
}
*/
