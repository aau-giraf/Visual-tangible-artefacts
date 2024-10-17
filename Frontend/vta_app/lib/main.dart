import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

var myMargin = const EdgeInsets.all(3);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Horizontal List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: const Align(
          alignment: Alignment.bottomCenter,
          child: DynamicListView(),
        ),
      ),
    );
  }
}

class DynamicListView extends StatefulWidget {
  const DynamicListView({super.key});

  @override
  _DynamicListViewState createState() => _DynamicListViewState();
}

class _DynamicListViewState extends State<DynamicListView> {
  // List to hold the containers
  final List<Widget> _containers = [
    Container(
      width: 160,
      color: Colors.red,
      margin: myMargin,
    ),
    Container(
      width: 160,
      color: Colors.blue,
      margin: myMargin,
    ),
    Container(
      width: 160,
      color: Colors.green,
      margin: myMargin,
    ),
    Container(
      width: 160,
      color: Colors.yellow,
      margin: myMargin,
    ),
  ];

  // Boolean to track whether the remove buttons are visible
  bool _showRemoveButtons = false;

  // Method to add a new container
  void _addContainer() {
    setState(() {
      _containers.add(
        Container(
          width: 160,
          color: Colors.purple, // You can change this color
          margin: myMargin,
        ),
      );
    });
  }

  // Method to remove a container at a specific index
  void _removeContainer(int index) {
    setState(() {
      if (_containers.isNotEmpty && index < _containers.length) {
        _containers.removeAt(index);
      }
    });
  }

  // Method to toggle the visibility of the remove buttons
  void _toggleRemoveButtons() {
    setState(() {
      _showRemoveButtons = !_showRemoveButtons;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          // Render existing containers with optional remove button
          ...List.generate(_containers.length, (index) {
            return Stack(
              alignment: Alignment.topRight,
              children: [
                _containers[index],
                // Conditionally show the remove button
                if (_showRemoveButtons)
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.white),
                      onPressed: () => _removeContainer(index), // Remove the container
                    ),
                  ),
              ],
            );
          }),
          // The "Add Container" button
          Container(
            width: 160,
            margin: myMargin,
            child: ElevatedButton(
              onPressed: _addContainer, // Add a new container
              child: const Text("Add Container"),
            ),
          ),
          // The toggle button for enabling/disabling remove buttons
          Container(
            width: 160,
            margin: myMargin,
            child: ElevatedButton(
              onPressed: _toggleRemoveButtons, // Toggle visibility of remove buttons
              child: Text(_showRemoveButtons ? "Hide Remove" : "Show Remove"),
            ),
          ),
        ],
      ),
    );
  }
}
