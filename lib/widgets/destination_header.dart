import 'package:flutter/material.dart';
import 'package:skysoft_taxi/screen/user_ui/tim_diem_den_nhanh.dart';

class DestinationHeader extends StatefulWidget {
  final TextEditingController pickupController;
  final TextEditingController destinationController;
  final void Function() onBack;

  const DestinationHeader({
    Key? key,
    required this.pickupController,
    required this.destinationController,
    required this.onBack,
    required Null Function() navigateToQuickFindPlaces,
  }) : super(key: key);

  @override
  State<DestinationHeader> createState() => _DestinationHeaderState();
}

class _DestinationHeaderState extends State<DestinationHeader> {
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
                'Chọn điểm đến ',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: <Widget>[
                      buildTextField(
                        controller: widget.pickupController,
                        prefixIcon: const Icon(
                          Icons.boy,
                          color: Colors.blue,
                        ),
                        hintText: 'Nhập điểm đón ...',
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.cyan,
                        indent: 20,
                        endIndent: 20,
                      ),
                      buildTextField(
                        controller: widget.destinationController,
                        prefixIcon: const Icon(
                          Icons.location_on,
                          color: Colors.orangeAccent,
                        ),
                        hintText: 'Nhập điểm đến ...',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 44,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildIconContainer(
                      icon: const Icon(Icons.map),
                      text: 'Chọn điểm đến',
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
  }) {
    return TextField(
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
    );
  }

  Widget buildIconContainer({required Icon icon, required String text}) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return const QuickFindPlaces();
            },
          ),
        );
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon.icon,
              color: Colors.black,
              size: 20,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
