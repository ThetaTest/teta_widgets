// Flutter imports:
// ignore_for_file: public_member_api_docs

// Dart imports:
import 'dart:async';
import 'dart:typed_data';

// Package imports:
import 'package:after_layout/after_layout.dart';
import 'package:cross_file/cross_file.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';

class WImage extends StatefulWidget {
  /// Returns a Image
  const WImage(
    final Key? key, {
    required this.state,
    required this.image,
    required this.width,
    required this.height,
    required this.boxFit,
    required this.borderRadius,
    required this.shadows,
  }) : super(key: key);

  final TetaWidgetState state;
  final FSize width;
  final FSize height;
  final FTextTypeInput image;
  final FBoxFit boxFit;
  final FBorderRadius borderRadius;
  final FShadow shadows;

  @override
  State<WImage> createState() => _WImageState();
}

class _WImageState extends State<WImage> with AfterLayoutMixin {
  dynamic result;
  Uint8List? bytes;
  bool isLoading = false;

  @override
  FutureOr<void> afterFirstLayout(final BuildContext context) {
    setState(() {
      result = widget.image.getForImages(
        widget.state.params,
        widget.state.states,
        widget.state.dataset,
        widget.state.loop,
        forPlay: widget.state.forPlay,
        context: context,
      );
    });
    if (result is XFile) {
      calc();
    }
  }

  Future<void> calc() async {
    if (bytes == null) {
      final b = await (result as XFile).readAsBytes();
      setState(() {
        result = result;
        bytes = b;
      });
    }
  }

  @override
  Widget build(final BuildContext context) {
    if (isLoading) {
      return SizedBox(
        width: widget.width.get(
          context: context,
          isWidth: true,
          forPlay: widget.state.forPlay,
        ),
        height: widget.height.get(
          context: context,
          isWidth: false,
          forPlay: widget.state.forPlay,
        ),
        child: const CircularProgressIndicator(),
      );
    }

    return TetaWidget(
      state: widget.state,
      child: ClipRRect(
        borderRadius:
            widget.borderRadius.get(context, forPlay: widget.state.forPlay),
        child: SizedBox(
          width: widget.width.get(
            context: context,
            isWidth: true,
            forPlay: widget.state.forPlay,
          ),
          height: widget.height.get(
            context: context,
            isWidth: false,
            forPlay: widget.state.forPlay,
          ),
          child: _LocalImage(
            key: ValueKey('Image ${widget.state.node.nid} $bytes $result'),
            nid: widget.state.node.nid,
            result: result,
            bytes: bytes,
            loop: widget.state.loop,
            width: widget.width.get(
              context: context,
              isWidth: true,
              forPlay: widget.state.forPlay,
            ),
            height: widget.height.get(
              context: context,
              isWidth: false,
              forPlay: widget.state.forPlay,
            ),
            fit: widget.boxFit.get,
          ),
        ),
      ),
    );
  }
}

class _LocalImage extends StatefulWidget {
  const _LocalImage({
    required this.nid,
    required this.result,
    required this.bytes,
    required this.width,
    required this.height,
    required this.fit,
    required this.loop,
    final Key? key,
  }) : super(key: key);

  final int nid;
  final int? loop;
  final dynamic result;
  final Uint8List? bytes;
  final double? width, height;
  final BoxFit fit;

  @override
  State<_LocalImage> createState() => _LocalImageState();
}

class _LocalImageState extends State<_LocalImage> {
  @override
  Widget build(final BuildContext context) {
    return widget.result is XFile
        ? widget.bytes == null
            ? const SizedBox()
            : Image.memory(
                widget.bytes!,
                width: widget.width,
                height: widget.height,
                fit: widget.fit,
              )
        : CNetworkImage(
            nid: widget.nid,
            src: widget.result == ''
                ? 'https://ymvwltogicatbkjlaswo.supabase.co/storage/v1/object/public/assets/Frame%203.jpg'
                : '${widget.result}',
            loop: widget.loop ?? 0,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
          );
  }
}
