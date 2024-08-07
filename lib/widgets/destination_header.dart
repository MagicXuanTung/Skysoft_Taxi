import 'dart:async';
import 'package:flutter/material.dart' hide ReorderableList;
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:latlong2/latlong.dart';
import 'package:skysoft_taxi/util/location_service.dart';

class DestinationHeader extends StatefulWidget {
  final TextEditingController pickupController;
  final List<TextEditingController> destinationControllers;
  final bool showDragHandle;
  final VoidCallback addDestinationField;
  final Function(String) pickUpSearch;
  final Function(String) destinationSearch;

  const DestinationHeader({
    Key? key,
    required this.pickupController,
    required this.destinationControllers,
    required this.showDragHandle,
    required this.addDestinationField,
    required this.pickUpSearch,
    required this.destinationSearch,
  }) : super(key: key);

  @override
  State<DestinationHeader> createState() => _DestinationHeaderState();
}

class _DestinationHeaderState extends State<DestinationHeader> {
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      LatLng currentLocation = await getCurrentLocation();
      String locationDetails = await fetchLocationDetails(
          currentLocation.latitude, currentLocation.longitude);
      widget.pickupController.text = locationDetails;
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
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
                          hintText: 'Nhập điểm đón ...',
                          isDestinationField: false,
                          imagePath: 'assets/icons/human_icon.png',
                          searchFunction: widget.pickUpSearch,
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
                                          hintText: widget
                                                      .destinationControllers
                                                      .length ==
                                                  1
                                              ? 'Nhập điểm đến'
                                              : 'Nhập điểm đến ${index + 1} ...',
                                          onRemove: widget
                                                      .destinationControllers
                                                      .length >
                                                  1
                                              ? () =>
                                                  _removeDestinationField(index)
                                              : null,
                                          isDestinationField: true,
                                          state: state,
                                          imagePath: widget
                                                      .destinationControllers
                                                      .length ==
                                                  1
                                              ? 'assets/icons/location_on.png'
                                              : 'assets/icons/point_${index + 1}.png',
                                          searchFunction:
                                              widget.destinationSearch,
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
                GestureDetector(
                  onTap: widget.addDestinationField,
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
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
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    required bool isDestinationField,
    ReorderableItemState? state,
    Key? key,
    VoidCallback? onRemove,
    required String imagePath,
    required Function(String) searchFunction,
  }) {
    final bool shouldShowDragHandle = widget.showDragHandle &&
        isDestinationField &&
        widget.destinationControllers.length > 1;

    return Container(
      key: key,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: 8.0), // Space between TextField and image
            child: Image.asset(
              imagePath,
              width: 22, // Image size
              height: 22,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: (text) {
                if (_debounce?.isActive ?? false) _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 300), () {
                  searchFunction(
                      controller.text); // Use search function passed in
                });
              },
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                suffixIcon: controller.text.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          controller.clear();
                          searchFunction(
                              ''); // Clear search results when clearing the text
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
              onPressed: () {
                onRemove();
                searchFunction(''); // Clear search results when removing field
              },
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
      behavior: HitTestBehavior.translucent,
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
