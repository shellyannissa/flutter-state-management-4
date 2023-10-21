import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        // useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

String now() => DateTime.now().toIso8601String();

@immutable
class Minutes {
  final String value;
  Minutes() : value = now();
}

@immutable
class Seconds {
  final String value;
  Seconds() : value = now();
}

class SecondsWidget extends StatelessWidget {
  const SecondsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final seconds = context.watch<Seconds>();
    return Expanded(
        child: Container(
            color: Colors.yellow,
            height: 100,
            child: Column(
              children: [const Text('Seconds'), Text(seconds.value)],
            )));
  }
}

class MinutesWidget extends StatelessWidget {
  const MinutesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final minutes = context.watch<Minutes>();
    return Expanded(
        child: Container(
            color: Colors.green,
            height: 100,
            child: Column(
              children: [const Text('Minutes'), Text(minutes.value)],
            )));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.blue,
        elevation: 2.0,
      ),
      body: MultiProvider(
          providers: [
            StreamProvider.value(
              value: Stream<Seconds>.periodic(
                const Duration(seconds: 1),
                (_) => Seconds(),
              ),
              initialData: Seconds(),
            ),
            StreamProvider.value(
              value: Stream<Minutes>.periodic(
                const Duration(minutes: 1),
                (_) => Minutes(),
              ),
              initialData: Minutes(),
            ),
          ],
          child: const Column(children: [
            Row(children: [SecondsWidget(), MinutesWidget()])
          ])),
    );
  }
}
