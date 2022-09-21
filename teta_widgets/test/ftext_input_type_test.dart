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
      'Strange Alpha-Numeric',
      () {
        final value = FTextTypeInput(
          value:
              "___10101001!',pod'92912839)(/&%%££%%&&/=as|||||90948=883unndèòéàòòdèadwwdkskdnjajuwud8283",
        ).toCode(0, resultType: ResultTypeEnum.string);
        expect(
          FormatterTest.format('''
              Text($value)
            '''),
          true,
        );
      },
    );
    test(
      'Single Quote',
      () {
        final value = FTextTypeInput(
          value: "'",
        ).toCode(0, resultType: ResultTypeEnum.string);
        expect(
          FormatterTest.format('''
              Text($value)
            '''),
          true,
        );
      },
    );
    test(
      'Triple Single Quote',
      () {
        final value = FTextTypeInput(
          value: "'''",
        ).toCode(0, resultType: ResultTypeEnum.string);
        expect(
          FormatterTest.format('''
              Text($value)
            '''),
          true,
        );
      },
    );
    test(
      'Ten Single Quote',
      () {
        final value = FTextTypeInput(
          value: "''''''''''",
        ).toCode(0, resultType: ResultTypeEnum.string);
        expect(
          FormatterTest.format('''
              Text($value)
            '''),
          true,
        );
      },
    );
    test(
      'Text with a Single Quote ',
      () {
        final value = FTextTypeInput(
          value: "bogota'",
        ).toCode(0, resultType: ResultTypeEnum.string);
        expect(
          FormatterTest.format('''
              Text($value)
            '''),
          true,
        );
      },
    );
    test(
      'Single Double Quote',
      () {
        final value = FTextTypeInput(
          value: '"',
        ).toCode(0, resultType: ResultTypeEnum.string);
        expect(
          FormatterTest.format('''
              Text($value)
            '''),
          true,
        );
      },
    );
    test(
      'Triple Double Quotes',
      () {
        final value = FTextTypeInput(
          value: '"""',
        ).toCode(0, resultType: ResultTypeEnum.string);
        expect(
          FormatterTest.format('''
              Text($value)
            '''),
          true,
        );
      },
    );
    test(
      'Ten Double Quote',
      () {
        final value = FTextTypeInput(
          value: '""""""""""',
        ).toCode(0, resultType: ResultTypeEnum.string);
        expect(
          FormatterTest.format('''
              Text($value)
            '''),
          true,
        );
      },
    );
    test(
      'Link as Text',
      () {
        final value = FTextTypeInput(
          value:
              'https://www.google.com/search?q=google&rlz=1C5CHFA_enIT904IT905&oq=google&aqs=chrome..69i57j0i271l3.613j0j7&sourceid=chrome&ie=UTF-8',
        ).toCode(0, resultType: ResultTypeEnum.string);
        expect(
          FormatterTest.format('''
              Text($value)
            '''),
          true,
        );
      },
    );
    test(
      'Longest Regex as Value',
      () {
        final value = FTextTypeInput(
          value: '''
            (?:(?:\r\n)?[ \t])*(?:(?:(?:[^()<>@,;:\\".[] 000-031]+(?:(?:(?:\r\n)?[ \t] )+|Z|(?=[["()<>@,;:\\".[]]))|"(?:[^"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?: \r\n)?[ \t])*)(?:.(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".[] 000-031]+(?:(?:( ?:\r\n)?[ \t])+|Z|(?=[["()<>@,;:\\".[]]))|"(?:[^"\r\\]|\\.|(?:(?:\r\n)?[  \t]))*"(?:(?:\r\n)?[ \t])*))*@(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".[] 000-0 31]+(?:(?:(?:\r\n)?[ \t])+|Z|(?=[["()<>@,;:\\".[]]))|[([^[]\r\\]|\\.)* ](?:(?:\r\n)?[ \t])*)(?:.(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".[] 000-031]+ (?:(?:(?:\r\n)?[ \t])+|Z|(?=[["()<>@,;:\\".[]]))|[([^[]\r\\]|\\.)*](?: (?:\r\n)?[ \t])*))*|(?:[^()<>@,;:\\".[] 000-031]+(?:(?:(?:\r\n)?[ \t])+|Z |(?=[["()<>@,;:\\".[]]))|"(?:[^"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n) ?[ \t])*)*<(?:(?:\r\n)?[ \t])*(?:@(?:[^()<>@,;:\\".[] 000-031]+(?:(?:(?: r\n)?[ \t])+|Z|(?=[["()<>@,;:\\".[]]))|[([^[]\r\\]|\\.)*](?:(?:\r\n)?[ \t])*)(?:.(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".[] 000-031]+(?:(?:(?:\r\n) ?[ \t])+|Z|(?=[["()<>@,;:\\".[]]))|[([^[]\r\\]|\\.)*](?:(?:\r\n)?[ \t] )*))*(?:,@(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".[] 000-031]+(?:(?:(?:\r\n)?[ \t])+|Z|(?=[["()<>@,;:\\".[]]))|[([^[]\r\\]|\\.)*](?:(?:\r\n)?[ \t])* )(?:.(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".[] 000-031]+(?:(?:(?:\r\n)?[ \t] )+|Z|(?=[["()<>@,;:\\".[]]))|[([^[]\r\\]|\\.)*](?:(?:\r\n)?[ \t])*))*) *:(?:(?:\r\n)?[ \t])*)?(?:[^()<>@,;:\\".[] 000-031]+(?:(?:(?:\r\n)?[ \t])+ |Z|(?=[["()<>@,;:\\".[]]))|"(?:[^"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r \n)?[ \t])*)(?:.(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".[] 000-031]+(?:(?:(?: \r\n)?[ \t])+|Z|(?=[["()<>@,;:\\".[]]))|"(?:[^"\r\\]|\\.|(?:(?:\r\n)?[ \t ]))*"(?:(?:\r\n)?[ \t])*))*@(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".[] 000-031 ]+(?:(?:(?:\r\n)?[ \t])+|Z|(?=[["()<>@,;:\\".[]]))|[([^[]\r\\]|\\.)*]( ?:(?:\r\n)?[ \t])*)(?:.(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".[] 000-031]+(? :(?:(?:\r\n)?[ \t])+|Z|(?=[["()<>@,;:\\".[]]))|[([^[]\r\\]|\\.)*](?:(? :\r\n)?[ \t])*))*>(?:(?:\r\n)?[ \t])*)|(?:[^()<>@,;:\\".[] 000-031]+(?:(? :(?:\r\n)?[ \t])+|Z|(?=[["()<>@,;:\\".[]]))|"(?:[^"\r\\]|\\.|(?:(?:\r\n)? [ \t]))*"(?:(?:\r\n)?[ \t])*)*:(?:(?:\r\n)?[ \t])*(?:(?:(?:[^()<>@,;:\\".[]  000-031]+(?:(?:(?:\r\n)?[ \t])+|Z|(?=[["()<>@,;:\\".[]]))|"(?:[^"\r\\]| \\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*)(?:.(?:(?:\r\n)?[ \t])*(?:[^()<> @,;:\\".[] 000-031]+(?:(?:(?:\r\n)?[ \t])+|Z|(?=[["()<>@,;:\\".[]]))|" (?:[^"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*))*@(?:(?:\r\n)?[ \t] )*(?:[^()<>@,;:\\".[] 000-031]+(?:(?:(?:\r\n)?[ \t])+|Z|(?=[["()<>@,;:\\ ".[]]))|[([^[]\r\\]|\\.)*](?:(?:\r\n)?[ \t])*)(?:.(?:(?:\r\n)?[ \t])*(? :[^()<>@,;:\\".[] 000-031]+(?:(?:(?:\r\n)?[ \t])+|Z|(?=[["()<>@,;:\\".[ ]]))|[([^[]\r\\]|\\.)*](?:(?:\r\n)?[ \t])*))*|(?:[^()<>@,;:\\".[] 000- 031]+(?:(?:(?:\r\n)?[ \t])+|Z|(?=[["()<>@,;:\\".[]]))|"(?:[^"\r\\]|\\.|( ?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*)*<(?:(?:\r\n)?[ \t])*(?:@(?:[^()<>@,; :\\".[] 000-031]+(?:(?:(?:\r\n)?[ \t])+|Z|(?=[["()<>@,;:\\".[]]))|[([ ^[]\r\\]|\\.)*](?:(?:\r\n)?[ \t])*)(?:.(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\" .[] 000-031]+(?:(?:(?:\r\n)?[ \t])+|Z|(?=[["()<>@,;:\\".[]]))|[([^[ ]\r\\]|\\.)*](?:(?:\r\n)?[ \t])*))*(?:,@(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\". [] 000-031]+(?:(?:(?:\r\n)?[ \t])+|Z|(?=[["()<>@,;:\\".[]]))|[([^[] r\\]|\\.)*](?:(?:\r\n)?[ \t])*)(?:.(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".[]  000-031]+(?:(?:(?:\r\n)?[ \t])+|Z|(?=[["()<>@,;:\\".[]]))|[([^[]\r\\] |\\.)*](?:(?:\r\n)?[ \t])*))*)*:(?:(?:\r\n)?[ \t])*)?(?:[^()<>@,;:\\".[] 0 00-031]+(?:(?:(?:\r\n)?[ \t])+|Z|(?=[["()<>@,;:\\".[]]))|"(?:[^"\r\\]|\\ .|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*)(?:.(?:(?:\r\n)?[ \t])*(?:[^()<>@, ;:\\".[] 000-031]+(?:(?:(?:\r\n)?[ \t])+|Z|(?=[["()<>@,;:\\".[]]))|"(? :[^"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*))*@(?:(?:\r\n)?[ \t])* (?:[^()<>@,;:\\".[] 000-031]+(?:(?:(?:\r\n)?[ \t])+|Z|(?=[["()<>@,;:\\". []]))|[([^[]\r\\]|\\.)*](?:(?:\r\n)?[ \t])*)(?:.(?:(?:\r\n)?[ \t])*(?:[ ^()<>@,;:\\".[] 000-031]+(?:(?:(?:\r\n)?[ \t])+|Z|(?=[["()<>@,;:\\".[] ]))|[([^[]\r\\]|\\.)*](?:(?:\r\n)?[ \t])*))*>(?:(?:\r\n)?[ \t])*)(?:,s*( ?:(?:[^()<>@,;:\\".[] 000-031]+(?:(?:(?:\r\n)?[ \t])+|Z|(?=[["()<>@,;:\\ ".[]]))|"(?:[^"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*)(?:.(?:( ?:\r\n)?[ \t])*(?:[^()<>@,;:\\".[] 000-031]+(?:(?:(?:\r\n)?[ \t])+|Z|(?=[ ["()<>@,;:\\".[]]))|"(?:[^"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t ])*))*@(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".[] 000-031]+(?:(?:(?:\r\n)?[ \t ])+|Z|(?=[["()<>@,;:\\".[]]))|[([^[]\r\\]|\\.)*](?:(?:\r\n)?[ \t])*)(? :.(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".[] 000-031]+(?:(?:(?:\r\n)?[ \t])+| Z|(?=[["()<>@,;:\\".[]]))|[([^[]\r\\]|\\.)*](?:(?:\r\n)?[ \t])*))*|(?: [^()<>@,;:\\".[] 000-031]+(?:(?:(?:\r\n)?[ \t])+|Z|(?=[["()<>@,;:\\".[ ]]))|"(?:[^"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*)*<(?:(?:\r\n) ?[ \t])*(?:@(?:[^()<>@,;:\\".[] 000-031]+(?:(?:(?:\r\n)?[ \t])+|Z|(?=[[" ()<>@,;:\\".[]]))|[([^[]\r\\]|\\.)*](?:(?:\r\n)?[ \t])*)(?:.(?:(?:\r\n) ?[ \t])*(?:[^()<>@,;:\\".[] 000-031]+(?:(?:(?:\r\n)?[ \t])+|Z|(?=[["()<> @,;:\\".[]]))|[([^[]\r\\]|\\.)*](?:(?:\r\n)?[ \t])*))*(?:,@(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".[] 000-031]+(?:(?:(?:\r\n)?[ \t])+|Z|(?=[["()<>@, ;:\\".[]]))|[([^[]\r\\]|\\.)*](?:(?:\r\n)?[ \t])*)(?:.(?:(?:\r\n)?[ \t] )*(?:[^()<>@,;:\\".[] 000-031]+(?:(?:(?:\r\n)?[ \t])+|Z|(?=[["()<>@,;:\\ ".[]]))|[([^[]\r\\]|\\.)*](?:(?:\r\n)?[ \t])*))*)*:(?:(?:\r\n)?[ \t])*)? (?:[^()<>@,;:\\".[] 000-031]+(?:(?:(?:\r\n)?[ \t])+|Z|(?=[["()<>@,;:\\". []]))|"(?:[^"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*)(?:.(?:(?: \r\n)?[ \t])*(?:[^()<>@,;:\\".[] 000-031]+(?:(?:(?:\r\n)?[ \t])+|Z|(?=[[ "()<>@,;:\\".[]]))|"(?:[^"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t]) *))*@(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".[] 000-031]+(?:(?:(?:\r\n)?[ \t]) +|Z|(?=[["()<>@,;:\\".[]]))|[([^[]\r\\]|\\.)*](?:(?:\r\n)?[ \t])*)(?: .(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".[] 000-031]+(?:(?:(?:\r\n)?[ \t])+|Z |(?=[["()<>@,;:\\".[]]))|[([^[]\r\\]|\\.)*](?:(?:\r\n)?[ \t])*))*>(?:( ?:\r\n)?[ \t])*))*)?;s*)
          ''',
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
            .toCode(0, resultType: ResultTypeEnum.int, defaultValue: '0');
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
                .toCode(0, resultType: ResultTypeEnum.int, defaultValue: '0');
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
                .toCode(0, resultType: ResultTypeEnum.int, defaultValue: '0');
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
        ).toCode(0, resultType: ResultTypeEnum.int, defaultValue: '0');
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
            .toCode(0, resultType: ResultTypeEnum.double, defaultValue: '0.0');
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
        final value = FTextTypeInput(
          stateName: 'state',
          type: FTextTypeEnum.state,
        ).toCode(0, resultType: ResultTypeEnum.double, defaultValue: '0.0');
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
        final value = FTextTypeInput(
          paramName: 'param',
          type: FTextTypeEnum.param,
        ).toCode(0, resultType: ResultTypeEnum.double, defaultValue: '0.0');
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
        ).toCode(0, resultType: ResultTypeEnum.double, defaultValue: '0.0');
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
