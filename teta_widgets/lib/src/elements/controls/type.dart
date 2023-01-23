// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_repositories/src/node_repository.dart';
import 'package:teta_repositories/src/project_repository.dart';
import 'package:teta_repositories/src/project_styles_repository.dart';
import 'package:teta_repositories/teta_repositories.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/atoms/action.dart';
import 'package:teta_widgets/src/elements/controls/atoms/aligns.dart';
import 'package:teta_widgets/src/elements/controls/atoms/apicalls_request.dart';
import 'package:teta_widgets/src/elements/controls/atoms/audio_controller.dart';
import 'package:teta_widgets/src/elements/controls/atoms/barcode.dart';
import 'package:teta_widgets/src/elements/controls/atoms/border_radius.dart';
import 'package:teta_widgets/src/elements/controls/atoms/borders.dart';
import 'package:teta_widgets/src/elements/controls/atoms/box_fit.dart';
import 'package:teta_widgets/src/elements/controls/atoms/camera_controller.dart';
import 'package:teta_widgets/src/elements/controls/atoms/cms_collections.dart';
import 'package:teta_widgets/src/elements/controls/atoms/code_field.dart';
import 'package:teta_widgets/src/elements/controls/atoms/cross_axis_alignment.dart';
import 'package:teta_widgets/src/elements/controls/atoms/dataset.dart';
import 'package:teta_widgets/src/elements/controls/atoms/fill.dart';
import 'package:teta_widgets/src/elements/controls/atoms/firebase/path.dart';
import 'package:teta_widgets/src/elements/controls/atoms/flag.dart';
import 'package:teta_widgets/src/elements/controls/atoms/google_maps_control.dart';
import 'package:teta_widgets/src/elements/controls/atoms/google_maps_map_style_controls.dart';
import 'package:teta_widgets/src/elements/controls/atoms/httpMethodControl.dart';
import 'package:teta_widgets/src/elements/controls/atoms/icon.dart';
import 'package:teta_widgets/src/elements/controls/atoms/icon_feather.dart';
import 'package:teta_widgets/src/elements/controls/atoms/icon_fontawesome.dart';
import 'package:teta_widgets/src/elements/controls/atoms/icon_line.dart';
import 'package:teta_widgets/src/elements/controls/atoms/main_axis_alignment.dart';
import 'package:teta_widgets/src/elements/controls/atoms/main_axis_size.dart';
import 'package:teta_widgets/src/elements/controls/atoms/map_controller.dart';
import 'package:teta_widgets/src/elements/controls/atoms/margins.dart';
import 'package:teta_widgets/src/elements/controls/atoms/navigation/component.dart';
import 'package:teta_widgets/src/elements/controls/atoms/page_params.dart';
import 'package:teta_widgets/src/elements/controls/atoms/physics.dart';
import 'package:teta_widgets/src/elements/controls/atoms/size.dart';
import 'package:teta_widgets/src/elements/controls/atoms/src_image.dart';
import 'package:teta_widgets/src/elements/controls/atoms/page_states.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
import 'package:teta_widgets/src/elements/controls/atoms/webview_controller.dart';
import 'package:teta_widgets/src/elements/controls/current_song_controll.dart';
import 'package:teta_widgets/src/elements/controls/google_maps_cubit_control.dart';
import 'package:teta_widgets/src/elements/controls/http_params.dart';
import 'package:teta_widgets/src/elements/controls/prefabs/sizes_prefab_control.dart';
import 'package:teta_widgets/src/elements/controls/prefabs/text_prefab_control.dart';
import 'package:teta_widgets/src/elements/features/google_maps_map_style.dart';
import 'package:teta_widgets/src/elements/features/physic.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:very_good_analysis/very_good_analysis.dart';

enum ControlType {
  /// Made for colors, gradients and images.
  fill,

  /// Made to use borderRadius.
  borderRadius,

  /// Made to use borders
  border,

  /// Made to use margins.
  margins,

  /// Made to use padding.
  padding,

