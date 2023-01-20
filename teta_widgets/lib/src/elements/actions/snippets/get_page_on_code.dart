import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';

PageLoaded getPageOnToCode(final int pageId, final BuildContext context) {
  final page = BlocProvider.of<PageCubit>(context).state;
  return page as PageLoaded;
}
