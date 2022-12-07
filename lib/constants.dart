import 'package:flutter/foundation.dart' as Foundation;

const List<String> defaultWidgetOrder = [
  'workorders',
  'insight',
  'cyclecounts'
];

const apiurl =
    Foundation.kReleaseMode ? "api.ahern.com" : "devlnxrocket01.ahern.com";
