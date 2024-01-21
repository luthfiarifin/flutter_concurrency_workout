import 'package:flutter/material.dart';
import 'package:flutter_ui_jank_optimization/task/heavy_loop_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final task = const HeavyLoopTask(length: 10000000000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flutter Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: _runNormal,
              child: const Text('Run with Normal Proccess'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _runWithIsolate,
              child: const Text('Run with Isolate'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _runWithCompute,
              child: const Text('Run with Compute'),
            ),
          ],
        ),
      ),
    );
  }

  void _runNormal() {
    int counter = task.normalRun();
    _showSnackbar(counter);
  }

  void _runWithIsolate() async {
    int counter = await task.isolateRun();
    _showSnackbar(counter);
  }

  void _runWithCompute() async {
    int counter = await task.computeRun();
    _showSnackbar(counter);
  }

  void _showSnackbar(int counter) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Result $counter'),
      ),
    );
  }
}
