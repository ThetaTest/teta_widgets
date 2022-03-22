// Flutter imports:
// ignore_for_file: public_member_api_docs, library_private_types_in_public_api

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WTextField extends StatefulWidget {
  /// Returns a TextField widget in Teta
  const WTextField(
    final Key? key, {
    required this.node,
    required this.width,
    required this.value,
    required this.labelText,
    required this.margins,
    required this.paddings,
    required this.fill,
    required this.textStyle,
    required this.forPlay,
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
    required this.action,
    required this.params,
    required this.states,
    required this.dataset,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final FTextTypeInput value;
  final FTextTypeInput labelText;
  final FSize width;
  final FMargins margins;
  final FMargins paddings;
  final FFill fill;
  final bool forPlay;
  final int? loop;
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
  final FAction action;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

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
    if (!widget.forPlay) {
      textEditingController.text = widget.value.value!;
    }

    final borderRadius = widget.borderRadius.get;
    TextStyleModel? model;
    if (widget.textStyle.textStyleModel != null) {
      BlocProvider.of<TextStylesBloc>(context).state.forEach((final element) {
        if (element.name == widget.textStyle.textStyleModel) model = element;
      });
    }
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: Container(
        margin: widget.margins.get(context),
        width: widget.width.get(context: context, isWidth: true),
        decoration: TetaBoxDecoration.get(
          context: context,
          fill: widget.fill.get(context),
          borderRadius: widget.borderRadius,
        ),
        child: TextField(
          controller: textEditingController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: borderRadius,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius,
            ),
            hintText: widget.labelText.get(
              widget.params,
              widget.states,
              widget.dataset,
              widget.forPlay,
              widget.loop,
            ),
            contentPadding: widget.paddings.get(context),
          ),
          style: widget.textStyle.get(context, model),
          textAlign: widget.textStyle.textAlign!.get,
          autocorrect: widget.autoCorrect,
          obscureText: widget.obscureText,
          enabled: widget.forPlay,
          maxLength: int.tryParse(
            widget.maxLenght.get(
              widget.params,
              widget.states,
              widget.dataset,
              widget.forPlay,
              widget.loop,
            ),
          ),
          maxLines: int.tryParse(
                widget.maxLines.get(
                  widget.params,
                  widget.states,
                  widget.dataset,
                  widget.forPlay,
                  widget.loop,
                ),
              ) ??
              1,
          minLines: int.tryParse(
            widget.minLines.get(
              widget.params,
              widget.states,
              widget.dataset,
              widget.forPlay,
              widget.loop,
            ),
          ),
          onChanged: (final text) => GestureBuilder.get(
            context: context,
            node: widget.node,
            gesture: ActionGesture.onChange,
            action: widget.action,
            actionValue: FTextTypeInput(value: text),
            params: widget.params,
            states: widget.states,
            dataset: widget.dataset,
            forPlay: widget.forPlay,
            loop: widget.loop,
          ),
          onSubmitted: (final text) => GestureBuilder.get(
            context: context,
            node: widget.node,
            gesture: ActionGesture.onSubmitted,
            action: widget.action,
            actionValue: FTextTypeInput(value: text),
            params: widget.params,
            states: widget.states,
            dataset: widget.dataset,
            forPlay: widget.forPlay,
            loop: widget.loop,
          ),
        ),
      ),
    );
  }
}
