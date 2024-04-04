
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:powerui/ui/home/home_view.dart';

import 'injector/dependency_injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ErrorWidget.builder =
      (FlutterErrorDetails details) => errorScreen(details.exception);
  DependencyInjector().loadModules();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      showSemanticsDebugger: false,
      checkerboardOffscreenLayers: false,
      localeResolutionCallback:
          (Locale? locale, Iterable<Locale> supportedLocales) {
        if (locale != null) {
          for (Locale supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
        }
        return supportedLocales.first;
      },
      title: 'Consumption Data',
      theme: new ThemeData(
          canvasColor: Colors.transparent,
          primarySwatch: Colors.grey,
          brightness: Brightness.light
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        canvasColor: Colors.black,
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Hola'),
    );
  }
}

Widget errorScreen(dynamic detailsException) {
  return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Hubo un problema"),
      ),
      body: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Foundation.kReleaseMode
                ? const Center(
                child: Text("Oooops ahora mismo no se puede cargar la información",
                    style: TextStyle(fontSize: 24.0)))
                : SingleChildScrollView(
                child: Text('Exception Details:\n\n$detailsException')),
          )));
}