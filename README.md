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

## Optional instrumentation

### User Interactions

In order to observe interactions with widgets that have a `key`,
wrap bottom most widget in the `FaroUserInteraction` widget.

#### Example
```dart
import 'package:flutter_faro/flutter_faro.dart';

Future<void> main() async {
  await FlutterFaro.init(
    (options) {
      // change this to your collector URL
      options.collectorUrl = Uri.parse("https://your-collector.com/collect");
    },
    // Init your App and wrap it in the `FaroUserInteraction` widget
    appRunner: () => runApp(FaroUserInteractionWidget(child: const MyApp())),
  );
}
```