  /// Made to use physics behaviours in listviews
  physics,

  /// Made to use textStyle and all the text properties of Text() and similar.
  ///
  /// ControlType.text is made to set e.g. TextAlign, FontSize, FontFamily etc.
  text,

  /// Made to use a text / string value.
  value,

  /// Made to use a text / string value for image.
  image,

  /// Made to use width or height.
  size,

  /// Made to use width and height together in one control.
  ///
  /// It is made for Container, SizedBox and all the widgets
  /// which want both width and height.
  sizes,

  /// Made to use shadows.
  shadows,

  /// Made to use Material (mdi) icon.
  icon,

  /// Made to use FontAwsome icon.
  fontAwesomeIcon,

  /// Made to use Feather icon.
  featherIcon,

  /// Made to use Line icon.
  lineIcon,

  /// Made to use a flag / bool value.
  flag,

  /// Made to use alignment.
  ///
  /// Attention: this is for FAlign only, not FTextAlign.
  align,

  /// Made to delete.
  delete,

  /// Made to use boxFit.
  boxFit,

  /// Made to use FFirebasePath.
  firebasePath,

  /// Made to set a video url.
  videoUrl,

  /// Made to set a video start point.
  videoStartAt,

  /// Made to set a component.
  component,

  /// Made to use conditions.
  condition,

  /// Made to use FAction.
  action,

  /// Made to use flat string.
  string,

  /// Made to use FMainAxisAlignment.
  mainAxisAlignment,

  /// Returns the selected string
  googleMapsMapStyle,

  /// Made to use FCrossAxisAlignment.
  crossAxisAlignment,

  /// Made to use FMainAxisSize.
  mainAxisSize,

  /// Made to select dataset only
  datasetType,
  barcode,
  params,
  states,
  cameraController,
  webViewController,
  audioController,
  audioPlayerCurrentDataset,
  mapController,
  googleMapsController,
  googleMapsCubitController,
  cmsCollections,
  cmsCustomQuery,
  httpParamsControl,
  httpMethodControl,
  apiCallsRequestControl,
}

/// Set of funcs to generate the focused widget' controls.
class ControlBuilder {
  /// It makes a call to NodeRepository.change.
  static Future<void> toDB(
    final CNode node,
    final BuildContext context,
    final String key,
    final dynamic value,
    final dynamic old,
  ) async {
    final prj = BlocProvider.of<FocusProjectCubit>(context).state!;
    sl.get<ProjectRepository>().track(prj.id);
    sl.get<NodeRepository>().changeNode(
          node: node as NDynamic,
        );
  }

  /// Returns a control widget based of [control] value.
  static Widget builder({
    required final BuildContext context,
    required final ControlModel control,
  }) {
    if (control is ControlObject) {
      return ControlBuilder.genericControlBuilder(
        context: context,
        control: control,
      );
    }
    if (control is FlagControlObject) {
      return ControlBuilder.flagControlBuilder(
        context: context,
        control: control,
      );
    }
    if (control is FillControlObject) {
      return ControlBuilder.fillControlBuilder(
        isImageEnabled: control.isImageEnabled,
        isNoneEnabled: control.isNoneEnabled,
        isOnlySolid: control.isOnlySolid,
        context: context,
        control: control,
      );
    }
    if (control is SizeControlObject) {
      return ControlBuilder.sizeControlBuilder(
        context: context,
        control: control,
      );
    }
    if (control is SizesControlObject) {
      return ControlBuilder.sizesControlBuilder(
        context: context,
        control: control,
      );
    }
    if (control is BoxFitControlObject) {
      return ControlBuilder.boxFitControlBuilder(
        context: context,
        control: control,
      );
    }
    return const SizedBox();
  }

