// ignore_for_file: public_member_api_docs

// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_models/src/models/constants_model.dart';
import 'package:teta_models/src/models/package.dart';
// Project imports:
import 'package:teta_widgets/src/elements/control_center.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/permissions.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/suggestion.dart';

class IntrinsicStates {
  IntrinsicStates({
    required this.nodeIcon,
    required this.nodeVideo,
    required this.nodeDescription,
    required this.advicedChildren,
    required this.blockedTypes,
    required this.synonymous,
    required this.advicedChildrenCanHaveAtLeastAChild,
    required this.displayName,
    required this.type,
    required this.maxChildren,
    required this.category,
    required this.canHave,
    required this.addChildLabels,
    required this.gestures,
    required this.permissions,
    required this.packages,
    this.constants = const [],
    this.suggestionsTitle = 'Need Help with this Widget?',
    this.suggestions = const [
      Suggestion(
        title: 'Docs',
        description: 'Docs',
        linkToOpen: 'https://docs.teta.so/teta-docs/',
      )
    ],
  });

  /// Icon of the node.
  final AssetGenImage nodeIcon;

  /// A video url to describe the node.
  final String? nodeVideo;

  /// Short description to describe the node.
  final String? nodeDescription;

  /// Advices children
  final List<String> advicedChildren;
  final List<String> blockedTypes;

  /// This node can be found by name's synonymous?
  ///
  /// e.g.
  /// Name: 'Container'. Synonymous: ['div', 'box']
  final List<String> synonymous;
  final List<String> advicedChildrenCanHaveAtLeastAChild;

  /// Visible name of node. Must be humanized.
  final String displayName;

  /// Type of node.
  final NType type;

  /// Max number of children the node can have.
  final int? maxChildren;

  /// Node's Category. It will be used in left widget panel.
  final NodeCategories category;

  /// This node can have a children, a child or none?
  final ChildrenEnum canHave;

  /// Labels displayed on tree graph.
  final List<String> addChildLabels;

  /// List of gesture supported by node.
  final List<ActionGesture> gestures;

  /// List of permissions to support in the released app -> dynamic based on node needs
  final List<Permissions> permissions;

  ///List of all packages required for this node to work
  final List<PackageModel> packages;

  ///List of all constants required for this node to work
  final List<ConstantsModel> constants;

  ///The headline for suggestions, label
  final String suggestionsTitle;

  /// Get all node suggestion.
  /// suggestion are the articles showed on right bar,
  /// used to let the user know how the node work
  final List<Suggestion> suggestions;

  bool get canHaveChildren => canHave == ChildrenEnum.children;
  bool get canHaveChild => canHave == ChildrenEnum.child;

  static IntrinsicStates get basic => IntrinsicStates(
        nodeIcon: Assets.wIcons.box,
        nodeVideo: null,
        nodeDescription: null,
        advicedChildren: const [],
        blockedTypes: const [],
        synonymous: const [],
        advicedChildrenCanHaveAtLeastAChild: const [],
        displayName: '',
        type: NType.nil,
        maxChildren: null,
        category: NodeCategories.unclassified,
        canHave: ChildrenEnum.none,
        addChildLabels: [],
        gestures: <ActionGesture>[],
        permissions: <Permissions>[],
        packages: <PackageModel>[],
      );

  static IntrinsicStates get(final NType type) {
    var result = IntrinsicStates.basic;
    for (final element in stateTypes) {
      if (element.type == type) {
        result = element;
        break;
      }
    }
    return result;
  }

  @override
  String toString() {
    return 'IntrinsicState: ntype: $type  packages: $packages';
  }
}
