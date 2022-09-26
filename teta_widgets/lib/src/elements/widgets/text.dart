// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_repositories/src/node_repository.dart';
import 'package:teta_widgets/src/elements/builder/gesture_detector_base.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';

class WText extends StatefulWidget {
  /// Returns a Text widget in Teta
  const WText(
    final Key? key, {
    required this.value,
    required this.node,
    required this.textStyle,
    required this.forPlay,
    required this.isFullWidth,
    required this.params,
    required this.states,
    required this.dataset,
    required this.maxLines,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final FTextTypeInput value;
  final FTextStyle textStyle;
  final bool forPlay;
  final int? loop;
  final bool isFullWidth;
  final FTextTypeInput maxLines;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  State<WText> createState() => _WTextState();
}

class _WTextState extends State<WText> {
  final TextEditingController _controller = TextEditingController();
  bool isEditing = false;
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.value.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
      context,
    );
  }

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: BlocBuilder<ColorStylesCubit, List<PaletteModel>>(
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
            BlocProvider.of<TextStylesCubit>(context)
                .state
                .forEach((final element) {
              if (element.name == widget.textStyle.textStyleModel) {
                model = element;
              }
            });
          }
          return GestureDetector(
            onDoubleTap: () {
              final maxLines = int.tryParse(
                    widget.maxLines.get(
                      widget.params,
                      widget.states,
                      widget.dataset,
                      widget.forPlay,
                      widget.loop,
                      context,
                    ),
                  ) ??
                  1;
              if (!widget.forPlay && maxLines == 1) {
                _controller.text = widget.value.get(
                  widget.params,
                  widget.states,
                  widget.dataset,
                  widget.forPlay,
                  widget.loop,
                  context,
                );
                setState(() {
                  isEditing = !isEditing;
                });
                BlocProvider.of<FocusBloc>(context).add(
                  OnFocus(node: widget.node),
                );
              }
            },
            child: isEditing
                ? !widget.isFullWidth
                    ? IntrinsicWidth(
                        child: TextField(
                          controller: _controller,
                          autofocus: true,
                          style: widget.textStyle.get(context, model),
                          textAlign: widget.textStyle.textAlign?.get ??
                              TextAlign.start,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 4),
                            isDense: true,
                            border: InputBorder.none,
                          ),
                          maxLines: int.tryParse(
                                widget.maxLines.get(
                                  widget.params,
                                  widget.states,
                                  widget.dataset,
                                  widget.forPlay,
                                  widget.loop,
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
                            contentPadding: EdgeInsets.symmetric(vertical: 4),
                            isDense: true,
                            border: InputBorder.none,
                          ),
                          maxLines: int.tryParse(
                                widget.maxLines.get(
                                  widget.params,
                                  widget.states,
                                  widget.dataset,
                                  widget.forPlay,
                                  widget.loop,
                                  context,
                                ),
                              ) ??
                              1,
                          onSubmitted: (final text) =>
                              updateTextOnSubmit(text, context),
                        ),
                      )
                : GestureBuilderBase.get(
                    context: context,
                    node: widget.node,
                    params: widget.params,
                    states: widget.states,
                    dataset: widget.dataset,
                    forPlay: widget.forPlay,
                    loop: widget.loop,
                    child: widget.isFullWidth
                        ? SizedBox(
                            width: double.maxFinite,
                            child: TextBuilder(
                              textStyle: widget.textStyle,
                              value: widget.value,
                              maxLines: widget.maxLines,
                              params: widget.params,
                              states: widget.states,
                              dataset: widget.dataset,
                              forPlay: widget.forPlay,
                              loop: widget.loop,
                            ),
                          )
                        : TextBuilder(
                            textStyle: widget.textStyle,
                            value: widget.value,
                            maxLines: widget.maxLines,
                            params: widget.params,
                            states: widget.states,
                            dataset: widget.dataset,
                            forPlay: widget.forPlay,
                            loop: widget.loop,
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
    widget.node.body.attributes[DBKeys.value] = FTextTypeInput(
      value: text,
    );
    NodeRepository.change(
      nodeId: widget.node.nid,
      node: widget.node as NDynamic,
      pageId: BlocProvider.of<PageCubit>(context).state.id,
      key: DBKeys.value,
      value: FTextTypeInput(
        value: text,
      ).toJson(),
      old: null,
    );
    BlocProvider.of<RefreshCubit>(context).change();
  }
}

class EnterIntent extends Intent {}
