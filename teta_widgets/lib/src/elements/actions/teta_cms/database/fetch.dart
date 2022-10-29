// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
// Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';
// Project imports:

class FATetaCMSFetch {
  static Future action(
    final BuildContext context,
    final String collectionId,
    final FTextTypeInput limit,
    final FTextTypeInput page,
    final FTextTypeInput keyValue,
    final FTextTypeInput keyName,
    final bool showDrafts,
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final int? loop,
  ) async {
    final limitValue = limit.get(
      params,
      states,
      dataset,
      true,
      loop,
      context,
    );
    final pageValue = page.get(
      params,
      states,
      dataset,
      true,
      loop,
      context,
    );
    final keyNameValue = keyName.get(
      params,
      states,
      dataset,
      true,
      loop,
      context,
    );
    final keyValueValue = keyValue.get(
      params,
      states,
      dataset,
      true,
      loop,
      context,
    );
    final dbElements = await TetaCMS.instance.client.getCollection(
      collectionId,
      filters: [
        if (keyNameValue.isNotEmpty && keyValueValue.isNotEmpty)
          Filter(keyNameValue, keyValueValue),
      ],
      limit: int.tryParse(limitValue) ?? 20,
      page: int.tryParse(pageValue) ?? 0,
      showDrafts: showDrafts,
    );
    final data = DatasetObject(
      name: 'Cms init fetch',
      map: dbElements
          .map((final dynamic e) => e as Map<String, dynamic>)
          .toList(),
    );
    addDataset(context, dataset, data);
    try {
      BlocProvider.of<RefreshCubit>(context).change();
    } catch (e) {
      Logger.printError(
        'Error trying to refresh the UI in FATetaCMSFetch.action func, error: $e',
      );
    }
  }

  static String toCode(
    final String collectionId,
    final FTextTypeInput limit,
    final FTextTypeInput page,
    final FTextTypeInput keyValue,
    final FTextTypeInput keyName,
    final bool showDrafts,
    final int loop,
  ) {
    final limitValue = limit
        .toCode(
          loop,
          resultType: ResultTypeEnum.int,
          defaultValue: '20',
        )
        .replaceAll("'", '');
    final pageValue = page
        .toCode(
          loop,
          resultType: ResultTypeEnum.int,
          defaultValue: '0',
        )
        .replaceAll("'", '');
    final keyNameValue = keyName.toCode(
      loop,
      resultType: ResultTypeEnum.string,
      defaultValue: '',
    );
    final keyValueValue = keyValue.toCode(
      loop,
      resultType: ResultTypeEnum.string,
      defaultValue: '',
    );
    final filter = keyNameValue.replaceAll("'", '') != ' ' &&
            keyNameValue.replaceAll("'", ' ') != ''
        ? 'Filter($keyName, $keyValue)'
        : '';

    return '''
    datasets['Cms init fetch'] = await TetaCMS.instance.client.getCollection(
      $collectionId,
      filters: [
        $filter
      ], 
      ${limitValue.isNotEmpty ? 'limit: $limit,' : ''}
      ${pageValue.isNotEmpty ? 'page: $page,' : ''}
    );''';
  }
}