  /// Returns a control widget based on control.type.
  static Widget genericControlBuilder({
    required final BuildContext context,
    required final ControlObject control,
  }) {
    final node = BlocProvider.of<FocusBloc>(context).state.first;
    if (control.type == ControlType.barcode) {
      return BarcodeControl(
        key: ValueKey(
          '${node.nid} ${(control.value as FTextTypeInput).value}',
        ),
        value: control.value.runtimeType == FTextTypeInput
            ? control.value as FTextTypeInput
            : FTextTypeInput(),
        callBack: (final value, final old) {
          ControlBuilder.toDB(
            BlocProvider.of<FocusBloc>(context).state.first,
            context,
            control.key,
            value.toJson(),
            old.toJson(),
          );
        },
      );
    }
    if (control.type == ControlType.cmsCustomQuery) {
      return CodeFieldControl(
        key: ValueKey(
          '${node.nid} ${(control.value as FTextTypeInput).value}',
        ),
        value: control.value.runtimeType == FTextTypeInput
            ? control.value as FTextTypeInput
            : FTextTypeInput(),
        callBack: (final value, final old) {
          ControlBuilder.toDB(
            node,
            context,
            control.key,
            value.toJson(),
            old.toJson(),
          );
        },
      );
    }
    if (control.type == ControlType.cmsCollections) {
      return descriptionControlWidget(
        description: control.description,
        control: CMSCollectionControl(
          key: ValueKey(
            '${node.nid} ${(node.body.attributes[control.key] as FTextTypeInput).value}',
          ),
          collectionId:
              (node.body.attributes[control.key] as FTextTypeInput).value ?? '',
          callBack: (final value, final old) {
            node.body.attributes[control.key] = FTextTypeInput(value: value);
            ControlBuilder.toDB(
              node,
              context,
              control.key,
              FTextTypeInput(value: value).toJson(),
              FTextTypeInput(value: old).toJson(),
            );
          },
        ),
      );
    }
    if (control.type == ControlType.audioPlayerCurrentDataset) {
      return descriptionControlWidget(
        description: control.description,
        control: CurrentSongControl(
          key: ValueKey('${node.nid}'),
          title: control.title ?? 'Current audio player data set',
          value: control.value as FTextTypeInput,
          callBack: (final value, final old) => ControlBuilder.toDB(
            node,
            context,
            control.key,
            value.toJson(),
            old.toJson(),
          ),
        ),
      );
    }
    if (control.type == ControlType.audioController) {
      return descriptionControlWidget(
        description: control.description,
        control: AudioControllerControl(
          key: ValueKey('${node.nid}'),
          title: control.title ?? 'Audio Controller',
          value: control.value as FTextTypeInput,
          callBack: (final value, final old) => ControlBuilder.toDB(
            node,
            context,
            control.key,
            value.toJson(),
            old.toJson(),
          ),
        ),
      );
    }
    if (control.type == ControlType.mapController) {
      return descriptionControlWidget(
        description: control.description,
        control: MapControllerControl(
          key: ValueKey('${node.nid}'),
          title: control.title ?? 'Map Controller',
          value: control.value as FTextTypeInput,
          callBack: (final value, final old) => ControlBuilder.toDB(
            node,
            context,
            control.key,
            value.toJson(),
            old.toJson(),
          ),
        ),
      );
    }

    if (control.type == ControlType.googleMapsController) {
      return descriptionControlWidget(
        description: control.description,
        control: GoogleMapsControl(
          key: ValueKey('${node.nid}'),
          title: control.title ?? 'Google Maps Controller',
          value: control.value as FTextTypeInput,
          callBack: (final value, final old) => ControlBuilder.toDB(
            node,
            context,
            control.key,
            value.toJson(),
            old.toJson(),
          ),
        ),
      );
    }

    if (control.type == ControlType.googleMapsCubitController) {
      return descriptionControlWidget(
        description: control.description,
        control: GoogleMapsCubitControl(
          key: ValueKey('${node.nid}'),
          title: control.title ?? 'Google Maps Cubit',
          value: control.value as FTextTypeInput,
          callBack: (final value, final old) => ControlBuilder.toDB(
            node,
            context,
            control.key,
            value.toJson(),
            old.toJson(),
          ),
        ),
      );
    }

    if (control.type == ControlType.cameraController) {
      return descriptionControlWidget(
        description: control.description,
        control: CameraControllerControl(
          key: ValueKey('${node.nid}'),
          title: control.title ?? 'Camera Controller',
          value: control.value as FTextTypeInput,
          callBack: (final value, final old) => ControlBuilder.toDB(
            node,
            context,
            control.key,
            value.toJson(),
            old.toJson(),
          ),
        ),
      );
    }
    if (control.type == ControlType.webViewController) {
      return descriptionControlWidget(
        description: control.description,
        control: WebViewControllerControl(
          key: ValueKey('${node.nid}'),
          title: control.title ?? 'WebView Controller',
          value: control.value as FTextTypeInput,
          callBack: (final value, final old) => ControlBuilder.toDB(
            node,
            context,
            control.key,
            value.toJson(),
            old.toJson(),
          ),
        ),
      );
    }
    if (control.type == ControlType.action) {
      return descriptionControlWidget(
        description: control.description,
        control: ActionControl(
          key: ValueKey('${node.nid}'),
          action: control.value as FAction,
          callBack: (final value, final old) {
            node.body.attributes[DBKeys.action] = value;
            ControlBuilder.toDB(
              node,
              context,
              control.key,
              value.toJson(),
              old.toJson(),
            );
          },
        ),
      );
    }
    if (control.type == ControlType.align) {
      return descriptionControlWidget(
        description: control.description,
        control: AlignsControl(
          key: ValueKey('${node.nid}'),
          align: control.value as FAlign,
          callBack: (final value, final old) {
            node.body.attributes[control.key] = value;
            ControlBuilder.toDB(
              node,
              context,
              control.key,
              value.toJson(),
              old.toJson(),
            );
          },
        ),
      );
    }
    if (control.type == ControlType.physics) {
      return descriptionControlWidget(
        description: control.description,
        control: PhysicsControl(
          key: ValueKey('${node.nid}'),
          physic: control.value as FPhysic,
          callBack: (final value, final old) {
            node.body.attributes[control.key] = value;
            ControlBuilder.toDB(
              node,
              context,
              control.key,
              value.toJson(),
              old.toJson(),
            );
          },
        ),
      );
    }
    if (control.type == ControlType.borderRadius) {
      return descriptionControlWidget(
        description: control.description,
        control: BorderRadiusControl(
          key: ValueKey('${node.nid}'),
          borderRadius: control.value as FBorderRadius,
          callBack: (final value, final old) => ControlBuilder.toDB(
            node,
            context,
            control.key,
            value,
            old,
          ),
        ),
      );
    }
    if (control.type == ControlType.border) {
      return descriptionControlWidget(
        description: control.description,
        control: BordersControl(
          key: ValueKey('${node.nid}'),
          borders: control.value as FBorder,
          callBack: (final value, final old) => ControlBuilder.toDB(
            node,
            context,
            control.key,
            value,
            old,
          ),
        ),
      );
    }
    if (control.type == ControlType.component) {
      return ComponentControl(
        key: ValueKey('${node.nid}'),
        callBack: (final value, final old) => ControlBuilder.toDB(
          node,
          context,
          control.key,
          value,
          old,
        ),
        callBackParameters: (final value) => ControlBuilder.toDB(
          node,
          context,
          DBKeys.paramsToSend,
          value,
          null,
        ),
      );
    }
    if (control.type == ControlType.condition) return const SizedBox();
    if (control.type == ControlType.crossAxisAlignment) {
      return descriptionControlWidget(
        description: control.description,
        control: CrossAxisAlignmentControls(
          key: ValueKey('${node.nid}'),
          crossAxisAlignment: control.value as FCrossAxisAlignment,
          callBack: (final value, final old) => ControlBuilder.toDB(
            node,
            context,
            control.key,
            value.toJson(),
            old.toJson(),
          ),
        ),
      );
    }
    if (control.type == ControlType.image) {
      return descriptionControlWidget(
        description: control.description,
        control: SrcImageControl(
          key: ValueKey('${node.nid}'),
          title: 'Image',
          image: control.value as FTextTypeInput,
          callBack: (final value, final old) => ControlBuilder.toDB(
            node,
            context,
            control.key,
            value.toJson(),
            old.toJson(),
          ),
        ),
      );
    }

    if (control.type == ControlType.icon) {
      return descriptionControlWidget(
        description: control.description,
        control: IconControl(
          key: ValueKey('${node.nid}'),
          icon: control.value as String,
          callBack: (final value, final old) {
            node.body.attributes[control.key] = value;
            ControlBuilder.toDB(
              node,
              context,
              control.key,
              value,
              old,
            );
          },
        ),
      );
    }
    if (control.type == ControlType.fontAwesomeIcon) {
      return descriptionControlWidget(
        description: control.description,
        control: IconFontAwesomeControl(
          key: ValueKey('${node.nid}'),
          icon: control.value as String,
          callBack: (final value, final old) {
            node.body.attributes[control.key] = value;
            ControlBuilder.toDB(
              node,
              context,
              control.key,
              value,
              old,
            );
          },
        ),
      );
    }
    if (control.type == ControlType.featherIcon) {
      return descriptionControlWidget(
        description: control.description,
        control: IconFeatherControl(
          key: ValueKey('${node.nid}'),
          icon: control.value as String,
          callBack: (final value, final old) {
            node.body.attributes[control.key] = value;
            ControlBuilder.toDB(
              node,
              context,
              control.key,
              value,
              old,
            );
          },
        ),
      );
    }
    if (control.type == ControlType.lineIcon) {
      return descriptionControlWidget(
        description: control.description,
        control: IconLineControl(
          key: ValueKey('${node.nid}'),
          icon: control.value as String,
          callBack: (final value, final old) {
            node.body.attributes[control.key] = value;
            ControlBuilder.toDB(
              node,
              context,
              control.key,
              value,
              old,
            );
          },
        ),
      );
    }
    if (control.type == ControlType.mainAxisAlignment) {
      return descriptionControlWidget(
        description: control.description,
        control: MainAxisAlignmentControls(
          key: ValueKey('${node.nid}'),
          mainAxisAlignment: control.value as FMainAxisAlignment,
          callBack: (final value, final old) => ControlBuilder.toDB(
            node,
            context,
            control.key,
            value.toJson(),
            old.toJson(),
          ),
        ),
      );
    }
    if (control.type == ControlType.googleMapsMapStyle) {
      return descriptionControlWidget(
        description: control.description,
        control: GoogleMapsMapStyleControls(
          key: ValueKey('${node.nid}'),
          mapStyle: control.value as FGoogleMapsMapStyle,
          callBack: (final value, final old) => ControlBuilder.toDB(
            node,
            context,
            control.key,
            value.toJson(),
            old.toJson(),
          ),
        ),
      );
    }
    if (control.type == ControlType.mainAxisSize) {
      return descriptionControlWidget(
        description: control.description,
        control: MainAxisSizeControl(
          key: ValueKey('${node.nid}'),
          size: control.value as FMainAxisSize,
          callBack: (final value, final old) => ControlBuilder.toDB(
            node,
            context,
            control.key,
            value.toJson(),
            old.toJson(),
          ),
        ),
      );
    }
    if (control.type == ControlType.margins) {
      return descriptionControlWidget(
        description: control.description,
        control: Margins(
          key: ValueKey('${node.nid}'),
          title: 'Margins',
          value: control.value as FMargins,
          callBack: (final value, final old) {
            node.body.attributes[control.key] = FMargins.fromJson(value);
            ControlBuilder.toDB(
              node,
              context,
              control.key,
              value,
              old,
            );
          },
        ),
      );
    }
    if (control.type == ControlType.padding) {
      return descriptionControlWidget(
        description: control.description,
        control: Margins(
          key: ValueKey('${node.nid}'),
          title: 'Padding',
          value: control.value as FMargins,
          callBack: (final value, final old) {
            node.body.attributes[control.key] = FMargins.fromJson(value);
            ControlBuilder.toDB(
              node,
              context,
              control.key,
              value,
              old,
            );
          },
        ),
      );
    }
    if (control.type == ControlType.shadows) return const SizedBox();
    if (control.type == ControlType.value) {
      return descriptionControlWidget(
        description: control.description,
        control: TextControl(
          key: ValueKey('${node.nid}'),
          valueType: control.valueType,
          title: control.title ?? 'Value',
          value: control.value as FTextTypeInput,
          callBack: (final value, final old) {
            node.body.attributes[control.key] = value;
            ControlBuilder.toDB(
              node,
              context,
              control.key,
              value.toJson(),
              old.toJson(),
            );
          },
        ),
      );
    }
    if (control.type == ControlType.datasetType) {
      return descriptionControlWidget(
        description: control.description,
        control: DatasetControl(
          key: ValueKey('${node.nid}'),
          title: control.title ?? 'From',
          value: control.value as FDataset,
          isAttrRequired: control.flag,
          callBack: (final value, final old) => ControlBuilder.toDB(
            node,
            context,
            control.key,
            value.toJson(),
            old.toJson(),
          ),
        ),
      );
    }
    if (control.type == ControlType.text) {
      return TextPrefabControl(
        title: control.title,
        key: ValueKey('${node.nid}'),
        textStyle: control.value as FTextStyle,
        keyValue: control.key,
      );
    }
    if (control.type == ControlType.httpParamsControl) {
      return HttpParamsControl(
        key: ValueKey('${node.nid}'),
        title: control.title,
        list: control.value as List<MapElement>,
        callBack: (final value, final old) => {
          node.body.attributes[control.key] = value,
          ControlBuilder.toDB(
            node,
            context,
            control.key,
            value,
            old,
          ),
        },
      );
    }
    if (control.type == ControlType.httpMethodControl) {
      return HttpMethodControl(
        key: ValueKey('${node.nid}'),
        title: control.title,
        httpMethod: control.value as String,
        callBack: (final value, final old) => {
          node.body.attributes[control.key] = value,
          ControlBuilder.toDB(
            node,
            context,
            control.key,
            value,
            old,
          ),
        },
      );
    }
    if (control.type == ControlType.apiCallsRequestControl) {
      return ApiCallsRequestControl(
        key: ValueKey('${node.nid}'),
        requestName: control.value as String,
        callBack: (final value, final old, final apiCallsSelectedRequest) => {
          node.body.attributes[control.key] = value,
          node.body.attributes[DBKeys.apiCallsSelectedRequest] =
              apiCallsSelectedRequest,
          ControlBuilder.toDB(
            node,
            context,
            control.key,
            value,
            old,
          ),
        },
      );
    }
    if (control.type == ControlType.params) {
      return descriptionControlWidget(
        description: control.description,
        control: PageParamsControl(
          key: ValueKey('${node.nid}'),
          callBack: (final list) async {
            await sl.get<PageRepository>().updatePage(
                  (BlocProvider.of<PageCubit>(context).state as PageLoaded)
                      .page,
                );
          },
        ),
      );
    }
    if (control.type == ControlType.states) {
      return descriptionControlWidget(
        description: control.description,
        control: StatesControl(
          key: ValueKey('${node.nid}'),
          callBack: (final list) async {
            await sl.get<PageRepository>().updatePage(
                  (BlocProvider.of<PageCubit>(context).state as PageLoaded)
                      .page,
                );
          },
        ),
      );
    }

    return const SizedBox();
  }

