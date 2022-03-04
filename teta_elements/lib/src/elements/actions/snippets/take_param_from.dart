// ignore_for_file: public_member_api_docs

import 'package:collection/collection.dart';
import 'package:teta_core/src/models/page.dart';
import 'package:teta_core/src/models/variable.dart';

VariableObject? takeParamFrom(PageObject page, String condition) {
  return page.params.firstWhereOrNull(
    (element) => element.name.toLowerCase() == condition.toLowerCase(),
  );
}
