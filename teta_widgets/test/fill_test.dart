// Flutter imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

///Tests for FFill
void main() {
  group('Container toCode test', () {
    test(
      'Container: fill type none',
      () {
        expect(
          FormatterTest.format('''
            Container(
              decoration: BoxDecoration(
                ${FFill.toCodeTests(FFill().ready(FFillType.none))}
              ),
              child: const SizedBox(),
            )
            '''),
          true,
        );
      },
    );
    test(
      'Container: fill type solid',
      () {
        expect(
          FormatterTest.format('''
            Container(
              decoration: BoxDecoration(
                ${FFill.toCodeTests(FFill().ready(FFillType.solid))}
              ),
              child: const SizedBox(),
            )
            '''),
          true,
        );
      },
    );
    test(
      'Container: fill type linear gradient',
      () {
        expect(
          FormatterTest.format('''
            Container(
              decoration: BoxDecoration(
                ${FFill.toCodeTests(FFill().ready(FFillType.linearGradient))}
              ),
              child: const SizedBox(),
            )
            '''),
          true,
        );
      },
    );
    test(
      'Container: fill type radial gradient',
      () {
        expect(
          FormatterTest.format('''
            Container(
              decoration: BoxDecoration(
                ${FFill.toCodeTests(FFill().ready(FFillType.radialGradient))}
              ),
              child: const SizedBox(),
            )
            '''),
          true,
        );
      },
    );
    test(
      'Container: fill type image',
      () {
        expect(
          FormatterTest.format('''
            Container(
              decoration: BoxDecoration(
                ${FFill.toCodeTests(FFill().ready(FFillType.image))}
              ),
              child: const SizedBox(),
            )
            '''),
          true,
        );
      },
    );
  });
}
