// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_repositories/src/node_repository.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/builder/gesture_detector_base.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WText extends StatefulWidget {
  /// Returns a Text widget in Teta
  const WText(
    final Key? key, {
    required this.state,
    required this.value,
    required this.textStyle,
    required this.isFullWidth,
    required this.maxLines,
  }) : super(key: key);

  final TetaWidgetState state;
  final FTextTypeInput value;
  final FTextStyle textStyle;
  final bool isFullWidth;
  final FTextTypeInput maxLines;

  @override
  State<WText> createState() => _WTextState();
}

class _WTextState extends State<WText> with AfterLayoutMixin {
  final TextEditingController _controller = TextEditingController();
  bool isEditing = false;
  final FocusNode focusNode = FocusNode();

  @override
  FutureOr<void> afterFirstLayout(final BuildContext context) {
    _controller.text = widget.value.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
  }

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      state: widget.state,
      child: BlocBuilder<ColorStylesCubit, List<ColorStyleModel>>(
        buildWhen: (final previous, final current) => current != previous,
        builder: (final context, final state) {
          FFill? finalFill;
          if (state.isNotEmpty) {
            for (final e in state) {
              if (e.id == widget.textStyle.fill!.paletteStyle) {
                finalFill = e.fill;
              }
              if (e.name == widget.textStyle.fill!.paletteStyle) {
                finalFill = e.fill;
              }
            }
          }
          finalFill ??= widget.textStyle.fill!;

          TextStyleModel? model;
          if (widget.textStyle.textStyleModel != null) {
            context.watch<TextStylesCubit>().state.forEach((final element) {
              if (element.name == widget.textStyle.textStyleModel) {
                model = element;
              }
            });
          }
          return GestureDetector(
            onDoubleTap: () {
              if (!widget.state.forPlay) {
                _controller.text = widget.value.get(
                  widget.state.params,
                  widget.state.states,
                  widget.state.dataset,
                  widget.state.forPlay,
                  widget.state.loop,
                  context,
                );
                setState(() {
                  isEditing = !isEditing;
                });
                if (_controller.text.isNotEmpty) {
                  _controller.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: _controller.text.length,
                  );
                }
                BlocProvider.of<FocusBloc>(context).add(
                  OnFocus(node: widget.state.node),
                );
              }
            },
            child: isEditing
                ? Focus(
                    focusNode: focusNode,
                    onFocusChange: (final hasFocus) {
                      if (!hasFocus) {
                        updateTextOnSubmit(_controller.text, context);
                      }
                    },
                    child: !widget.isFullWidth
                        ? IntrinsicWidth(
                            child: TextField(
                              controller: _controller,
                              autofocus: true,
                              style: widget.textStyle.get(context, model),
                              textAlign: widget.textStyle.textAlign?.get ??
                                  TextAlign.start,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 4),
                                isDense: true,
                                border: InputBorder.none,
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
                              onSubmitted: (final text) =>
                                  updateTextOnSubmit(text, context),
                            ),
                          )
                        : SizedBox(
                            width: double.maxFinite,
                            child: TextField(
                              controller: _controller,
                              autofocus: true,
                              style: widget.textStyle.get(context, model),
                              textAlign: widget.textStyle.textAlign?.get ??
                                  TextAlign.start,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 4),
                                isDense: true,
                                border: InputBorder.none,
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
                              onSubmitted: (final text) =>
                                  updateTextOnSubmit(text, context),
                            ),
                          ),
                  )
                : GestureBuilderBase.get(
                    context: context,
                    state: widget.state,
                    child: widget.isFullWidth
                        ? SizedBox(
                            width: double.maxFinite,
                            child: TextBuilder(
                              textStyle: widget.textStyle,
                              value: widget.value,
                              maxLines: widget.maxLines,
                              params: widget.state.params,
                              states: widget.state.states,
                              dataset: widget.state.dataset,
                              forPlay: widget.state.forPlay,
                              loop: widget.state.loop,
                            ),
                          )
                        : TextBuilder(
                            textStyle: widget.textStyle,
                            value: widget.value,
                            maxLines: widget.maxLines,
                            params: widget.state.params,
                            states: widget.state.states,
                            dataset: widget.state.dataset,
                            forPlay: widget.state.forPlay,
                            loop: widget.state.loop,
                          ),
                  ),
          );
        },
      ),
    );
  }

  void updateTextOnSubmit(final String text, final BuildContext context) {
    setState(() {
      isEditing = !isEditing;
    });
    widget.state.node.body.attributes[DBKeys.value] = FTextTypeInput(
      value: text,
    );
    sl.get<NodeRepository>().changeNode(
          node: widget.state.node as NDynamic,
        );
  }
}

class EnterIntent extends Intent {}
