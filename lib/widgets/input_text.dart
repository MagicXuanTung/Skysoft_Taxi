import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  final TextEditingController pickupController;
  final TextEditingController destinationController;
  final void Function() onBack;

  const InputText({
    Key? key,
    required this.pickupController,
    required this.destinationController,
    required this.onBack,
  }) : super(key: key);

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
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
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildTextField(
                      controller: widget.pickupController,
                      prefixIcon: const Icon(
                        Icons.boy,
                        color: Colors.blue,
                        size: 24, // Adjust the size to fit well
                      ),
                      hintText: 'Nhập điểm đón ...',
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.cyan,
                      indent: 5,
                      endIndent: 5,
                    ),
                    buildTextField(
                      controller: widget.destinationController,
                      prefixIcon: const Icon(
                        Icons.location_on,
                        color: Colors.redAccent,
                        size: 24, // Adjust the size to fit well
                      ),
                      hintText: 'Nhập điểm đến ...',
                    ),
                  ],
                ),
              ),
            ),
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
        prefixIconConstraints: const BoxConstraints(
          minWidth: 40, // Adjust the width of the icon container
          minHeight: 40, // Adjust the height of the icon container
        ),
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(
            vertical: 12, horizontal: 16), // Adjust padding as needed
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
}
