// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WTextField extends StatefulWidget {
  /// Returns a TextField widget in Teta
  const WTextField(
    final Key? key, {
    required this.state,
    required this.width,
    required this.value,
    required this.labelText,
    required this.margins,
    required this.paddings,
    required this.fill,
    required this.textStyle,
    required this.cursorColor,
    required this.hintTextColor,
    required this.maxLines,
    required this.minLines,
    required this.maxLenght,
    required this.keyboardType,
    required this.showCursor,
    required this.autoCorrect,
    required this.obscureText,
    required this.borderRadius,
    required this.showBorders,
    required this.bordersSize,
    required this.enabledBorderColor,
    required this.focusedBorderColor,
    required this.action,
  }) : super(key: key);

  final TetaWidgetState state;
  final FTextTypeInput value;
  final FTextTypeInput labelText;
  final FSize width;
  final FMargins margins;
  final FMargins paddings;
  final FFill fill;
  final FFill cursorColor;
  final FFill hintTextColor;
  final FTextTypeInput maxLines;
  final FTextTypeInput minLines;
  final FTextTypeInput maxLenght;
  final FKeyboardType keyboardType;
  final bool showCursor;
  final bool autoCorrect;
  final bool obscureText;
  final FTextStyle textStyle;
  final FBorderRadius borderRadius;
  final bool showBorders;
  final FTextTypeInput bordersSize;

  final FFill enabledBorderColor;
  final FFill focusedBorderColor;
  final FAction action;

  @override
  _WTextFieldState createState() => _WTextFieldState();
}

class _WTextFieldState extends State<WTextField> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    textEditingController.text = widget.value.value ?? '';
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    if (!widget.state.forPlay) {
      textEditingController.text = widget.value.value!;
    }

    final borderRadius = widget.borderRadius.get(context);
    TextStyleModel? model;
    if (widget.textStyle.textStyleModel != null) {
      BlocProvider.of<TextStylesCubit>(context).state.forEach((final element) {
        if (element.name == widget.textStyle.textStyleModel) model = element;
      });
    }
    final tempOpacity = widget.fill.levels?.first.opacity ?? 1;
    final opacity = tempOpacity >= 0 && tempOpacity <= 1 ? tempOpacity : 1.0;

    final tempBorderOpacity =
        widget.enabledBorderColor.levels?.first.opacity ?? 1;
    final borderOpacity = tempBorderOpacity >= 0 && tempBorderOpacity <= 1
        ? tempBorderOpacity
        : 1.0;

    final tempFocusOpacity =
        widget.focusedBorderColor.levels?.first.opacity ?? 1;
    final focusOpacity =
        tempFocusOpacity >= 0 && tempFocusOpacity <= 1 ? tempFocusOpacity : 1.0;

    final tempHintOpacity = widget.hintTextColor.levels?.first.opacity ?? 1;
    final hintOpacity =
        tempHintOpacity >= 0 && tempHintOpacity <= 1 ? tempHintOpacity : 1.0;
    return NodeSelectionBuilder(
      state: widget.state,
      child: Center(
        child: TContainer(
          margin: widget.margins.get(context),
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius.get(context),
          ),
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              filled: true,
              fillColor: HexColor(widget.fill.get(context).getHexColor(context))
                  .withOpacity(opacity),
              counterStyle: TextStyle(
                color: HexColor(widget.fill.get(context).getHexColor(context))
                    .withOpacity(opacity),
              ),
              border: OutlineInputBorder(
                borderRadius: borderRadius,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.showBorders
                      ? HexColor(
                          widget.enabledBorderColor
                              .get(context)
                              .getHexColor(context),
                        ).withOpacity(
                          borderOpacity,
                        )
                      : Colors.transparent,
                  width: double.tryParse(
                        widget.bordersSize.get(
                          widget.state.params,
                          widget.state.states,
                          widget.state.dataset,
                          widget.state.forPlay,
                          widget.state.loop,
                          context,
                        ),
                      ) ??
                      1,
                ),
                borderRadius: borderRadius,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.showBorders
                      ? HexColor(
                          widget.focusedBorderColor
                              .get(context)
                              .getHexColor(context),
                        ).withOpacity(
                          focusOpacity,
                        )
                      : Colors.transparent,
                  width: double.tryParse(
                        widget.bordersSize.get(
                          widget.state.params,
                          widget.state.states,
                          widget.state.dataset,
                          widget.state.forPlay,
                          widget.state.loop,
                          context,
                        ),
                      ) ??
                      1,
                ),
                borderRadius: borderRadius,
              ),
              hintText: widget.labelText.get(
                widget.state.params,
                widget.state.states,
                widget.state.dataset,
                widget.state.forPlay,
                widget.state.loop,
                context,
              ),
              hintStyle: TextStyle(
                color: HexColor(
                  widget.hintTextColor.get(context).getHexColor(context),
                ).withOpacity(
                  hintOpacity,
                ),
              ),
              contentPadding: widget.paddings.get(context),
            ),
            style: widget.textStyle.get(context, model),
            textAlign: widget.textStyle.textAlign!.get,
            autocorrect: widget.autoCorrect,
            obscureText: widget.obscureText,
            maxLength: int.tryParse(
              widget.maxLenght.get(
                widget.state.params,
                widget.state.states,
                widget.state.dataset,
                widget.state.forPlay,
                widget.state.loop,
                context,
              ),
            ),
            maxLines: int.tryParse(
                  widget.maxLines.get(
                    widget.state.params,
                    widget.state.states,
                    widget.state.dataset,
                    widget.state.forPlay,
                    widget.state.loop,
                    context,
                  ),
                ) ??
                1,
            minLines: int.tryParse(
              widget.minLines.get(
                widget.state.params,
                widget.state.states,
                widget.state.dataset,
                widget.state.forPlay,
                widget.state.loop,
                context,
              ),
            ),
            enabled: widget.state.forPlay,
            onChanged: (final text) {
              if (!widget.state.forPlay) return;
              GestureBuilder.get(
                context: context,
                state: widget.state,
                gesture: ActionGesture.onChange,
                action: widget.action,
                actionValue: FTextTypeInput(value: text),
              );
            },
            onSubmitted: (final text) {
              if (!widget.state.forPlay) return;
              GestureBuilder.get(
                context: context,
                state: widget.state,
                gesture: ActionGesture.onSubmitted,
                action: widget.action,
                actionValue: FTextTypeInput(value: text),
              );
            },
          ),
        ),
      ),
    );
  }
}
