// Flutter imports:

// Package imports:
import 'package:device_info_plus/device_info_plus.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WDeviceInfo extends StatefulWidget {
  /// Returns a DeviceInfo Repository,
  /// which provides info for the actual device.
  const WDeviceInfo(
    final Key? key, {
    required this.node,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  _WDeviceInfoState createState() => _WDeviceInfoState();
}

class _WDeviceInfoState extends State<WDeviceInfo> {
  DatasetObject _map = DatasetObject(
    name: 'Device Info',
    map: [
      <String, dynamic>{
        'Android Model': 'It will works on exported app only.',
        'Android Device': 'It will works on exported app only.',
        'Android Brand': 'It will works on exported app only.',
        'Android Display': 'It will works on exported app only.',
        'Android Version': 'It will works on exported app only.',
        'iOS Model': 'It will works on exported app only.',
        'iOS Name': 'It will works on exported app only.',
        'iOS System Name': 'It will works on exported app only.',
        'iOS System Version': 'It will works on exported app only.',
        'Browser Name': 'Chrome',
        'Browser Platform': '',
        'Browser Language': 'EN',
      }
    ],
  );

  @override
  Widget build(final BuildContext context) {
    final list = addDataset(context, widget.dataset, _map);

    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: ChildConditionBuilder(
        ValueKey('${widget.node.nid} ${widget.loop}'),
        name: widget.node.intrinsicState.displayName,
        node: widget.node,
        child: widget.child,
        params: widget.params,
        states: widget.states,
        dataset: list.isNotEmpty ? list : widget.dataset,
        forPlay: widget.forPlay,
        loop: widget.loop,
      ),
    );
  }

  Future<void> detect() async {
    final deviceInfo = DeviceInfoPlugin();
    final webBrowserInfo = await deviceInfo.webBrowserInfo;

    if (mounted) {
      setState(() {
        _map = _map.copyWith(
          name: 'Device Info',
          map: [
            <String, dynamic>{
              'Android Model': 'It will works on exported app only.',
              'Android Device': 'It will works on exported app only.',
              'Android Brand': 'It will works on exported app only.',
              'Android Display': 'It will works on exported app only.',
              'Android Version': 'It will works on exported app only.',
              'iOS Model': 'It will works on exported app only.',
              'iOS Name': 'It will works on exported app only.',
              'iOS System Name': 'It will works on exported app only.',
              'iOS System Version': 'It will works on exported app only.',
              'Browser Name': webBrowserInfo.browserName,
              'Browser Platform': webBrowserInfo.platform,
              'Browser Language': webBrowserInfo.language,
            }
          ],
        );
      });
    }
  }
}
