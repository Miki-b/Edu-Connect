import 'package:flutter/material.dart';

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: Navigator.of(context).canPop()
            ? IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back))
            : null,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text('$title (conversion in progress)', textAlign: TextAlign.center),
        ),
      ),
    );
  }
}

