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
      children: <Widget>[
        const SizedBox(height: 45),
        Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.78,
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
              child: const Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        Expanded(
                          flex: 11,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.boy,
                                    color: Colors.blue,
                                    size: 24,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Nhập điểm đón ...',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                                indent: 4,
                                endIndent: 4,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.redAccent,
                                    size: 24,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Nhập điểm đến ...',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_circle,
                                color: Colors.blue,
                                size: 25.0,
                              ),
                            ],
                          ),
                        ),
                      ],
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
}
