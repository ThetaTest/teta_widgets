// Flutter imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

///Tests for FTextInputType
void main() {
  group('Button toCode test', () {
    test(
      'Text Value',
      () {
        final value = FTextTypeInput(value: 'xxx').toCode(0);
        expect(
          FormatterTest.format('''
              Text($value)
            '''),
          true,
        );
      },
    );
    test(
      'State Value',
      () {
        final value =
            FTextTypeInput(stateName: 'state', type: FTextTypeEnum.state)
                .toCode(0);
        expect(
          FormatterTest.format('''
              Text($value)
            '''),
          true,
        );
      },
    );
    test(
      'Param Value',
      () {
        final value =
            FTextTypeInput(paramName: 'param', type: FTextTypeEnum.param)
                .toCode(0);
        expect(
          FormatterTest.format('''
              Text($value)
            '''),
          true,
        );
      },
    );
    test(
      'Dataset Value',
      () {
        final value = FTextTypeInput(
          datasetName: 'xxx',
          datasetAttr: 'yyy',
          type: FTextTypeEnum.dataset,
        ).toCode(0);
        expect(
          FormatterTest.format('''
              Text($value)
            '''),
          true,
        );
      },
    );
  });
}
