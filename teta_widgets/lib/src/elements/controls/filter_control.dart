import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/code/filter.dart';

enum FilterEnum {
  equalTo,
  notEqualTo,
  lessThat,
  lessEqualThat,
  greaterThat,
  greaterEqualThat,
  matchValue,
  match,
}

extension FilterEnumExt on FilterEnum {
  String toShortString() => toString().split('.').last;

  static FilterEnum getFilterEnumFromString(final String value) {
    return FilterEnum.values.firstWhere(
      (final element) => element.toShortString() == value,
    );
  }

  String convertToSupabaseFilter() {
    switch (this) {
      case FilterEnum.equalTo:
        return 'eq';
      case FilterEnum.lessThat:
        return 'lt';
      case FilterEnum.greaterThat:
        return 'gt';
      case FilterEnum.lessEqualThat:
        return 'lte';
      case FilterEnum.notEqualTo:
        return 'neq';
      case FilterEnum.greaterEqualThat:
        return 'gte';
      case FilterEnum.match:
        return 'ilike';
      case FilterEnum.matchValue:
        return 'is';
    }

    return '';
  }
}

class FilterFieldControl extends StatefulWidget {
  final Function(List<QueryFilter> value, List<QueryFilter> old) callback;

  const FilterFieldControl({
    required this.callback,
    final Key? key,
  }) : super(key: key);

  @override
  State<FilterFieldControl> createState() => _FilterFieldControlState();
}

class _FilterFieldControlState extends State<FilterFieldControl> {
  List<QueryFilter> filters = [];

  @override
  void didChangeDependencies() {
    print('filters changed lenght: $filters');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FilterFieldControl oldWidget) {
    print('filters update lenght: $filters');

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(final BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  var old = filters;
                  filters.add(QueryFilter());
                  widget.callback.call(filters, old);
                });
              },
              child: Row(
                children: const [
                  Expanded(
                    child: Text(
                      'Add filter',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            ...List.generate(
              filters.length,
              (final index) => FilterControlTile(
                queryFilter: filters.elementAt(index),
                onChanged: (final filter) {
                  var old = filters;
                  filters[index] = filter;
                  widget.callback.call(filters, old);
                },
                onRemoved: () {
                  var old = filters;

                  setState(() {
                    filters.removeAt(index);
                  });

                  widget.callback.call(filters, old);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterControlTile extends StatefulWidget {
  const FilterControlTile({
    required this.queryFilter,
    final Key? key,
    this.onRemoved,
    required this.onChanged,
  }) : super(key: key);

  final Function()? onRemoved;
  final Function(QueryFilter) onChanged;
  final QueryFilter queryFilter;

  @override
  State<FilterControlTile> createState() => _FilterControlTileState();
}

class _FilterControlTileState extends State<FilterControlTile> {
  final TextEditingController _columnNameController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  @override
  Widget build(final BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        height: 100,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  const TParagraph('Filter', isCentered: false),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xff313131),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Column Name',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        controller: _columnNameController,
                        onChanged: (final value) {
                          setState(() {
                            widget.queryFilter.columnName = value;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 4,
                          child: CDropdown(
                            value: widget.queryFilter.filter.toShortString(),
                            items: FilterEnum.values
                                .map((final e) => e.toShortString())
                                .toList(),
                            onChange: (final p0) {
                              if (p0 != null) {
                                setState(() {
                                  widget.queryFilter.filter =
                                      FilterEnumExt.getFilterEnumFromString(p0);
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                              color: const Color(0xff313131),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: TextField(
                              decoration: const InputDecoration(
                                isDense: true,
                                hintText: 'value',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              controller: _valueController,
                              onChanged: (final value) {
                                setState(() {
                                  widget.queryFilter.value = value;
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                widget.onRemoved?.call();
              },
              icon: const Icon(
                Icons.horizontal_rule,
                color: Colors.white,
              ),
            ),
          ],
        ));
  }
}
