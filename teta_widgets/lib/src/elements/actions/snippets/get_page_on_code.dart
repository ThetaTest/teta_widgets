import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';

PageObject? getPageOnToCode(final int pageId, final BuildContext context) {
  final prj = BlocProvider.of<FocusProjectCubit>(context).state!;
  if (prj.pages != null) {
    return prj.pages!.firstWhereOrNull((final element) => element.id == pageId);
  }
  return null;
}
