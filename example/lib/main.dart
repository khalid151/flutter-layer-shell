import 'package:flutter/material.dart';
import 'package:flutter_layer_shell/flutter_layer_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterLayerShell.configure(edge: LayerShellEdge.TOP, size: 65);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, background: Colors.transparent),
        useMaterial3: true,
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
      ),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: Colors.black87,
              child: Center(
                child: Position(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Size extends StatefulWidget {
  const Size({super.key});

  @override
  State<Size> createState() => _SizeState();
}

class _SizeState extends State<Size> {
  double _currentSliderValue = 65;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Slider(
          value: _currentSliderValue,
          max: 100,
          min: 20,
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
              FlutterLayerShell.changeSize(value.toInt());
            });
          },
        ),
        Text('${_currentSliderValue.toInt()}'),
      ],
    );
  }
}

class Position extends StatefulWidget {
  const Position({super.key});

  @override
  State<Position> createState() => _PositionState();
}

class _PositionState extends State<Position> {
  LayerShellEdge? _edge = LayerShellEdge.TOP;

  bool _isHorizontal() {
    return _edge == LayerShellEdge.TOP || _edge == LayerShellEdge.BOTTOM;
  }

  Widget _radioButton(LayerShellEdge edge, IconData icon) => ClipRect(
        child: Row(
          children: [
            Radio<LayerShellEdge>(
              value: edge,
              groupValue: _edge,
              onChanged: (LayerShellEdge? value) =>
                  setState(() => _edge = value),
            ),
            Icon(icon, size: 20, color: Colors.white),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    FlutterLayerShell.changePosition(_edge ?? LayerShellEdge.TOP);
    return Flex(
      direction: _isHorizontal() ? Axis.horizontal : Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _radioButton(LayerShellEdge.TOP, Icons.arrow_upward),
        _radioButton(LayerShellEdge.BOTTOM, Icons.arrow_downward),
        _radioButton(LayerShellEdge.LEFT, Icons.arrow_back),
        _radioButton(LayerShellEdge.RIGHT, Icons.arrow_forward),
        RotatedBox(quarterTurns: _isHorizontal() ? 0 : 1, child: Size()),
      ],
    );
  }
}
