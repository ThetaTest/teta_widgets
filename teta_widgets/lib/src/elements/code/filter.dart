import 'package:teta_widgets/src/elements/controls/filter_control.dart';

class QueryFilter {
  String columnName;
  FilterEnum filter;
  String value;

  QueryFilter({this.columnName = '',
    this.filter = FilterEnum.equalTo,
    this.value = '',});
}
