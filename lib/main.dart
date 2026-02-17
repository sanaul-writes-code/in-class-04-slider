import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stateful Lab',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CounterWidget(),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0; // This is our STATE
  String _textFieldValue = '';
  final TextEditingController _controller = TextEditingController();
  // String _alertMessage = '';

  void _checkCounter(BuildContext context) {
    int? val = int.tryParse(_textFieldValue);
    if (val != null && val > 100) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Limit Reached!')));
      });
    }
  }

  void increment() {
    setState(() {
      _counter += 1;
    });
  }

  void reset() {
    setState(() {
      _counter = 0;
    });
  }

  void decrement() {
    setState(() {
      if (_counter > 0) {
        _counter -= 1;
      }
    });
  }

  Color get counterColor {
    if (_counter == 0) return Colors.red;
    if (_counter > 50) return Colors.green;
    return Colors.black;
  }

  void setCounter(String value) {
    int? number = int.tryParse(value);
    if (number != null) {
      setState(() {
        if (number >= 0 && number <= 100) {
          _counter = number;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkCounter(context);

    return Scaffold(
      appBar: AppBar(title: Text('Interactive Counter')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              color: Colors.blue.shade100,
              padding: EdgeInsets.all(20),
              child: Text(
                '$_counter',
                style: TextStyle(fontSize: 50.0, color: counterColor),
              ),
            ),
          ),
          SizedBox(height: 20),
          Slider(
            min: 0,
            max: 100,
            value: _counter.toDouble(),
            onChanged: (double value) {
              // 👇 This triggers the UI rebuild
              setState(() {
                _counter = value.toInt();
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: increment, child: Text('+')),
              SizedBox(width: 8),
              ElevatedButton(onPressed: reset, child: Text('Reset')),
              SizedBox(width: 8),
              ElevatedButton(onPressed: decrement, child: Text('-1')),
            ],
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter a value for counter',
              ),
              onChanged: (value) {
                setState(() {
                  _textFieldValue = value;
                });
              },
            ),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => setCounter(_textFieldValue),
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
