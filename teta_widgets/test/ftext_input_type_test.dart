// Flutter imports:
// ignore_for_file: noop_primitive_operations

import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

///Tests for FTextInputType
void main() {
  differentStrangeCases();
  resultTypeString();
  resultTypeInt();
  resultTypeDouble();
}

void differentStrangeCases() {
  group('FTextInputType toCode test: Cases', () {
    test(
      'Text Value',
      () {
        final value = FTextTypeInput(
          value: "___10101001!',pod'92883unndèòéàòòdèadwwdkskdnjajuwud8283",
        ).toCode(0, resultType: ResultTypeEnum.string);
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

void resultTypeString() {
  group('FTextInputType toCode test: return String', () {
    test(
      'Text Value',
      () {
        final value = FTextTypeInput(value: 'xxx')
            .toCode(0, resultType: ResultTypeEnum.string);
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
                .toCode(0, resultType: ResultTypeEnum.string);
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
                .toCode(0, resultType: ResultTypeEnum.string);
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
        ).toCode(0, resultType: ResultTypeEnum.string);
        expect(
          FormatterTest.format('''
              Text($value,)
            '''),
          true,
        );
      },
    );
  });
}

void resultTypeInt() {
  group('FTextInputType toCode test: return Int', () {
    test(
      'Text Value',
      () {
        final value = FTextTypeInput(value: 'xxx')
            .toCode(0, resultType: ResultTypeEnum.int);
        expect(
          FormatterTest.format('''
              Text(${value.toString()})
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
                .toCode(0, resultType: ResultTypeEnum.int);
        expect(
          FormatterTest.format('''
              Text(${value.toString()})
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
                .toCode(0, resultType: ResultTypeEnum.int);
        expect(
          FormatterTest.format('''
              Text(${value.toString()})
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
        ).toCode(0, resultType: ResultTypeEnum.int);
        expect(
          FormatterTest.format('''
              Text(${value.toString()})
            '''),
          true,
        );
      },
    );
  });
}

void resultTypeDouble() {
  group('FTextInputType toCode test: return double', () {
    test(
      'Text Value',
      () {
        final value = FTextTypeInput(value: 'xxx')
            .toCode(0, resultType: ResultTypeEnum.double);
        expect(
          FormatterTest.format('''
              Text(${value.toString()})
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
                .toCode(0, resultType: ResultTypeEnum.double);
        expect(
          FormatterTest.format('''
              Text(${value.toString()})
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
                .toCode(0, resultType: ResultTypeEnum.double);
        expect(
          FormatterTest.format('''
              Text(${value.toString()})
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
        ).toCode(0, resultType: ResultTypeEnum.double);
        expect(
          FormatterTest.format('''
              Text(${value.toString()})
            '''),
          true,
        );
      },
    );
  });
}
