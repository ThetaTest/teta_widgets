// ignore_for_file: public_member_api_docs

// Package imports:
import 'package:collection/collection.dart';
import 'package:theta_models/src/models/variable.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:theta_models/theta_models.dart';

VariableObject? takeStateFrom(final PageLoaded page, final String condition) {
  return page.states.firstWhereOrNull(
    (final element) => element.name.toLowerCase() == condition.toLowerCase(),
  );
}
