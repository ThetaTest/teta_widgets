// ignore_for_file: public_member_api_docs

// Package imports:
import 'package:collection/collection.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

VariableObject? takeParamFrom(final PageLoaded page, final String condition) {
  return page.params.firstWhereOrNull(
    (final element) => element.name.toLowerCase() == condition.toLowerCase(),
  );
}
