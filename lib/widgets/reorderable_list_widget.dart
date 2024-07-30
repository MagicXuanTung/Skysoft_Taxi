import 'package:flutter/material.dart';

class ReorderableListWidget extends StatefulWidget {
  final List<String> items;

  const ReorderableListWidget({Key? key, required this.items})
      : super(key: key);

  @override
  _ReorderableListWidgetState createState() => _ReorderableListWidgetState();
}

class _ReorderableListWidgetState extends State<ReorderableListWidget> {
  List<String> _list = [];

  @override
  void initState() {
    super.initState();
    _list = List.from(widget.items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ReorderableListView(
        children: _list
            .map((item) => ListTile(
                  key: Key(item),
                  title: Text(item),
                  trailing: const Icon(Icons.menu),
                ))
            .toList(),
        onReorder: (int start, int current) {
          // dragging from top to bottom
          if (start < current) {
            int end = current - 1;
            String startItem = _list[start];
            int i = 0;
            int local = start;
            do {
              _list[local] = _list[++local];
              i++;
            } while (i < end - start);
            _list[end] = startItem;
          }
          // dragging from bottom to top
          else if (start > current) {
            String startItem = _list[start];
            for (int i = start; i > current; i--) {
              _list[i] = _list[i - 1];
            }
            _list[current] = startItem;
          }
          setState(() {});
        },
      ),
    );
  }
}
