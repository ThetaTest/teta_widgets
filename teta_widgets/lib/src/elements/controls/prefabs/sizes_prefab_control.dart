// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/atoms/size.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';

class SizesPrefabControl extends StatelessWidget {
  const SizesPrefabControl({
    required this.values,
    final Key? key,
  }) : super(key: key);

  final List<FSize> values;

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 16, bottom: 8),
          child: TParagraph(
            'Sizes',
          ),
        ),
        SizeControl(
          size: values.first,
          isWidth: true,
          title: 'Width',
          keyAttr: DBKeys.width,
          isFromSizesPrefab: true,
          callBack: (final value, final old) {
            final nodeId = BlocProvider.of<FocusBloc>(context).state.first;
            final node = (context.read<PageCubit>().state as PageLoaded)
                .page
                .flatList
                .firstWhere((final element) => element.nid == nodeId);
            node.body.attributes[DBKeys.width] = value;
            ControlBuilder.toDB(
              node,
              context,
              DBKeys.width,
              value,
              old,
            );
          },
        ),
        const Gap(Grid.medium),
        SizeControl(
          size: values.last,
          isWidth: false,
          title: 'Height',
          keyAttr: DBKeys.height,
          isFromSizesPrefab: true,
          callBack: (final value, final old) {
            final nodeId = BlocProvider.of<FocusBloc>(context).state.first;
            final node = (context.read<PageCubit>().state as PageLoaded)
                .page
                .flatList
                .firstWhere((final element) => element.nid == nodeId);
            node.body.attributes[DBKeys.height] = value;
            ControlBuilder.toDB(
              node,
              context,
              DBKeys.height,
              value,
              old,
            );
          },
        ),
      ],
    );
  }
}
