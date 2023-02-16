// Flutter imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

// Flutter imports:
import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hovering/hovering.dart';
import 'package:teta_core/src/design_system/textfield/minitextfield.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/features.dart';

class SizeControl extends StatefulWidget {
  const SizeControl({
    required this.keyAttr,
    required this.size,
    required this.isWidth,
    required this.title,
    required this.callBack,
    required this.isFromSizesPrefab,
    final Key? key,
  }) : super(key: key);

  final String keyAttr;
  final FSize size;
  final bool isWidth;
  final String title;
  final bool isFromSizesPrefab;
  final Function(FSize, FSize) callBack;

  @override
  SizeControlsState createState() => SizeControlsState();
}

class SizeControlsState extends State<SizeControl> {
  TextEditingController controller = TextEditingController();
  bool flag = false;
  SizeUnit unit = SizeUnit.pixel;

  @override
  void initState() {
    controller.text = '${widget.size.get(
      context: context,
      isWidth: widget.isWidth,
      forPlay: false,
    )}';
    unit = widget.size.getUnit(context);
    Logger.printMessage('Unit: $unit');
    flag = widget.size
            .get(context: context, isWidth: widget.isWidth, forPlay: false) !=
        null;
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<DeviceModeCubit, DeviceState>(
      listener: (final context, final device) {
        setState(() {
          unit = widget.size.getUnit(context);
          flag = widget.size.get(
                context: context,
                isWidth: widget.isWidth,
                forPlay: false,
              ) !=
              null;
          String? size;
          if (device.info.identifier.type == DeviceType.phone) {
            size = widget.size.size;
          } else if (device.info.identifier.type == DeviceType.tablet) {
            size = widget.size.sizeTablet;
          } else {
            size = widget.size.sizeDesktop;
          }
          final text = (size == 'max' ||
                  size == 'inf' && size == '100%' && unit == SizeUnit.pixel)
              ? 'max'
              : (size == 'max' ||
                      size == 'inf' &&
                          size == '100%' &&
                          unit == SizeUnit.percent)
                  ? '100%'
                  : (widget.size.size == 'auto')
                      ? 'auto'
                      : '$size';
          if (text != controller.text) {
            controller.text = text;
          }
        });
      },
      child: BlocBuilder<DeviceModeCubit, DeviceState>(
        builder: (final context, final device) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8, right: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const DeviceIndicatorForControls(),
                      CSwitch(
                        callback: (final v) {
                          final value = v
                              ? widget.isWidth
                                  ? 'max'
                                  : '150'
                              : 'null';
                          setState(() {
                            flag = v;
                          });
                          final szs = widget.size;
                          final old = FSize.fromJson(widget.size.toJson());
                          value.replaceAll('%', '');
                          szs.updateSize(value, context);
                          final nodeId =
                              BlocProvider.of<FocusBloc>(context).state.first;
                          final node =
                              (context.read<PageCubit>().state as PageLoaded)
                                  .page
                                  .flatList
                                  .firstWhere(
                                    (final element) => element.nid == nodeId,
                                  );

                          node.body.attributes[widget.keyAttr] = szs;
                          widget.callBack(szs, old);
                        },
                        value: flag,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TParagraph(
                          '$unit',
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: widget.size.get(
                          context: context,
                          isWidth: widget.isWidth,
                          forPlay: false,
                        ) !=
                        null,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BounceSmall(
                          onTap: () {
                            final old = FSize.fromJson(widget.size.toJson());
                            widget.size.updateUnit(SizeUnit.pixel, context);
                            widget.callBack(widget.size, old);
                            setState(() {
                              unit = SizeUnit.pixel;
                            });
                          },
                          child: VisualIcon(
                            unit: SizeUnit.pixel,
                            unitFromNode: unit,
                          ),
                        ),
                        BounceSmall(
                          onTap: () {
                            final old = FSize.fromJson(widget.size.toJson());
                            widget.size.updateUnit(SizeUnit.percent, context);
                            Logger.printMessage(
                              'Size toJson: ${widget.size.toJson()}',
                            );
                            widget.callBack(widget.size, old);
                            setState(() {
                              unit = SizeUnit.percent;
                            });
                          },
                          child: VisualIcon(
                            unit: SizeUnit.percent,
                            unitFromNode: unit,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: widget.size.get(
                    context: context,
                    isWidth: widget.isWidth,
                    forPlay: false,
                  ) !=
                  null,
              child: IgnorePointer(
                ignoring: widget.size.get(
                      context: context,
                      isWidth: widget.isWidth,
                      forPlay: false,
                    ) ==
                    null,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width >= 600
                          ? 300
                          : MediaQuery.of(context).size.width - 20,
                      height: 60,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: CMiniTextField(
                                controller: controller,
                                text: (device.info.identifier.type ==
                                        DeviceType.phone)
                                    ? widget.size.size
                                    : (device.info.identifier.type ==
                                            DeviceType.tablet)
                                        ? widget.size.sizeTablet
                                        : widget.size.sizeDesktop,
                                callBack: (final value) {
                                  final szs = widget.size;
                                  final old =
                                      FSize.fromJson(widget.size.toJson());
                                  value.replaceAll('%', '');
                                  szs.updateSize(value, context);
                                  final nodeId =
                                      BlocProvider.of<FocusBloc>(context)
                                          .state
                                          .first;
                                  final node = (context.read<PageCubit>().state
                                          as PageLoaded)
                                      .page
                                      .flatList
                                      .firstWhere(
                                        (final element) =>
                                            element.nid == nodeId,
                                      );
                                  node.body.attributes[widget.keyAttr] = szs;
                                  widget.callBack(
                                    szs,
                                    old,
                                  );
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 12,
                            bottom: 18,
                            child: Container(
                              color: Palette.bgTertiary,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      final old = FSize.fromJson(
                                        widget.size.toJson(),
                                      );
                                      widget.size.updateSize(
                                        widget.size.unit == SizeUnit.pixel
                                            ? 'max'
                                            : '100%',
                                        context,
                                      );
                                      final nodeId = BlocProvider.of<FocusBloc>(
                                        context,
                                      ).state.first;
                                      final node = (context
                                              .read<PageCubit>()
                                              .state as PageLoaded)
                                          .page
                                          .flatList
                                          .firstWhere(
                                            (final element) =>
                                                element.nid == nodeId,
                                          );
                                      node.body.attributes[widget.keyAttr] =
                                          widget.size;
                                      widget.callBack(
                                        widget.size,
                                        old,
                                      );
                                      controller.text =
                                          widget.size.unit == SizeUnit.pixel
                                              ? 'max'
                                              : '100%';
                                    },
                                    child: maxIcon(
                                      unit: widget.size.unit,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget maxIcon({final SizeUnit? unit}) {
    return TContainer(
      key: UniqueKey(),
      width: 32,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          style: BorderStyle.none,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Center(
        child: TDetailLabel(
          'Max',
          color: Palette.txtGrey,
        ),
      ),
    );
  }
}

class VisualIcon extends StatelessWidget {
  const VisualIcon({super.key, required this.unit, required this.unitFromNode});

  final SizeUnit? unit;
  final SizeUnit? unitFromNode;

  @override
  Widget build(final BuildContext context) {
    late BoxDecoration decoration;
    late BoxDecoration hoverDecoration;
    if (unitFromNode == unit) {
      decoration = BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(4),
      );
      hoverDecoration = BoxDecoration(
        color: Colors.white24,
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(4),
      );
    } else {
      decoration = BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
      );
      hoverDecoration = BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(4),
      );
    }
    return HoverWidget(
      hoverChild: Container(
        width: 32,
        height: 32,
        decoration: hoverDecoration,
        child: Center(
          child: TDetailLabel(
            unit == SizeUnit.pixel
                ? 'px'
                : unit == SizeUnit.percent
                    ? '%'
                    : unit == SizeUnit.width
                        ? '.w'
                        : '.h',
          ),
        ),
      ),
      onHover: (final event) {},
      child: Container(
        width: 32,
        height: 32,
        decoration: decoration,
        child: Center(
          child: TDetailLabel(
            unit == SizeUnit.pixel
                ? 'px'
                : unit == SizeUnit.percent
                    ? '%'
                    : unit == SizeUnit.width
                        ? '.w'
                        : '.h',
          ),
        ),
      ),
    );
  }
}
