// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';

/// [FChildrenIds] is a set of functions to save children' ids
class FChildrenIds {
  /// Constructor
  FChildrenIds({this.ids = const []});

  /// The value in List<String> of [FChildrenIds]
  List<int> ids;

  /// Get [ids] list
  List<int> get get => ids;

  /// Add new element in the beginning of the list [ids] (position 0)
  void addAt0(int newNid) {
    ids = [newNid, ...ids];
  }

  /// Add new element [newNid]
  void add(int newNid) {
    ids = <int>[...ids, newNid];
  }

  /// Replace a [targetNid] with [newNid]
  void replace(int newNid, int targetNid) {
    final index = ids.indexOf(targetNid);
    if (index != -1) {
      ids.insert(index + 1, newNid);
    }
  }

  /// Remove [nid] from [ids] list
  void remove(int? nid) {
    ids.remove(nid);
  }

  /// Instantiate [FChildrenIds] from Json
  static FChildrenIds fromJson(Map<String, dynamic>? json) {
    if (json == null) return FChildrenIds();
    try {
      return FChildrenIds(
        ids: (json[DBKeys.childrenIds] as List<dynamic>).cast<int>(),
      );
    } catch (e) {
      return FChildrenIds();
    }
  }

  /// Convert [FChildrenIds] to Json
  /// Returns a List<String> with all ids
  List<int> toJson() {
    return ids.toSet().toList();
  }

  /// Clone [FChildrenIds] (deep copy)
  FChildrenIds clone() => FChildrenIds(ids: ids);

  /// Clone [FChildrenIds] (deep copy) with optional [ids] attribute
  FChildrenIds copyWith({List<int>? ids}) => FChildrenIds(ids: ids ?? this.ids);
}
