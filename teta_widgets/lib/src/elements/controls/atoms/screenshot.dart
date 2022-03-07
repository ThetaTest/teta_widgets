/*import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_editor/src/blocs/data/index.dart';
import 'package:mobile_editor/src/blocs/flat_list/index.dart';
import 'package:mobile_editor/src/blocs/focus/index.dart';
import 'package:mobile_editor/src/blocs/focus_page/index.dart';
import 'package:mobile_editor/src/blocs/focus_project/index.dart';
import 'package:mobile_editor/src/blocs/nodes/index.dart';
import 'package:mobile_editor/src/blocs/palette/index.dart';
import 'package:mobile_editor/src/blocs/text_styles/index.dart';
import 'package:mobile_editor/src/cubits/device_mode/cubit.dart';
import 'package:mobile_editor/src/cubits/mixpanel/cubit.dart';
import 'package:mobile_editor/src/cubits/scrollY/cubit.dart';
import 'package:mobile_editor/src/cubits/zoomable/cubit.dart';
import 'package:mobile_editor/src/design_system/palette.dart';
import 'package:mobile_editor/src/design_system/text.dart';
import 'package:mobile_editor/src/repositories/assets.dart';
import 'package:mobile_editor/src/utils/frame/device_frame.dart';
import 'package:screenshot/screenshot.dart';

class ScreenShotControl extends StatefulWidget {
  ScreenShotControl({Key? key}) : super(key: key);

  @override
  _ScreenShotControlState createState() => _ScreenShotControlState();
}

class _ScreenShotControlState extends State<ScreenShotControl> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CText(
            'Take screenshot',
            color: Palette.white,
            size: 12,
            weight: FontWeight.w500,
          ),
          TextButton(
            onPressed: () {
              final nodes = BlocProvider.of<NodesBloc>(context).state;
              final prjState = BlocProvider.of<FocusProjectBloc>(context).state
                  as ProjectLoaded;
              final page = BlocProvider.of<FocusPageBloc>(context).state;
              screenshotController
                  .captureFromWidget(
                    MaterialApp(
                      home: MultiBlocProvider(
                        providers: [
                          BlocProvider<FocusProjectBloc>(
                            create: (context) => FocusProjectBloc()
                              ..add(OnFocusPrj(
                                  prj: prjState.prj, context: context)),
                          ),
                          BlocProvider<FocusBloc>(
                            create: (context) => FocusBloc(),
                          ),
                          BlocProvider<FocusPageBloc>(
                            create: (context) => FocusPageBloc()
                              ..add(
                                OnFocusPage(
                                  prj: prjState.prj,
                                  page: page,
                                  context: context,
                                  forPlay: false,
                                ),
                              ),
                          ),
                          BlocProvider<NodesBloc>(
                            create: (context) => NodesBloc()
                              ..add(
                                InitializingNodesBloc(
                                  page: page,
                                  node: page.scaffold!,
                                  list: page.flatList!,
                                ),
                              ),
                          ),
                          BlocProvider<FlatListBloc>(
                            create: (context) => FlatListBloc()
                              ..add(
                                InitializingFlatList(
                                  scaffold: page.scaffold!,
                                ),
                              ),
                          ),
                          BlocProvider<DeviceModeCubit>(
                            create: (context) => DeviceModeCubit(),
                          ),
                          BlocProvider(
                            create: (context) => TextStylesBloc()
                              ..add(FetchTextStyles(prj: prjState.prj.id)),
                          ),
                          BlocProvider(
                            create: (context) => PaletteBloc()
                              ..add(FetchPalette(prj: prjState.prj.id)),
                          ),
                          BlocProvider(
                            create: (context) => DataBloc()
                              ..add(FetchData(prj: prjState.prj.id)),
                          ),
                          BlocProvider(create: (context) => ZoomableCubit()),
                          BlocProvider(create: (context) => MixPanelCubit()),
                          BlocProvider(create: (context) => ScrollYCubit()),
                        ],
                        child: Center(
                          child: Transform.scale(
                            scale: 0.9,
                            child: DeviceFrame(
                              device: Devices.ios.iPhone11,
                              isFrameVisible: true,
                              orientation: Orientation.portrait,
                              screen: Material(
                                clipBehavior: Clip.hardEdge,
                                elevation: 0,
                                color: Colors.transparent,
                                child: MaterialApp(
                                  debugShowCheckedModeBanner: false,
                                  home: BlocBuilder<ZoomableCubit, bool>(
                                    builder: (context, state) =>
                                        nodes.first.toWidget(
                                      forPlay: true,
                                      params: nodes.first.params!,
                                      states: nodes.first.states!,
                                      dataset: nodes.first.dataset!,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    delay: Duration(milliseconds: 6000),
                  )
                  .then((value) => AssetsRepository().saveScreenShot(value));
            },
            child: Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.symmetric(vertical: 16),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  "Screenshot",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
*/
