# flutter_faro

Packages `faro_dart` in a way that it can be consumed nicely in a flutter app.

## Example

```dart
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_faro/flutter_faro.dart';

Future<void> main() async {
  await FlutterFaro.init(
        (options) {
          // change this to your collector URL
          options.collectorUrl = Uri.parse("https://example.com/collector");
        },
    // Init your App.
    appRunner: () => runApp(MyApp()),
  );
}
```