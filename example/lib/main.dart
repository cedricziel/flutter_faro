import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_faro/flutter_faro.dart';

Future<void> main() async {
  await FlutterFaro.init(
        (options) {
      options.collectorUrl = Uri.parse("https://example.com/collector");
    },
    // Init your App.
    appRunner: () => runApp(FaroUserInteractionWidget(child: const MyApp())),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _count = 0;

  @override
  void initState() {
    super.initState();

    FlutterFaro.pushView("MyApp");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [
        FaroNavigatorObserver(),
      ],
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ListView(
            children: [
              const Row(
                children: [Expanded(child: Text('Hello!'))],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.abc_outlined),
                    onPressed: () {},
                    key: const Key('Call To Action Small'),
                  ),
                  ElevatedButton(
                      key: const Key('Call To Action Big'),
                      onPressed: () {
                        setState(() {
                          _count++;
                        });

                        FlutterFaro.pushMeasurement("clicks", _count);
                        FlutterFaro.pushEvent("click", {
                          "clicks": "$_count",
                        });

                        FlutterFaro.pushLog('Tata! $_count');
                      },
                      child: const Text("Push Me"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
