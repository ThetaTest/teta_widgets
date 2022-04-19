// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Package imports:
import 'package:diacritic/diacritic.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/src/blocs/focus_project/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

/// Generates the code for a page
String pageCodeTemplate(
  final BuildContext context,
  final CNode node,
  final List<CNode> children,
  final int pageId,
) {
  final prj =
      (BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded).prj;
  final page = prj.pages!.firstWhere((final element) => element.id == pageId);
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
  final strChildren = StringBuffer()..write('');
  var componentImport = '';
  var appBarString = '';
  var bottomBarString = '';
  var drawerString = '';
  for (final e in children) {
    if (e.globalType == NType.appBar) {
      appBarString = e.child != null &&
              (node.body.attributes[DBKeys.showAppBar] as bool? ?? false)
          ? '''
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120),
            child: ${e.toCode(context)},
          ),'''
          : '';
    } else if (e.globalType == NType.bottomBar) {
      final child = e.child != null &&
              (node.body.attributes[DBKeys.showBottomBar] as bool? ?? false)
          ? e.toCode(context)
          : '';
      bottomBarString =
          (node.body.attributes[DBKeys.showBottomBar] as bool? ?? false)
              ? child != ''
                  ? '''
      // BottomBar
      Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: $child
      ),
      '''
                  : ''
              : '';
    } else if (e.globalType == NType.drawer) {
      drawerString = e.child != null ? 'drawer: ${e.toCode(context)},' : '';
    } else if (e.globalType == NType.component) {
      componentImport = "import 'package:myapp/src/components/index.dart';";
    } else {
      if (strChildren.toString() == '') {
        strChildren.write(e.toCode(context));
      }
    }
  }
  if (strChildren.toString() != '') strChildren.write(',');

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
  final initStateString = StringBuffer()..write('');
  for (final element in page.states) {
    final rc = ReCase(element.name);
    final value = element.typeDeclaration(rc.camelCase) == 'String'
        ? "'${element.get}'"
        : '${element.get}';
    statesString.write(
      '''
      ${element.doc != '' && element.doc != null ? '// ${element.doc}' : ''}
      ${element.typeDeclaration(rc.camelCase)} ${rc.camelCase} = $value;
      ''',
    );
    if (element.initStateCode() != null) {
      initStateString.write(element.initStateCode());
    }
  }

  final isSupabaseIntegrated = prj.config?.supabaseEnabled ?? false;

  final backgroundColor =
      (node.body.attributes[DBKeys.fill] as FFill).getHexColor(context);

  final authSocialButtonsImport = (page.flatList ?? <CNode>[])
          .where(
            (final element) =>
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
          .where((final element) => element.intrinsicState.type == NType.icon)
          .isNotEmpty
      ? "import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';"
      : '';

  final lottieImport = (page.flatList ?? <CNode>[])
          .where((final element) => element.intrinsicState.type == NType.lottie)
          .isNotEmpty
      ? "import 'package:lottie/lottie.dart';"
      : '';

  final isARState = isSupabaseIntegrated
      ? page.isAuthenticatedRequired
          ? 'AuthRequiredState<Page${pageNameRC.pascalCase}> with SingleTickerProviderStateMixin'
          : 'AuthState<Page${pageNameRC.pascalCase}> with SingleTickerProviderStateMixin'
      : 'State<Page${pageNameRC.pascalCase}>';

  final badgeImport = (page.flatList ?? <CNode>[])
          .where((final element) => element.intrinsicState.type == NType.badge)
          .isNotEmpty
      ? "import 'package:badges/badges.dart';"
      : '';

  return '''
    import 'package:flutter/material.dart';
    ${isSupabaseIntegrated ? "import 'package:supabase/supabase.dart';" : ''}
    ${isSupabaseIntegrated ? "import 'package:supabase_flutter/supabase_flutter.dart';" : ''}
    ${page.isAuthenticatedRequired ? "import 'package:myapp/auth/auth_required_state.dart';" : "import 'package:myapp/auth/auth_state.dart';"}
    $authSocialButtonsImport
    $iconImport
    import 'package:intl/intl.dart';
    import 'package:collection/collection.dart';
    import 'package:myapp/src/pages/index.dart';
    import 'package:google_fonts/google_fonts.dart';
    import 'package:url_launcher/url_launcher.dart';
    import 'package:map/map.dart';
    import 'package:latlng/latlng.dart';
    import 'package:paged_vertical_calendar/paged_vertical_calendar.dart';
    $lottieImport
    $componentImport
    $badgeImport

    class Page${pageNameRC.pascalCase} extends StatefulWidget {
      const Page${pageNameRC.pascalCase}({Key? key, ${parametersString.toString()}}) : super(key: key);

      ${paramsString.toString()}

      @override
      _State${pageNameRC.pascalCase} createState() => _State${pageNameRC.pascalCase}();
    }

    class _State${pageNameRC.pascalCase} extends $isARState {
      ${statesString.toString()}
      final datasets = <String, dynamic>{};

      @override
      void initState() { 
        super.initState();
        $initStateString
      }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          $appBarString
          $drawerString
          backgroundColor: const Color(0xFF$backgroundColor),
          body: Stack(children: [
            ${strChildren.toString()}
            $bottomBarString
          ],
        ),
      );
    }
  }
  ''';
}