  /// Returns a BoxFitControl widget.
  static BoxFitControl boxFitControlBuilder({
    required final BuildContext context,
    required final BoxFitControlObject control,
  }) {
    return BoxFitControl(
      key: ValueKey('${BlocProvider.of<FocusBloc>(context).state.first.nid}'),
      boxFit: control.value,
      callBack: (final value, final old) => ControlBuilder.toDB(
        BlocProvider.of<FocusBloc>(context).state.first,
        context,
        control.key,
        value,
        old,
      ),
    );
  }

  /// Returns a FlagControl widget.
  static Widget flagControlBuilder({
    required final BuildContext context,
    required final FlagControlObject control,
  }) {
    return descriptionControlWidget(
      description: control.description,
      control: FlagControl(
        key: ValueKey('${BlocProvider.of<FocusBloc>(context).state.first.nid}'),
        title: control.title,
        keyValue: control.key,
        value: control.value as bool,
        callBack: (final value, final old) {
          BlocProvider.of<FocusBloc>(context)
              .state
              .first
              .body
              .attributes[control.key] = value;
          ControlBuilder.toDB(
            BlocProvider.of<FocusBloc>(context).state.first,
            context,
            control.key,
            value,
            old,
          );
        },
      ),
    );
  }

  /// Returns a FillControl.
  static FillControl fillControlBuilder({
    required final bool isImageEnabled,
    required final bool isNoneEnabled,
    required final bool isOnlySolid,
    required final BuildContext context,
    required final FillControlObject control,
  }) {
    return FillControl(
      title: control.title.isNotEmpty ? control.title : 'Fill',
      key: ValueKey('${BlocProvider.of<FocusBloc>(context).state.first.nid}'),
      isImageEnabled: isImageEnabled,
      isNoneEnabled: isNoneEnabled,
      type:
          isOnlySolid ? FillTypeControlType.onlySolid : FillTypeControlType.all,
      fill: control.value,
      callBack: (final value, final styled, final old) {
        BlocProvider.of<FocusBloc>(context)
            .state
            .first
            .body
            .attributes[control.key] = value;
        if (!styled) {
          ControlBuilder.toDB(
            BlocProvider.of<FocusBloc>(context).state.first,
            context,
            control.key,
            value.toJson(),
            old.toJson(),
          );
        }
        //! TODO:
        /* else {
          if (value.paletteStyle is int) {
            ProjectStylesRepository.updateColorStyle(
              ColorStyleModel(id: value.paletteStyle! as int, fill: value),
            );
          }
        }*/
      },
    );
  }

