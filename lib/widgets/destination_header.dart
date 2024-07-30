import 'package:flutter/material.dart';

class DestinationHeader extends StatefulWidget {
  final TextEditingController pickupController;
  final TextEditingController destinationController;
  final void Function() onBack;

  const DestinationHeader({
    Key? key,
    required this.pickupController,
    required this.destinationController,
    required this.onBack,
  }) : super(key: key);

  @override
  State<DestinationHeader> createState() => _DestinationHeaderState();
}

class _DestinationHeaderState extends State<DestinationHeader> {
  final List<TextEditingController> _destinationControllers = [];

  @override
  void initState() {
    super.initState();
    // Initialize with the existing destinationController
    _destinationControllers.add(widget.destinationController);
  }

  void _addDestinationField() {
    if (_destinationControllers.length < 3) {
      setState(() {
        _destinationControllers.add(TextEditingController());
      });
    }
  }

  void _removeDestinationField(int index) {
    if (_destinationControllers.length > 1) {
      setState(() {
        _destinationControllers[index].dispose();
        _destinationControllers.removeAt(index);
      });
    }
  }

  @override
  void dispose() {
    // Dispose all controllers
    for (var controller in _destinationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final TextEditingController item =
          _destinationControllers.removeAt(oldIndex);
      _destinationControllers.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: widget.onBack,
              ),
              const Text(
                'Chọn điểm đến',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.grey.shade200,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.grey.shade200,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        buildTextField(
                          key: ValueKey(widget.pickupController),
                          controller: widget.pickupController,
                          prefixIcon: const Icon(
                            Icons.boy,
                            color: Colors.blue,
                            size: 25,
                          ),
                          hintText: 'Nhập điểm đón ...',
                          isDestinationField: false,
                        ),
                        const Divider(
                          thickness: 1,
                          color: Colors.cyan,
                          indent: 5,
                          endIndent: 5,
                        ),
                        ReorderableListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          onReorder: _onReorder,
                          children: _destinationControllers
                              .asMap()
                              .entries
                              .map((entry) {
                            int index = entry.key;
                            TextEditingController controller = entry.value;
                            return buildTextField(
                              key: ValueKey(controller),
                              controller: controller,
                              prefixIcon: const Icon(
                                Icons.location_on,
                                color: Colors.redAccent,
                                size: 25,
                              ),
                              hintText: 'Nhập điểm đến ${index + 1} ...',
                              onRemove: _destinationControllers.length > 1
                                  ? () => _removeDestinationField(index)
                                  : null,
                              isDestinationField:
                                  _destinationControllers.length > 1,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 44,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildIconContainer(
                      icon: const Icon(Icons.add_location_alt),
                      text: 'Thêm điểm đến',
                      onTap: _addDestinationField,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required Icon prefixIcon,
    required String hintText,
    required bool isDestinationField,
    Key? key,
    VoidCallback? onRemove, // Optional remove icon callback
  }) {
    return Container(
      key: key,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: (text) {
                setState(() {});
              },
              decoration: InputDecoration(
                prefixIcon: prefixIcon,
                hintText: hintText,
                border: InputBorder.none,
                suffixIcon: controller.text.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          controller.clear();
                          setState(() {});
                        },
                        child: const Icon(Icons.clear),
                      )
                    : null,
              ),
            ),
          ),
          if (onRemove != null) // Only show remove icon if onRemove is not null
            IconButton(
              icon: const Icon(Icons.remove_circle_outline, color: Colors.grey),
              onPressed: onRemove,
            ),
          if (isDestinationField &&
              _destinationControllers.length >
                  1) // Only show drag handle for destination fields and if there are more than one
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.drag_handle, color: Colors.grey),
            ),
        ],
      ),
    );
  }

  Widget buildIconContainer({
    required Icon icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon.icon,
              color: Colors.redAccent,
              size: 23,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.redAccent,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
