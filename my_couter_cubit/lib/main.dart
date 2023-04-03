import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_couter_cubit/counter/counter_cubit.dart';
import 'package:my_couter_cubit/other_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Flutter MyCounter Cubit',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CounterCubit, CounterState>(
        listener: (context, state) {
          if (state.counter == 3) {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                content: Text('Counter is ${state.counter}'),
              ),
            );
          } else if (state.counter == -1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const OtherPage(),
              ),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: Text(
              '${state.counter}',
              style: const TextStyle(
                fontSize: 52.0,
              ),
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().increment(),
            heroTag: 'increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 10.0,
          ),
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().decrement(),
            heroTag: 'decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
