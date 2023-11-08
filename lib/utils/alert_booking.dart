import 'dart:developer';
import 'package:flutter/material.dart';

// ignore: unused_element
Future<void> showAlertDialog(BuildContext context) async {
  return showDialog(
    barrierColor: Colors.transparent,
    context: context,
    builder: (context) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin:
              const EdgeInsets.only(top: 250), // Adjust this value as needed
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.account_circle,
                                size: 100,
                                color: Colors.blueGrey,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 30),
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "Nguyễn Đức Dương",
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "0 KM away",
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.blueGrey.shade50,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "\$30.00",
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 1,
                  indent: 40,
                  endIndent: 40,
                  height: 45,
                ),
                const SizedBox(width: 8),
                const Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 8),
                        Icon(
                          Icons.near_me,
                          color: Colors.grey, // Set the icon color to grey
                        ),
                        SizedBox(width: 8), // Add spacing between icon and text
                        Flexible(
                          child: Text(
                            '1190-Mission Street, West Somarrow 213546789',
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey, // Set the text color to grey
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1, // Adjust the number of lines
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        SizedBox(width: 8),
                        Icon(
                          Icons.location_on,
                          color: Colors.grey, // Set the icon color to grey
                        ),
                        SizedBox(width: 8), // Add spacing between icon and text
                        Flexible(
                          child: Text(
                            '1190-Mission Street, West Somarrow 123123132131',
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey, // Set the text color to grey
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1, // Adjust the number of lines
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: const AlignmentDirectional(0.00, 0.00),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          10,
                          20,
                          10,
                          10,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            // Close the dialog
                            Navigator.pop(context);
                            log("Tapped Accept Orders");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 13, 93, 240),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 60,
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            'Accept Orders',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
