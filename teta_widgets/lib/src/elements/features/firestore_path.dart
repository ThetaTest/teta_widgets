// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/text_type_input.dart';

class FFirestorePath {
  /// Constructor
  FFirestorePath({this.values, this.isDoc = false}) {
    values ??= [
      FTextTypeInput(),
    ];
  }

  /// Values of [FFirestorePath]
  /// Contains the path for Firestore DB
  List<FTextTypeInput>? values;

  /// Indicates if the path in linking to a Document or a Collection
  bool? isDoc = false;

  /// Instantiate [FFirestorePath] from Json
  static FFirestorePath fromJson(List<dynamic>? json) {
    return FFirestorePath(
      values: json != null
          ? json
              .cast<Map<String, dynamic>>()
              .map<FTextTypeInput>(FTextTypeInput.fromJson)
              .toList()
          : [
              FTextTypeInput(),
            ],
    );
  }

  /// Convert [FFirestorePath] to Json
  List<dynamic> toJson() {
    return values != null
        ? values!.map((e) => e.toJson()).toList()
        : <Map<String, dynamic>>[FTextTypeInput().toJson()];
  }

  /// Toggles value of isDoc
  void toggleIsDoc() => isDoc = !isDoc!;

  /// Transforms [values] to a single Firestore path string
  List<String> getFinalValues(
    BuildContext context,
    List<VariableObject> params,
    List<VariableObject> states,
    List<DatasetObject> dataset,
    int? loop, {
    required bool forPlay,
  }) {
    return values != null
        ? values!
            .map((value) => value.get(params, states, dataset, forPlay, loop))
            .toList()
        : [];
  }

  /// Calcs the full path
  String getPath(
    BuildContext context,
    List<VariableObject> params,
    List<VariableObject> states,
    List<DatasetObject> dataset,
    int? loop, {
    required bool forPlay,
  }) {
    final finalPath = StringBuffer()..write('');
    final values = getFinalValues(
      context,
      params,
      states,
      dataset,
      loop,
      forPlay: forPlay,
    );
    for (final e in values) {
      if (values.indexOf(e) != values.length - 1) {
        finalPath.write('$e/');
      } else {
        finalPath.write(e);
      }
    }
    return finalPath.toString();
  }

  /// Returns FirebaseFirestore complete path
  ///
  /// e.g.
  /// ```eg
  /// FirebaseFirestore.instance.doc(x).get()
  /// ```
  /// or
  /// ```dart
  /// FirebaseFirestore.instance.collection(x).get()
  /// ```
  String toCode(
    BuildContext context,
    int? loop, {
    required bool isStream,
  }) {
    final fPath = StringBuffer()..write('');
    final temp = values != null
        ? values!.map((value) => value.toCode(null)).toList()
        : <String>[];
    for (final e in temp) {
      if (temp.indexOf(e) != temp.length - 1) {
        fPath.write('$e/');
      } else {
        fPath.write(e);
      }
    }
    const prefix = 'FirebaseFirestore.instance';
    final end = isStream ? '.snapshots()' : '.get()';
    final func = (temp.length.isEven) ? 'doc' : 'collection';
    return "$prefix.$func('${fPath.toString()}')$end";
  }
}
