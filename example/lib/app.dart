import 'package:clove_ui_flutter_example/complex_painter/complex_painter.dart';
import 'package:clove_ui_flutter_example/main_page/main_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      initialRoute: '/main',
      routes: {
        '/main': (_) => MainPage(),
        '/complex_painter': (_) => ComplexPainterExample(),
      },
    );
  }
}
