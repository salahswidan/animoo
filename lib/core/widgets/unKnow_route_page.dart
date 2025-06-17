import 'package:flutter/material.dart';

class UnknowRoutePage extends StatelessWidget {
  const UnknowRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unknown Route'),
      ),
      body: const Center(
        child: Text('Unknown Route'),
      ),
    );
  }
}