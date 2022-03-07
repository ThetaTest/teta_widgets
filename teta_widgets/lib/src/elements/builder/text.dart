// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:teta_core/src/blocs/palette/index.dart';
import 'package:teta_core/src/blocs/text_styles/index.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/palette.dart';
import 'package:teta_core/src/models/text_style.dart';
import 'package:teta_core/src/models/variable.dart';

// Project imports:
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/text_style.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';

/// Returns a [Text] widget with all the properties
class TextBuilder extends StatelessWidget {
  /// Constructor
  const TextBuilder({
    required FTextStyle textStyle,
    required FTextTypeInput value,
    required List<VariableObject> params,
    required List<VariableObject> states,
    required List<DatasetObject> dataset,
    required bool forPlay,
    FTextTypeInput? maxLines,
    int? loop,
    Key? key,
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
  Widget build(BuildContext context) {
    return BlocBuilder<PaletteBloc, List<PaletteModel>>(
      buildWhen: (previous, current) => current != previous,
      builder: (context, state) {
        FFill? finalFill;
        if (state.isNotEmpty) {
          for (final e in state) {
            if (e.id == _textStyle.fill!.paletteStyle) finalFill = e.fill;
          }
        }
        finalFill ??= _textStyle.fill!;

        TextStyleModel? model;
        if (_textStyle.textStyleModel != null) {
          BlocProvider.of<TextStylesBloc>(context).state.forEach((element) {
            if (element.name == _textStyle.textStyleModel) model = element;
          });
        }

        final maxLines =
            _maxLines?.get(_params, _states, _dataset, _forPlay, _loop);
        var intValue = int.tryParse(maxLines ?? '');
        if (intValue != null && intValue <= 0) {
          intValue = 1;
        }
        final filter = ProfanityFilter();
        return Text(
          filter.censor(
            _value.get(_params, _states, _dataset, _forPlay, _loop),
          ),
          style: _textStyle.get(context, model),
          textAlign: _textStyle.textAlign!.get,
          maxLines: intValue,
        );
      },
    );
  }
}
