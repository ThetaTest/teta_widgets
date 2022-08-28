// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Package imports:
import 'package:diacritic/diacritic.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/src/services/packages_service.dart';
import 'package:teta_core/teta_core.dart';
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
  var appBarString = '';
  var bottomBarString = '';
  var drawerString = '';

  //----local properties for this page----
  final flag = node.body.attributes[DBKeys.flag] as bool;
  final backgroundColor =
      (node.body.attributes[DBKeys.fill] as FFill).getHexColor(context);
  //----local properties end----

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
    } else {
      if (strChildren.toString() == '') {
        strChildren.write(e.toCode(context));
      }
    }
  }
  if (strChildren.toString() != '') {
    if (page.isPage) {
      strChildren.write(',');
    } else {
      strChildren.write(';');
    }
  }

  //----start parameters----
  final paramsString = StringBuffer()..write('');
  final parametersString = StringBuffer()..write('');
  for (final element in page.params) {
    final rc = ReCase(element.name);
    final value = element.typeDeclaration(rc.camelCase) == 'String'
        ? "'''${element.get}'''"
        : element.firstValueForInitialization();
    paramsString.write(
      '''
      final ${element.typeDeclaration(rc.camelCase)} ${rc.camelCase};
      ''',
    );
    parametersString.write('this.${rc.camelCase} = $value, ');
  }
  //----end parameters----

  //----start states----
  final statesString = StringBuffer()..write('');
  final initStateString = StringBuffer()..write('');
  for (final element in page.states) {
    final rc = ReCase(element.name);
    final value = element.typeDeclaration(rc.camelCase) == 'String'
        ? "'${element.get}'"
        : element.getInitialization();
    statesString.write(
      '''
      ${element.typeDeclaration(rc.camelCase)} ${rc.camelCase} = $value;
      ''',
    );
    if (element.initStateCode() != null) {
      initStateString.write(element.initStateCode());
    }
  }
  //----end states----

  // Append toCodeOnInit for all widgets
  for (final childWidget in children) {
    initStateString.write(childWidget.toCodeOnInit(context));
  }

  //packages
  if (page.isPage && page.flatList != null) {
    for (final item in page.flatList!) {
      PackagesService.instance.insertPackages(item.intrinsicState.packages);
    }
  }

  final isSupabaseIntegrated = prj.config?.supabaseEnabled ?? false;

  final isARState = isSupabaseIntegrated
      ? page.isAuthenticatedRequired
          ? 'AuthRequiredState<Page${pageNameRC.pascalCase}> with SingleTickerProviderStateMixin'
          : 'AuthState<Page${pageNameRC.pascalCase}> with SingleTickerProviderStateMixin'
      : 'State<Page${pageNameRC.pascalCase}>';

  return '''
    import 'package:myapp/src/teta_files/imports.dart';
    ${page.isAuthenticatedRequired ? "import 'package:myapp/auth/auth_required_state.dart';" : "import 'package:myapp/auth/auth_state.dart';"}
    ${prj.config?.isAdaptyReady ?? false ? "import 'package:adapty_flutter/adapty_flutter.dart';" : ''}
    
    ${PackagesService.instance.getToCodePackages()}

    class Page${pageNameRC.pascalCase} extends StatefulWidget {
      const Page${pageNameRC.pascalCase}({Key? key, ${parametersString.toString()}}) : super(key: key);

      ${paramsString.toString()}

      @override
      _State${pageNameRC.pascalCase} createState() => _State${pageNameRC.pascalCase}();
    }

    class _State${pageNameRC.pascalCase} extends $isARState {
      ${statesString.toString()}
      var datasets = <String, dynamic>{};
      int index = 0;

      final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


      @override
      void initState() {
        super.initState();
        $initStateString
        TetaCMS.instance.analytics.insertEvent(
          TetaAnalyticsType.usage,
          'App usage: view page',
          <String, dynamic>{
            'name': "${pageNameRC.pascalCase}",
          },
          isUserIdPreferableIfExists: true,
        );
      }

      @override
      Widget build(BuildContext context) {
        return ${page.isPage ? '''
        Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: $flag,
          $appBarString
          $drawerString
          backgroundColor: const Color(0xFF$backgroundColor),
          body: Stack(children: [
            ${strChildren.toString()}
            $bottomBarString
          ],
        ),
      );''' : strChildren.toString().isNotEmpty ? strChildren.toString() : 'const SizedBox();'}
    }
  }
  ''';
}
