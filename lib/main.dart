import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'random_color.dart';

RandomColor randomColor = RandomColor();
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangeColor>(
      create: (_) => ChangeColor(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyChangePage(),
      ),
    );
  }
}

class MyChangePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ChangeColor _state = Provider.of<ChangeColor>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change color with provider',
          style: TextStyle(
            color: _state.colour, // Color here
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              color: _state.colour, // Color here
              width: 200,
              height: 200,
              duration: Duration(seconds: 1),
            ),
            Switch.adaptive(
                value: _state.switcher,
                onChanged: (bool value) {
                  _state.changeColor();
                  _state.switcher = value;
                })
          ],
        ),
      ),
    );
  }
}

class ChangeColor extends ChangeNotifier {
  bool switcher = false;
  Color colour;

  Color changeColor() {
    notifyListeners();
    colour = randomColor.generationColor();
    return colour;
  }
}
