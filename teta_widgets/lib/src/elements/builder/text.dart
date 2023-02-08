// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/text_style.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';

/// Returns a [Text] widget with all the properties
class TextBuilder extends StatelessWidget {
  /// Constructor
  const TextBuilder({
    required final FTextStyle textStyle,
    required final FTextTypeInput value,
    required final List<VariableObject> params,
    required final List<VariableObject> states,
    required final List<DatasetObject> dataset,
    required final bool forPlay,
    final FTextTypeInput? maxLines,
    final int? loop,
    final Key? key,
  })  : _textStyle = textStyle,
        _value = value,
        _params = params,
        _states = states,
        _dataset = dataset,
        _forPlay = forPlay,
        _maxLines = maxLines,
        _loop = loop,
        super(key: key);

  final FTextTypeInput _value;
  final FTextTypeInput? _maxLines;
  final FTextStyle _textStyle;
  final List<VariableObject> _params;
  final List<VariableObject> _states;
  final List<DatasetObject> _dataset;
  final bool _forPlay;
  final int? _loop;

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<ColorStylesCubit, List<ColorStyleModel>>(
      buildWhen: (final previous, final current) => current != previous,
      builder: (final context, final state) {
        FFill? finalFill;
        if (state.isNotEmpty) {
          for (final e in state) {
            if (e.id == _textStyle.fill!.paletteStyle) finalFill = e.fill;
            if (e.name == _textStyle.fill!.paletteStyle) finalFill = e.fill;
          }
        }
        finalFill ??= _textStyle.fill!;
        TextStyleModel? model;
        if (_textStyle.textStyleModel != null) {
          BlocProvider.of<TextStylesCubit>(context)
              .state
              .forEach((final element) {
            if (element.name == _textStyle.textStyleModel) model = element;
          });
        }
        final maxLines = _maxLines?.get(
          _params,
          _states,
          _dataset,
          _forPlay,
          _loop,
          context,
        );
        var intValue = int.tryParse(maxLines ?? '');
        if (intValue != null && intValue <= 0) {
          intValue = 1;
        }
        return Text(
          _value.get(
            _params,
            _states,
            _dataset,
            _forPlay,
            _loop,
            context,
          ),
          style: _textStyle.get(context, model),
          textAlign: _textStyle.textAlign!.get,
          maxLines: intValue,
          textDirection: _textStyle.textDirection?.get,
        );
      },
    );
  }
}
