// Flutter imports:

// Package imports:
import 'package:device_info_plus/device_info_plus.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WDeviceInfo extends StatefulWidget {
  /// Returns a DeviceInfo Repository,
  /// which provides info for the actual device.
  const WDeviceInfo(
    final Key? key, {
    required this.state,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;

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
    final list = addDataset(context, _map);

    return TetaWidget(
      state: widget.state,
      child: ChildConditionBuilder(
        ValueKey('${widget.state.node.nid} ${widget.state.loop}'),
        state: widget.state.copyWith(
          dataset: list.isNotEmpty ? list : widget.state.dataset,
        ),
        child: widget.child,
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
