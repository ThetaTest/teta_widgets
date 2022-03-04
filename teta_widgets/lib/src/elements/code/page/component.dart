// Flutter imports:
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/src/blocs/focus_project/index.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for a page
String pageComponentCodeTemplate(
  BuildContext context,
  NodeBody body,
  List<CNode> children,
  int pageId,
) {
  final page =
      (BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded)
          .prj
          .pages!
          .firstWhere((element) => element.id == pageId);

  final temp = removeDiacritics(
    page.name
        .replaceFirst('0', 'A0')
        .replaceFirst('1', 'A1')
        .replaceFirst('2', 'A2')
        .replaceFirst('3', 'A3')
        .replaceFirst('4', 'A4')
        .replaceFirst('5', 'A5')
        .replaceFirst('6', 'A6')
        .replaceFirst('7', 'A7')
        .replaceFirst('8', 'A8')
        .replaceFirst('9', 'A9')
        .replaceAll(' ', '')
        .replaceAll("'", '')
        .replaceAll('"', ''),
  );

  final pageNameRC = ReCase(temp);

  /// If the component is hardcoded, display its code
  if (page.isHardCoded) {
    return page.code
            ?.replaceAll('void main() {', '')
            .replaceAll('runApp(${pageNameRC.pascalCase}());', '')
            .replaceFirst('}', '') ??
        '';
  }

  final strChildren = StringBuffer()..write('');
  var componentImport = '';
  for (final e in children) {
    if (e.globalType == NType.component) {
      componentImport = "import 'package:myapp/src/components/index.dart';";
    } else {
      if (strChildren.toString() == '') {
        strChildren.write(e.toCode(context));
      }
    }
  }

  final paramsString = StringBuffer()..write('');
  final parametersString = StringBuffer()..write('');
  for (final element in page.params) {
    final rc = ReCase(element.name);
    final value = element.typeDeclaration(rc.camelCase) == 'String'
        ? "'${element.get}'"
        : element.firstValueForInitialization();
    paramsString.write(
      '''
      ${element.doc != '' && element.doc != null ? '// ${element.doc}' : ''}
      final ${element.typeDeclaration(rc.camelCase)} ${rc.camelCase};
      ''',
    );
    parametersString.write('this.${rc.camelCase} = $value, ');
  }

  final statesString = StringBuffer()..write('');
  if (body.attributes['states'] != null) {
    for (final element in body.attributes['states'] as List<VariableObject>? ??
        <VariableObject>[]) {
      final rc = ReCase(element.name);
      statesString.write(
        '''
        String ${rc.camelCase} = '${element.get}';
      ''',
      );
    }
  }

  final authSocialButtonsImport = (page.flatList ?? <CNode>[])
          .where(
            (element) =>
                element.intrinsicState.type == NType.loginWithGoogle ||
                element.intrinsicState.type == NType.loginWithApple ||
                element.intrinsicState.type == NType.loginWithFacebook ||
                element.intrinsicState.type == NType.loginWithGitHub ||
                element.intrinsicState.type == NType.loginWithTwitter,
          )
          .isNotEmpty
      ? "import 'package:auth_buttons/auth_buttons.dart';"
      : '';

  final iconImport = (page.flatList ?? <CNode>[])
          .where((element) => element.intrinsicState.type == NType.icon)
          .isNotEmpty
      ? "import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';"
      : '';

  final lottieImport = (page.flatList ?? <CNode>[])
          .where((element) => element.intrinsicState.type == NType.lottie)
          .isNotEmpty
      ? "import 'package:lottie/lottie.dart';"
      : '';

  final badgeImport = (page.flatList ?? <CNode>[])
          .where((element) => element.intrinsicState.type == NType.badge)
          .isNotEmpty
      ? "import 'package:badges/badges.dart';"
      : '';

  return """
    import 'package:flutter/material.dart';
    import 'package:supabase/supabase.dart';
    import 'package:supabase_flutter/supabase_flutter.dart';
    import 'package:google_fonts/google_fonts.dart';
    $authSocialButtonsImport
    $lottieImport
    $iconImport
    import 'package:google_fonts/google_fonts.dart';
    import 'package:url_launcher/url_launcher.dart';
    import 'package:map/map.dart';
    import 'package:latlng/latlng.dart';
    import 'package:paged_vertical_calendar/paged_vertical_calendar.dart';
    $componentImport
    $badgeImport

    class ${pageNameRC.pascalCase} extends StatelessWidget {
      const ${pageNameRC.pascalCase}({Key? key, ${parametersString.toString()}}) : super(key: key);

      ${paramsString.toString()}

      @override
      _State createState() => _State();
    }

    class _State extends State<${pageNameRC.pascalCase}> {
      ${statesString.toString()}
      final datasets = <String, dynamic>{};

      @override
      Widget build(BuildContext context) {
        return ${strChildren.toString() != '' && !strChildren.toString().contains('Drawer') ? strChildren.toString() : 'const SizedBox()'};
      }
    }
  """;
}
