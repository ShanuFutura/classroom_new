import 'package:flutter/material.dart';

class Teachers extends StatelessWidget {
  const Teachers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teachers'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: const [
          Card(
            child: ListTile(
              title: Text(
                'Teacher 1',
              ),
              trailing: Icon(Icons.call),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Teacher 1'),
              trailing: Icon(Icons.call),
            ),
          )
        ],
      ),
    );
  }
}
