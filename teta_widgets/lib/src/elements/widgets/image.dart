// Flutter imports:
// ignore_for_file: public_member_api_docs

// Dart imports:
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cross_file/cross_file.dart';
import 'package:teta_core/teta_core.dart';

// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WImage extends StatefulWidget {
  /// Returns a Image
  const WImage(
    Key? key, {
    required this.image,
    required this.node,
    required this.width,
    required this.height,
    required this.boxFit,
    required this.borderRadius,
    required this.shadows,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final FSize width;
  final FSize height;
  final FTextTypeInput image;
  final FBoxFit boxFit;
  final FBorderRadius borderRadius;
  final FShadow shadows;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  State<WImage> createState() => _WImageState();
}

class _WImageState extends State<WImage> {
  dynamic result;
  Uint8List? bytes;

  @override
  void initState() {
    result = widget.image.getForImages(
      widget.params,
      widget.states,
      widget.dataset,
      widget.loop,
      forPlay: widget.forPlay,
    );
    if (result is XFile) {
      calc();
    }
    super.initState();
  }

  Future<void> calc() async {
    final b = await (result as XFile).readAsBytes();
    if (mounted) {
      setState(() {
        bytes = b;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: ClipRRect(
        borderRadius: widget.borderRadius.get,
        child: SizedBox(
          width: widget.width.get(context: context, isWidth: true),
          height: widget.height.get(context: context, isWidth: false),
          child: result is XFile
              ? bytes == null
                  ? const SizedBox()
                  : Image.memory(
                      bytes!,
                      width: widget.width.get(context: context, isWidth: true),
                      height:
                          widget.height.get(context: context, isWidth: false),
                      fit: widget.boxFit.get,
                    )
              : CNetworkImage(
                  nid: widget.node.nid,
                  src: '$result',
                  loop: widget.loop ?? 0,
                  width: widget.width.get(context: context, isWidth: true),
                  height: widget.height.get(context: context, isWidth: false),
                  fit: widget.boxFit.fit,
                ),
        ),
      ),
    );
  }
}
