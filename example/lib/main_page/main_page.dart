import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Clove UI Flutter Example'),
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/complex_painter');
            },
            child: Text('Complext Painter'),
          ),
        ],
      ),
    );
  }
}
