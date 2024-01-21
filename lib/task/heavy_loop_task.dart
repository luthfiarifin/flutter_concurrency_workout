import 'dart:isolate';

import 'package:flutter/foundation.dart';

// A Dart class encapsulating tasks related to heavy loop computations.
class HeavyLoopTask {
  // Length of the loop for computations
  final int length;

  // Constructor to initialize the length parameter
  const HeavyLoopTask({
    required this.length,
  });

  // Asynchronously runs a computation using the compute function for isolates.
  // This function utilizes the compute function to execute the _counterLoop function
  // with the specified length in a separate isolate and returns the computed counter.
  Future<int> computeRun() async {
    // Utilizing the compute function to run _counterLoop in a separate isolate
    // and passing the length as the argument
    return await compute((message) => _counterLoop(message), length);
  }

  // Synchronously runs a computation without isolates.
  // This function directly executes the _counterLoop function with the specified length
  // and returns the computed counter.
  int normalRun() {
    return _counterLoop(length);
  }

  // Asynchronously runs a computation in a separate isolate using Isolate.spawn.
  // This function spawns an isolate, executes the _counterLoop function with the specified length,
  // sends the result back to the main isolate, and returns the computed counter.
  Future<int> isolateRun() async {
    // Creating a ReceivePort to listen for messages from the spawned isolate
    final receivePort = ReceivePort();

    // Spawning an isolate to execute the _counterLoop function
    Isolate.spawn((SendPort sendPort) {
      // Performing a computation in the spawned isolate and sending the result back
      int counter = _counterLoop(length);
      sendPort.send(counter);
    }, receivePort.sendPort);

    // Waiting for the result from the spawned isolate
    final counter = await receivePort.first;

    // Closing the ReceivePort after receiving the result
    receivePort.close();

    // Returning the computed counter to the calling code
    return counter;
  }

  // Simple function to perform a loop and return the counter value
  int _counterLoop(int length) {
    int counter = 0;

    // Simulating a computationally intensive task
    for (int i = 0; i < length; i++) {
      counter++;
    }

    // Returning the computed counter value
    return counter;
  }
}
