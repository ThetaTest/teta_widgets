import 'package:teta_repositories/teta_repositories.dart';
import 'package:teta_widgets/src/elements/index.dart';

class ReorderChildren {
  static void reorder(
    final CNode node,
    final List<CNode> children,
    final int oldIndex,
    final int newIndex,
  ) {
    final child = children.removeAt(oldIndex);
    children.insert(newIndex, child);
    final id = node.childrenIds.ids.removeAt(oldIndex);
    node.childrenIds.ids.insert(newIndex, id);
    NodeRepository.changeNode(
      node: node,
    );
  }
}
