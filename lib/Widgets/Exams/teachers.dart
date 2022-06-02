import 'package:flutter/material.dart';

class Teachers extends StatelessWidget {
  const Teachers({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Teachers'),
        ),
        body: ListView(padding: EdgeInsets.all(8), children: [
          Card(
            child: ListTile(
              title: Text(
                'Teacher 1',
              ),
              trailing: Icon(Icons.call),
            ),
          ),
          Card
          (
            child: ListTile(
              title: Text('Teacher 1'),
              trailing: Icon(Icons.call),
            ),
          )
        ]));
  }
}
