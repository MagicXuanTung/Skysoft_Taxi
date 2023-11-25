import 'package:flutter/material.dart';
import 'package:skysoft_taxi/widgets/user/stars.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';

class Reviews extends StatefulWidget {
  final Function onClose;
  final PanelController panelController;
  const Reviews(
      {super.key, required this.onClose, required this.panelController});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  int numberOfStars = 0;
  ScrollController controller = ScrollController();
  double opacity = 0.0;

  PointButton goodDriving = PointButton("Good Driving", Colors.grey[200]!,
      Colors.green[200]!, Colors.grey[500]!, Colors.green[500]!);
  PointButton goodRouting = PointButton("Good Routing", Colors.grey[200]!,
      Colors.green[200]!, Colors.grey[500]!, Colors.green[500]!);
  PointButton cleanCar = PointButton("Clean Car", Colors.grey[200]!,
      Colors.green[200]!, Colors.grey[500]!, Colors.green[500]!);
  PointButton polite = PointButton("Polite", Colors.grey[200]!,
      Colors.green[200]!, Colors.grey[500]!, Colors.green[500]!);

  PointButton badDriving = PointButton("Bad Driving", Colors.grey[200]!,
      Colors.red[200]!, Colors.grey[500]!, Colors.red[500]!);
  PointButton badRouting = PointButton("Bad Routing", Colors.grey[200]!,
      Colors.red[200]!, Colors.grey[500]!, Colors.red[500]!);
  PointButton dirtyCar = PointButton("Dirty Car", Colors.grey[200]!,
      Colors.red[200]!, Colors.grey[500]!, Colors.red[500]!);
  PointButton impolite = PointButton("Impolite", Colors.grey[200]!,
      Colors.red[200]!, Colors.grey[500]!, Colors.red[500]!);

  void handleSelectStar(int index) {
    numberOfStars = index;
    setState(() {});
  }

  void unSelect(PointButton button) {
    if (button.isSelect) {
      button.isSelect = !button.isSelect;
    }
  }

  void showNotification(String mes, BuildContext context) {
    SnackBar snackBar = SnackBar(
      content: Text(mes),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        opacity = 1.0;
      });
    });
    controller.addListener(() {
      if (controller.position.pixels > 0) {
        widget.panelController.open();
      } else {
        widget.panelController.close();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 20,
              child: GestureDetector(
                onTap: () {
                  if (widget.panelController.isPanelOpen) {
                    widget.panelController.close();
                  } else {
                    widget.panelController.open();
                  }
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Icon(
                        Icons.horizontal_rule,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                controller: controller,
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Text(
                      'How was your ride?',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                            'Help us improve your experience by rating your driver',
                            style: TextStyle(fontSize: 18)),
                        StarsWidget(
                          numberOfStars: numberOfStars,
                          size: 50,
                          onClick: ((index) => handleSelectStar(index)),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Icon(Icons.heart_broken_rounded),
                                    Text("Nice Poins"),
                                    buidButton(goodDriving, () {
                                      goodDriving.isSelect =
                                          !goodDriving.isSelect;
                                      unSelect(badDriving);
                                      setState(() {});
                                      print(goodDriving.title);
                                    }),
                                    buidButton(goodRouting, () {
                                      goodRouting.isSelect =
                                          !goodRouting.isSelect;
                                      unSelect(badRouting);
                                      setState(() {});
                                      print(goodRouting.title);
                                    }),
                                    buidButton(cleanCar, () {
                                      cleanCar.isSelect = !cleanCar.isSelect;
                                      unSelect(dirtyCar);
                                      setState(() {});
                                      print(cleanCar.title);
                                    }),
                                    buidButton(polite, () {
                                      polite.isSelect = !polite.isSelect;
                                      unSelect(impolite);
                                      setState(() {});
                                      print(polite.title);
                                    }),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Icon(Icons.heart_broken_rounded),
                                    Text("Negative Poins"),
                                    buidButton(badDriving, () {
                                      badDriving.isSelect =
                                          !badDriving.isSelect;
                                      unSelect(goodDriving);
                                      setState(() {});
                                      print(badDriving.title);
                                    }),
                                    buidButton(badRouting, () {
                                      badRouting.isSelect =
                                          !badRouting.isSelect;
                                      unSelect(goodRouting);
                                      setState(() {});
                                      print(badRouting.title);
                                    }),
                                    buidButton(dirtyCar, () {
                                      dirtyCar.isSelect = !dirtyCar.isSelect;
                                      unSelect(cleanCar);
                                      setState(() {});
                                      print(dirtyCar.title);
                                    }),
                                    buidButton(impolite, () {
                                      impolite.isSelect = !impolite.isSelect;
                                      unSelect(polite);
                                      setState(() {});
                                      print(impolite.title);
                                    }),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text("Add Comment"),
                      ),
                      TextFormField(
                        minLines: 5,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Write comment',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                showNotification(
                                    "Đã gửi FeedBack thành công.!", context);
                                print('Send FeedBack');
                                widget.onClose();
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )),
                              ),
                              child: Text('Send FeedBack'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buidButton(PointButton button, onClick) {
    Color colorButton = button.normalButton;
    Color colorText = button.normalText;

    if (button.isSelect) {
      colorButton = button.activeButton;
      colorText = button.activeText;
    }

    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              onClick();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(colorButton),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              )),
            ),
            child: Text(
              button.title,
              style: TextStyle(color: colorText),
            ),
          ),
        ),
      ],
    );
  }
}

class SelectColors {
  Color colorButton = Colors.grey[200]!;
  Color colorText = Colors.grey[500]!;
  Color colorButtonAction = Colors.green[200]!;
  Color colorTextAction = Colors.green[500]!;
}

class PointButton {
  String title;
  Color normalButton;
  Color activeButton;
  Color normalText;
  Color activeText;
  bool isSelect = false;
  PointButton(this.title, this.normalButton, this.activeButton, this.normalText,
      this.activeText);
}
