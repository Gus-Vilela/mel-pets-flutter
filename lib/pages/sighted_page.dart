import 'package:flutter/material.dart';

class SightedPage extends StatefulWidget {
  const SightedPage({super.key});

  @override
  State<SightedPage> createState() => _SightedPageState();
}

class _SightedPageState extends State<SightedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[100],
        title: const Text('Mel Pets'),
      ),
    );
  }
}
