// Flutter imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:theta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:theta_widgets/src/elements/index.dart';

///Tests for FFill
void main() {
  group('FFill toCode test', () {
    test(
      'None',
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
      'Solid',
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
      'Linear Gradient',
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
      'Radial Gradient',
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
      'Image',
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