  /// Returns a FirestorePathControl.
  static FirestorePathControl firebasePathControlBuilder({
    required final BuildContext context,
    required final FirestorePathControlObject control,
  }) {
    return FirestorePathControl(
      key: ValueKey('${BlocProvider.of<FocusBloc>(context).state.first.nid}'),
      path: control.value,
      isForAddData: true,
      callBack: (final value, final old) => ControlBuilder.toDB(
        BlocProvider.of<FocusBloc>(context).state.first,
        context,
        control.key,
        value.toJson(),
        old.toJson(),
      ),
    );
  }

  /// Returns a SizeControl.
  ///
  /// This is used for width or height, not both.
  static SizeControl sizeControlBuilder({
    required final BuildContext context,
    required final SizeControlObject control,
  }) {
    return SizeControl(
      key: ValueKey('${BlocProvider.of<FocusBloc>(context).state.first.nid}'),
      isWidth: control.isWidth,
      title: control.title,
      size: control.value,
      isFromSizesPrefab: false,
      keyAttr: control.key,
      callBack: (final value, final old) => ControlBuilder.toDB(
        BlocProvider.of<FocusBloc>(context).state.first,
        context,
        control.key,
        value,
        old,
      ),
    );
  }

  /// Returns a SizesPrefabControl.
  ///
  /// This is used for width and height together.
  static Widget sizesControlBuilder({
    required final BuildContext context,
    required final SizesControlObject control,
  }) {
    return SizesPrefabControl(
      key: ValueKey('${BlocProvider.of<FocusBloc>(context).state.first.nid}'),
      values: control.values,
    );
  }
}

Widget descriptionControlWidget({
  required final String? description,
  required final Widget control,
}) =>
    Column(
      children: [
        control,
        if (description != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TDetailLabel(
                description,
                color: Colors.white70,
              ),
            ),
          ),
      ],
    );
