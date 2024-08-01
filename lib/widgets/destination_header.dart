import 'package:flutter/material.dart' hide ReorderableList;
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';

class DestinationHeader extends StatefulWidget {
  final TextEditingController pickupController;
  final List<TextEditingController> destinationControllers;
  final bool showDragHandle;
  final VoidCallback addDestinationField;

  const DestinationHeader({
    Key? key,
    required this.pickupController,
    required this.destinationControllers,
    required this.showDragHandle,
    required this.addDestinationField,
    required bool isAddDestinationVisible,
  }) : super(key: key);

  @override
  State<DestinationHeader> createState() => _DestinationHeaderState();
}

class _DestinationHeaderState extends State<DestinationHeader> {
  @override
  void initState() {
    super.initState();
    if (widget.destinationControllers.isEmpty) {
      widget.destinationControllers.add(TextEditingController());
    }
  }

  void _removeDestinationField(int index) {
    if (widget.destinationControllers.length > 1) {
      setState(() {
        widget.destinationControllers[index].dispose();
        widget.destinationControllers.removeAt(index);
        if (widget.destinationControllers.isEmpty) {
          widget.destinationControllers.add(TextEditingController());
        }
      });
    }
  }

  int _indexOfKey(Key key) {
    return widget.destinationControllers
        .indexWhere((controller) => ValueKey(controller) == key);
  }

  bool _reorderCallback(Key item, Key newPosition) {
    int draggingIndex = _indexOfKey(item);
    int newPositionIndex = _indexOfKey(newPosition);

    final draggedItem = widget.destinationControllers[draggingIndex];
    setState(() {
      widget.destinationControllers.removeAt(draggingIndex);
      widget.destinationControllers.insert(newPositionIndex, draggedItem);
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
                        SizedBox(
                          height: widget.destinationControllers.length * 45,
                          child: ReorderableList(
                            onReorder: _reorderCallback,
                            child: CustomScrollView(
                              slivers: [
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                      return ReorderableItem(
                                        key: ValueKey(widget
                                            .destinationControllers[index]),
                                        childBuilder: (context, state) =>
                                            buildTextField(
                                          key: ValueKey(widget
                                              .destinationControllers[index]),
                                          controller: widget
                                              .destinationControllers[index],
                                          prefixIcon: const Icon(
                                            Icons.location_on,
                                            color: Colors.redAccent,
                                            size: 25,
                                          ),
                                          hintText:
                                              'Nhập điểm đến ${index + 1} ...',
                                          onRemove: widget
                                                      .destinationControllers
                                                      .length >
                                                  1
                                              ? () =>
                                                  _removeDestinationField(index)
                                              : null,
                                          isDestinationField: true,
                                          state: state,
                                        ),
                                      );
                                    },
                                    childCount:
                                        widget.destinationControllers.length,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (widget.destinationControllers.length < 3)
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildIconContainer(
                        icon: const Icon(Icons.add_location_alt),
                        text: 'Thêm điểm đến',
                        onTap: widget.addDestinationField,
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
    ReorderableItemState? state,
    Key? key,
    VoidCallback? onRemove,
  }) {
    final bool shouldShowDragHandle = widget.showDragHandle &&
        isDestinationField &&
        widget.destinationControllers.length > 1;

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
                border: InputBorder.none, // Remove the border
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
          if (onRemove != null)
            IconButton(
              icon: const Icon(Icons.remove_circle_outline, color: Colors.grey),
              onPressed: onRemove,
            ),
          if (shouldShowDragHandle)
            ReorderableListener(
              child: const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.drag_handle, color: Colors.grey),
              ),
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
              size: 20,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
